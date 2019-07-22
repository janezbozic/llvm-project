# This script generates all variants of wmma builtins, verifies that clang calls
# correct LLVM instrinsics, and checks that availability of specific builtins is
# constrained by the correct PTX version and the target GPU variant.

# Dummy test run to avoid lit warnings.
# RUN: echo "This is not a real test. It's a generator for builtins-nvpts-mma.cu" >/dev/null

from __future__ import print_function

import argparse
from collections import defaultdict
from itertools import product
from string import Template

class MMAFrag:
  def __init__(self, geom, frag, ptx_elt_type):
    self.geom = geom
    self.frag = frag
    self.ptx_type = ptx_elt_type;

  def __repr__(self):
    return "%s:%s:%s" % (self.geom, self.frag, self.ptx_type)

class MMAOp:
  def __init__(self, a, b, c, d):
    self.a = a
    self.b = b
    self.c = c
    self.d = d

  def __repr__(self):
    return ("{A:%s, B:%s, C:%s, D:%s}" % (self.a, self.b, self.c, self.d ))

def make_mma_ops(geoms, types_a, types_b, types_c, types_d):
  ops = []
  for geom, type_a, type_c in product( geoms,  types_a, types_c):
    for type_b, type_d in product(types_b if types_b else [type_a],
                                  types_d if types_d else [type_c]):
      ops.append(MMAOp(MMAFrag(geom, "a", type_a),
                       MMAFrag(geom, "b", type_b),
                       MMAFrag(geom, "c", type_c),
                       MMAFrag(geom, "d", type_d)))
  return ops

def make_ldst_ops(geoms, frags, types):
  return [MMAFrag(geom, frag, ptx_type) for (geom, frag, ptx_type)
          in product(geoms, frags, types)]

def get_mma_ops():
  return (make_mma_ops(["m16n16k16", "m32n8k16", "m8n32k16"],
                       ["f16"], [], ["f16", "f32"], ["f16", "f32"]) +
          make_mma_ops(["m16n16k16", "m32n8k16", "m8n32k16"],
                       ["s8", "u8"], [], ["s32"], []) +
          make_mma_ops(["m8n8k32"],
                       ["s4", "u4"], [], ["s32"], []) +
          make_mma_ops(["m8n8k128"],
                       ["b1"], [], ["s32"], []))
def get_ldst_ops():
  return (make_ldst_ops(["m16n16k16", "m32n8k16", "m8n32k16"],
                        ["a", "b"], ["f16", "u8", "s8"]) +
          make_ldst_ops(["m16n16k16", "m32n8k16", "m8n32k16"],
                        ["c", "d"], ["f16", "f32", "s32"]) +
          make_ldst_ops(["m8n8k32"], ["a", "b"], ["s4","u4"]) +
          make_ldst_ops(["m8n8k128"], ["a", "b"], ["b1"]) +
          make_ldst_ops(["m8n8k32", "m8n8k128"],  ["c", "d"], ["s32"]))

def is_geom_supported(geom):
  # geometries for FP and ints.
  if geom in ["m8n32k16", "m32n8k16"]:
    return ptx_version >= 61
  # geometries for sub-ints.
  if geom in ["m8n8k32", "m8n8k128"]:
    return ptx_version >= 63 and gpu_arch >= 75
  if geom == "m16n16k16":
    return ptx_version >= 60
  assert(False) # Unexpected geometry.

def is_type_supported(ptx_type):
  if ptx_type in ["s8", "u8", "s32"]:
    return ptx_version >= 63 and gpu_arch >= 72
  if ptx_type in ["s4", "u4", "b1"]:
    return ptx_version >= 63 and gpu_arch >= 75
  return ptx_version >= 60 and gpu_arch >= 70

def is_mma_variant_supported(op, layout_a, layout_b, satf):
  if not (is_type_supported(op.a.ptx_type)
          and is_geom_supported(op.a.geom)):
    return False
  # sub-integer require row/col layout, and no satf.
  if op.a.ptx_type in ["s4", "u4", "b1"]:
    if op.a.ptx_type == "b1" and satf:
      return False
    return layout_a == "row" and layout_b == "col"
  return True

def is_ldst_variant_supported(frag, layout):
  if not (is_type_supported(frag.ptx_type)
          and is_geom_supported(frag.geom)):
    return False
  if frag.ptx_type in ["s4", "u4", "b1"]:
    # sub-integer require sm_75 and ptx63, row/col layout for a/b.
    return ((frag.frag == "a" and layout == "row")
            or (frag.frag == "b" and layout == "col")
            or frag.frag in ["c", "d"])
  return True

