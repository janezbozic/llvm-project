; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -disable-peephole -mtriple=x86_64-unknown-unknown -mattr=+avx512vnni,+avx512vl,+avx512bw | FileCheck %s --check-prefixes=CHECK

define <16 x i32> @test_pmaddwd_v32i16_add_v16i32(<16 x i32> %a0, <32 x i16> %a1, <32 x i16> %a2) {
; CHECK-LABEL: test_pmaddwd_v32i16_add_v16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpdpwssd %zmm2, %zmm1, %zmm0
; CHECK-NEXT:    retq
  %1 = call <16 x i32> @llvm.x86.avx512.pmaddw.d.512(<32 x i16> %a1, <32 x i16> %a2)
  %2 = add <16 x i32> %1, %a0
  ret <16 x i32> %2
}

define <16 x i32> @test_pmaddwd_v32i16_add_v16i32_commute(<16 x i32> %a0, <32 x i16> %a1, <32 x i16> %a2) {
; CHECK-LABEL: test_pmaddwd_v32i16_add_v16i32_commute:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpdpwssd %zmm2, %zmm1, %zmm0
; CHECK-NEXT:    retq
  %1 = call <16 x i32> @llvm.x86.avx512.pmaddw.d.512(<32 x i16> %a1, <32 x i16> %a2)
  %2 = add <16 x i32> %a0, %1
  ret <16 x i32> %2
}

define <16 x i32> @test_pmaddwd_v32i16_add_v16i32_load1(<16 x i32> %a0, <32 x i16>* %p1, <32 x i16> %a2) {
; CHECK-LABEL: test_pmaddwd_v32i16_add_v16i32_load1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpdpwssd (%rdi), %zmm1, %zmm0
; CHECK-NEXT:    retq
  %a1 = load <32 x i16>, <32 x i16>* %p1
  %1 = call <16 x i32> @llvm.x86.avx512.pmaddw.d.512(<32 x i16> %a1, <32 x i16> %a2)
  %2 = add <16 x i32> %1, %a0
  ret <16 x i32> %2
}

define <16 x i32> @test_pmaddwd_v32i16_add_v16i32_load2(<16 x i32> %a0, <32 x i16> %a1, <32 x i16>* %p2) {
; CHECK-LABEL: test_pmaddwd_v32i16_add_v16i32_load2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpdpwssd (%rdi), %zmm1, %zmm0
; CHECK-NEXT:    retq
  %a2 = load <32 x i16>, <32 x i16>* %p2
  %1 = call <16 x i32> @llvm.x86.avx512.pmaddw.d.512(<32 x i16> %a1, <32 x i16> %a2)
  %2 = add <16 x i32> %1, %a0
  ret <16 x i32> %2
}

define <16 x i32> @test_pmaddwd_v32i16_add_v16i32_commute_load1(<16 x i32> %a0, <32 x i16>* %p1, <32 x i16> %a2) {
; CHECK-LABEL: test_pmaddwd_v32i16_add_v16i32_commute_load1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpdpwssd (%rdi), %zmm1, %zmm0
; CHECK-NEXT:    retq
  %a1 = load <32 x i16>, <32 x i16>* %p1
  %1 = call <16 x i32> @llvm.x86.avx512.pmaddw.d.512(<32 x i16> %a1, <32 x i16> %a2)
  %2 = add <16 x i32> %a0, %1
  ret <16 x i32> %2
}

define <16 x i32> @test_pmaddwd_v32i16_add_v16i32_commute_load2(<16 x i32> %a0, <32 x i16> %a1, <32 x i16>* %p2) {
; CHECK-LABEL: test_pmaddwd_v32i16_add_v16i32_commute_load2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpdpwssd (%rdi), %zmm1, %zmm0
; CHECK-NEXT:    retq
  %a2 = load <32 x i16>, <32 x i16>* %p2
  %1 = call <16 x i32> @llvm.x86.avx512.pmaddw.d.512(<32 x i16> %a1, <32 x i16> %a2)
  %2 = add <16 x i32> %a0, %1
  ret <16 x i32> %2
}

declare <16 x i32> @llvm.x86.avx512.pmaddw.d.512(<32 x i16>, <32 x i16>)