def get_builtin_prefix(frag):
  prefix = None
  if frag.geom in ["m16n16k16", "m32n8k16", "m8n32k16"]:
    if frag.ptx_type in ["f16", "f32"]:
      prefix = "__hmma"
    else:
      prefix = "__imma"
  elif frag.geom == "m8n8k32":
    prefix = "__imma" # sub-integers
  elif frag.geom == "m8n8k128":
    prefix = "__bmma"
  assert prefix
  return prefix

def get_ldst_builtin_name(frag):
  prefix = get_builtin_prefix(frag)

  if prefix == "__hmma":
    suffix = "" if frag.frag in ["a","b"] else frag.ptx_type
  elif prefix in ["__imma", "__bmma"]:
    suffix = "" if frag.frag in ["c"] else frag.ptx_type
    if suffix == "s32":
      suffix = "i32"
  if frag.frag == "d":
    ifrag = "c"
    op = "st"
  else:
    ifrag = frag.frag
    op = "ld"

  name = "%s_%s_%s_%s%s" % (prefix, frag.geom, op, ifrag,
                             "_" + suffix if suffix else "")
  return name

def get_mma_builtin_name(op):
  prefix = get_builtin_prefix(op.a)

  if prefix == "__hmma":
    suffix = op.d.ptx_type + op.c.ptx_type
  else:
    suffix = op.a.ptx_type

  name = "%s_%s_mma%s_%s" % (prefix, op.a.geom,
                             "_xor_popc" if op.a.ptx_type == "b1" else "",
                             suffix)
  return name


def get_required_sm(frag):
  if frag.ptx_type in ["u4", "s4", "b1"]:
    return 75
  if frag.ptx_type in ["s8", "u8"]:
    return 72
  if frag.ptx_type == "s32":
    if frag.geom in ["m8n8k32", "m8n8k128"]: # s4/u4/b1
      return 75
    else:                       # s8/u8
      return 72
  if frag.ptx_type in ["f16", "f32"]:
    return 70
  assert(False)

def get_required_ptx(frag):
  if frag.ptx_type in ["f16", "f32"]:
    return 60 if frag.geom == "m16n16k16" else 61
  return 63

def gen_wmma_ldst_tests(results):
  load_template = """
  // CHECK${check_suffix}: call {{.*}} @${intrinsic}
  // expected-error-re@+1 {{'${builtin}' needs target feature sm_${min_sm}{{.*}},ptx${min_ptx}{{.*}}}}
  ${builtin}(${dst}, ${src}, ldm, ${blayout});
""".rstrip()
  intrinsic_template = "llvm.nvvm.wmma.${geom}.${op}.${frag}.${ilayout}.stride.${itype}"

  for frag, layout in sorted(product(get_ldst_ops(), ["row","col"]), key=str):

    if not is_ldst_variant_supported(frag, layout):
      continue

    is_fp = frag.ptx_type  == "f32"
    min_sm = get_required_sm(frag)
    min_ptx = get_required_ptx(frag)
    params = {
        "check_suffix" : "_PTX%d_SM%d" % (min_ptx, min_sm),
        "builtin" : get_ldst_builtin_name(frag),
        "min_ptx" : min_ptx,
        "min_sm" : min_sm,
        "dst": "fdst" if is_fp else "dst",
        "src": "fsrc" if is_fp else "src",
        "blayout" : 0 if layout == "row" else 1,
        "intrinsic" : Template(intrinsic_template).substitute({
            "frag" : frag.frag,
            "geom"   : frag.geom,
            "ilayout" : layout,
            "itype" : frag.ptx_type,
            "op" : "store" if frag.frag == "d" else "load",
        })
    }
    results[(min_ptx,min_sm)] += Template(load_template).substitute(params)

  return results

def mma_signature(op):
  if op.a.ptx_type in ["s8", "u8", "s4", "u4", "b1"]:
    # int and sub-int ops are identified by input type.
    return op.a.ptx_type
  else:
    # the rest are FP ops identified by accumulator & result type.
    return "%s.%s" % (op.d.ptx_type, op.c.ptx_type)

# Get numeric value for rowcol parameter of the builtin
# AFAICT it uses the encoding accepted by NVVM intrinsics:
# https://docs.nvidia.com/cuda/nvvm-ir-spec/index.html#nvvm-intrin-warp-level-matrix-mma
def get_ilayout(a, b):
  return {
      "row.row" : 0,
      "row.col" : 1,
      "col.row" : 2,
      "col.col" : 3
  }[a + "." + b]

def gen_wmma_mma_tests(results):
  mma_template = """
  // CHECK${check_suffix}: call {{.*}} @${intrinsic}
  // expected-error-re@+1 {{'${builtin}' needs target feature sm_${min_sm}{{.*}},ptx${min_ptx}{{.*}}}}
  ${builtin}(${dst}, ${asrc}, ${asrc}, ${csrc}, ${ilayout}${maybe_isatf});
""".rstrip()
  intrinsic_template = "llvm.nvvm.wmma.${geom}.mma.${alayout}.${blayout}.${intrinsic_signature}${satf}"

  for op, alayout, blayout, satf in sorted(product( get_mma_ops(),
                                                    ["row","col"],
                                                    ["row","col"],
                                                    [".satfinite", ""]),
                                           key=str):

    if not is_mma_variant_supported(op, alayout, blayout, satf):
      continue

    a_is_fp = op.a.ptx_type  == "f32"
    c_is_fp = op.c.ptx_type  == "f32"
    d_is_fp = op.d.ptx_type  == "f32"
    min_sm = get_required_sm(op.a)
    min_ptx = get_required_ptx(op.a)
    if op.a.ptx_type == "b1": # .b1 MMA has no satf argument.
       isatf_arg = ""
    else:
       isatf_arg = ", 1" if satf else ", 0"
    params = {
        "check_suffix" : "_PTX%d_SM%d" % (min_ptx, min_sm),
        "builtin" : get_mma_builtin_name(op),
        "min_ptx" : min_ptx,
        "min_sm" : min_sm,
        "dst": "fdst" if d_is_fp else "dst",
        "asrc": "fsrc" if a_is_fp else "src",
        "csrc": "fsrc" if c_is_fp else "src",
        "ilayout" : get_ilayout(alayout, blayout),
        "maybe_isatf" : isatf_arg,
        "intrinsic" : Template(intrinsic_template).substitute({
            "geom"  : op.a.geom,
            "alayout" : alayout,
            "blayout" : blayout,
            "intrinsic_signature" : mma_signature(op),
            "satf"  : satf,
        })
    }
    results[(min_ptx, min_sm)] += Template(mma_template).substitute(params)

  return results

def gen_tests():
  results = gen_wmma_ldst_tests(defaultdict(str))
  results = gen_wmma_mma_tests(results)

  run_template = r"""
//
// *** DO NOT EDIT ***
//
//  This test has been automatically generated by
//  builtins-nvtx-mma.py --ptx=${ptx} --gpu-arch=${sm}
//
// Make sure we can handle all builtins available on sm_${sm} with PTX${ptx}
// ${run}: %clang_cc1 -triple nvptx64-unknown-unknown -target-cpu sm_${sm} \
// ${run}:            -fcuda-is-device -target-feature +ptx${ptx} \
// ${run}:            -DPTX=${ptx} -DSM=${sm} \
// ${run}:            -S -emit-llvm -o - -x cuda %s \
// ${run}:   | FileCheck -check-prefixes=${check_labels} %s
// Verify that all builtins have correct constraints.
// ${run}: %clang_cc1 -triple nvptx-unknown-unknown \
// ${run}:   -target-cpu sm_60 -target-feature +ptx42 \
// ${run}:   -DPTX=${ptx} -DSM=${sm} -fcuda-is-device -S -o /dev/null -x cuda \
// ${run}:   -verify %s
"""
  def supported_variants(ptx, sm, results):
    return [(ptx_, sm_) for ptx_, sm_ in results if ptx_ <= ptx and sm_ <= sm]

  print(Template(run_template).substitute({
      "run" : "RUN", # To avoid lit misinterpreting the template
      "ptx" : ptx_version,
      "sm" : gpu_arch,
      "check_labels" : ",".join(["CHECK_PTX%d_SM%d" % (ptx_, sm_)
                                 for ptx_, sm_
                                 in supported_variants(ptx_version, gpu_arch,
                                                       results)])
  }))

  print("""
#if !defined(CUDA_VERSION)
#define __device__ __attribute__((device))
#define __global__ __attribute__((global))
#define __shared__ __attribute__((shared))
#define __constant__ __attribute__((constant))

typedef unsigned long long uint64_t;
#endif

// CHECK-LABEL: test_wmma_buitins
__device__ void test_wmma_buitins(int *src, int *dst,
                                  float *fsrc, float *fdst, int ldm) {
""");

  for (ptx, sm), tests in sorted(results.items()):
    print()
    print("#if (PTX >= %d) && (SM >= %d)" % (ptx, sm))
    print(tests)
    print("#endif // (PTX >= %d) && (SM >= %d) "% (ptx, sm))

  print("}")

parser = argparse.ArgumentParser()
parser.add_argument("--ptx", type=int, default=60)
parser.add_argument("--gpu-arch", type=int, default=70)
args = parser.parse_args()
ptx_version = args.ptx
gpu_arch = args.gpu_arch

gen_tests()
