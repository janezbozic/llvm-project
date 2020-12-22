; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v,+f,+experimental-zfh -verify-machineinstrs \
; RUN:   --riscv-no-aliases < %s | FileCheck %s
declare <vscale x 1 x float> @llvm.riscv.vfwnmacc.nxv1f32.nxv1f16(
  <vscale x 1 x float>,
  <vscale x 1 x half>,
  <vscale x 1 x half>,
  i32);

define <vscale x 1 x float>  @intrinsic_vfwnmacc_vv_nxv1f32_nxv1f16_nxv1f16(<vscale x 1 x float> %0, <vscale x 1 x half> %1, <vscale x 1 x half> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_vv_nxv1f32_nxv1f16_nxv1f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,mf4,ta,mu
; CHECK-NEXT:    vfwnmacc.vv v16, v17, v18
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x float> @llvm.riscv.vfwnmacc.nxv1f32.nxv1f16(
    <vscale x 1 x float> %0,
    <vscale x 1 x half> %1,
    <vscale x 1 x half> %2,
    i32 %3)

  ret <vscale x 1 x float> %a
}

declare <vscale x 1 x float> @llvm.riscv.vfwnmacc.mask.nxv1f32.nxv1f16(
  <vscale x 1 x float>,
  <vscale x 1 x half>,
  <vscale x 1 x half>,
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x float>  @intrinsic_vfwnmacc_mask_vv_nxv1f32_nxv1f16_nxv1f16(<vscale x 1 x float> %0, <vscale x 1 x half> %1, <vscale x 1 x half> %2, <vscale x 1 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_mask_vv_nxv1f32_nxv1f16_nxv1f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,mf4,ta,mu
; CHECK-NEXT:    vfwnmacc.vv v16, v17, v18, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x float> @llvm.riscv.vfwnmacc.mask.nxv1f32.nxv1f16(
    <vscale x 1 x float> %0,
    <vscale x 1 x half> %1,
    <vscale x 1 x half> %2,
    <vscale x 1 x i1> %3,
    i32 %4)

  ret <vscale x 1 x float> %a
}

declare <vscale x 2 x float> @llvm.riscv.vfwnmacc.nxv2f32.nxv2f16(
  <vscale x 2 x float>,
  <vscale x 2 x half>,
  <vscale x 2 x half>,
  i32);

define <vscale x 2 x float>  @intrinsic_vfwnmacc_vv_nxv2f32_nxv2f16_nxv2f16(<vscale x 2 x float> %0, <vscale x 2 x half> %1, <vscale x 2 x half> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_vv_nxv2f32_nxv2f16_nxv2f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,mf2,ta,mu
; CHECK-NEXT:    vfwnmacc.vv v16, v17, v18
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x float> @llvm.riscv.vfwnmacc.nxv2f32.nxv2f16(
    <vscale x 2 x float> %0,
    <vscale x 2 x half> %1,
    <vscale x 2 x half> %2,
    i32 %3)

  ret <vscale x 2 x float> %a
}

declare <vscale x 2 x float> @llvm.riscv.vfwnmacc.mask.nxv2f32.nxv2f16(
  <vscale x 2 x float>,
  <vscale x 2 x half>,
  <vscale x 2 x half>,
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x float>  @intrinsic_vfwnmacc_mask_vv_nxv2f32_nxv2f16_nxv2f16(<vscale x 2 x float> %0, <vscale x 2 x half> %1, <vscale x 2 x half> %2, <vscale x 2 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_mask_vv_nxv2f32_nxv2f16_nxv2f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,mf2,ta,mu
; CHECK-NEXT:    vfwnmacc.vv v16, v17, v18, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x float> @llvm.riscv.vfwnmacc.mask.nxv2f32.nxv2f16(
    <vscale x 2 x float> %0,
    <vscale x 2 x half> %1,
    <vscale x 2 x half> %2,
    <vscale x 2 x i1> %3,
    i32 %4)

  ret <vscale x 2 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.vfwnmacc.nxv4f32.nxv4f16(
  <vscale x 4 x float>,
  <vscale x 4 x half>,
  <vscale x 4 x half>,
  i32);

define <vscale x 4 x float>  @intrinsic_vfwnmacc_vv_nxv4f32_nxv4f16_nxv4f16(<vscale x 4 x float> %0, <vscale x 4 x half> %1, <vscale x 4 x half> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_vv_nxv4f32_nxv4f16_nxv4f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m1,ta,mu
; CHECK-NEXT:    vfwnmacc.vv v16, v18, v19
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x float> @llvm.riscv.vfwnmacc.nxv4f32.nxv4f16(
    <vscale x 4 x float> %0,
    <vscale x 4 x half> %1,
    <vscale x 4 x half> %2,
    i32 %3)

  ret <vscale x 4 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.vfwnmacc.mask.nxv4f32.nxv4f16(
  <vscale x 4 x float>,
  <vscale x 4 x half>,
  <vscale x 4 x half>,
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x float>  @intrinsic_vfwnmacc_mask_vv_nxv4f32_nxv4f16_nxv4f16(<vscale x 4 x float> %0, <vscale x 4 x half> %1, <vscale x 4 x half> %2, <vscale x 4 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_mask_vv_nxv4f32_nxv4f16_nxv4f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m1,ta,mu
; CHECK-NEXT:    vfwnmacc.vv v16, v18, v19, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x float> @llvm.riscv.vfwnmacc.mask.nxv4f32.nxv4f16(
    <vscale x 4 x float> %0,
    <vscale x 4 x half> %1,
    <vscale x 4 x half> %2,
    <vscale x 4 x i1> %3,
    i32 %4)

  ret <vscale x 4 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.vfwnmacc.nxv8f32.nxv8f16(
  <vscale x 8 x float>,
  <vscale x 8 x half>,
  <vscale x 8 x half>,
  i32);

define <vscale x 8 x float>  @intrinsic_vfwnmacc_vv_nxv8f32_nxv8f16_nxv8f16(<vscale x 8 x float> %0, <vscale x 8 x half> %1, <vscale x 8 x half> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_vv_nxv8f32_nxv8f16_nxv8f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m2,ta,mu
; CHECK-NEXT:    vfwnmacc.vv v16, v20, v22
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x float> @llvm.riscv.vfwnmacc.nxv8f32.nxv8f16(
    <vscale x 8 x float> %0,
    <vscale x 8 x half> %1,
    <vscale x 8 x half> %2,
    i32 %3)

  ret <vscale x 8 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.vfwnmacc.mask.nxv8f32.nxv8f16(
  <vscale x 8 x float>,
  <vscale x 8 x half>,
  <vscale x 8 x half>,
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x float>  @intrinsic_vfwnmacc_mask_vv_nxv8f32_nxv8f16_nxv8f16(<vscale x 8 x float> %0, <vscale x 8 x half> %1, <vscale x 8 x half> %2, <vscale x 8 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_mask_vv_nxv8f32_nxv8f16_nxv8f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e16,m2,ta,mu
; CHECK-NEXT:    vfwnmacc.vv v16, v20, v22, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x float> @llvm.riscv.vfwnmacc.mask.nxv8f32.nxv8f16(
    <vscale x 8 x float> %0,
    <vscale x 8 x half> %1,
    <vscale x 8 x half> %2,
    <vscale x 8 x i1> %3,
    i32 %4)

  ret <vscale x 8 x float> %a
}

declare <vscale x 16 x float> @llvm.riscv.vfwnmacc.nxv16f32.nxv16f16(
  <vscale x 16 x float>,
  <vscale x 16 x half>,
  <vscale x 16 x half>,
  i32);

define <vscale x 16 x float>  @intrinsic_vfwnmacc_vv_nxv16f32_nxv16f16_nxv16f16(<vscale x 16 x float> %0, <vscale x 16 x half> %1, <vscale x 16 x half> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_vv_nxv16f32_nxv16f16_nxv16f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a3, zero, e16,m4,ta,mu
; CHECK-NEXT:    vle16.v v28, (a1)
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vsetvli a0, a2, e16,m4,ta,mu
; CHECK-NEXT:    vfwnmacc.vv v16, v8, v28
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x float> @llvm.riscv.vfwnmacc.nxv16f32.nxv16f16(
    <vscale x 16 x float> %0,
    <vscale x 16 x half> %1,
    <vscale x 16 x half> %2,
    i32 %3)

  ret <vscale x 16 x float> %a
}

declare <vscale x 16 x float> @llvm.riscv.vfwnmacc.mask.nxv16f32.nxv16f16(
  <vscale x 16 x float>,
  <vscale x 16 x half>,
  <vscale x 16 x half>,
  <vscale x 16 x i1>,
  i32);

define <vscale x 16 x float>  @intrinsic_vfwnmacc_mask_vv_nxv16f32_nxv16f16_nxv16f16(<vscale x 16 x float> %0, <vscale x 16 x half> %1, <vscale x 16 x half> %2, <vscale x 16 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_mask_vv_nxv16f32_nxv16f16_nxv16f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a3, zero, e16,m4,ta,mu
; CHECK-NEXT:    vle16.v v28, (a1)
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vsetvli a0, a2, e16,m4,ta,mu
; CHECK-NEXT:    vfwnmacc.vv v16, v8, v28, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x float> @llvm.riscv.vfwnmacc.mask.nxv16f32.nxv16f16(
    <vscale x 16 x float> %0,
    <vscale x 16 x half> %1,
    <vscale x 16 x half> %2,
    <vscale x 16 x i1> %3,
    i32 %4)

  ret <vscale x 16 x float> %a
}

declare <vscale x 1 x float> @llvm.riscv.vfwnmacc.nxv1f32.f16(
  <vscale x 1 x float>,
  half,
  <vscale x 1 x half>,
  i32);

define <vscale x 1 x float>  @intrinsic_vfwnmacc_vf_nxv1f32_f16_nxv1f16(<vscale x 1 x float> %0, half %1, <vscale x 1 x half> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_vf_nxv1f32_f16_nxv1f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,mf4,ta,mu
; CHECK-NEXT:    vfwnmacc.vf v16, ft0, v17
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x float> @llvm.riscv.vfwnmacc.nxv1f32.f16(
    <vscale x 1 x float> %0,
    half %1,
    <vscale x 1 x half> %2,
    i32 %3)

  ret <vscale x 1 x float> %a
}

declare <vscale x 1 x float> @llvm.riscv.vfwnmacc.mask.nxv1f32.f16(
  <vscale x 1 x float>,
  half,
  <vscale x 1 x half>,
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x float> @intrinsic_vfwnmacc_mask_vf_nxv1f32_f16_nxv1f16(<vscale x 1 x float> %0, half %1, <vscale x 1 x half> %2, <vscale x 1 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_mask_vf_nxv1f32_f16_nxv1f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,mf4,ta,mu
; CHECK-NEXT:    vfwnmacc.vf v16, ft0, v17, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 1 x float> @llvm.riscv.vfwnmacc.mask.nxv1f32.f16(
    <vscale x 1 x float> %0,
    half %1,
    <vscale x 1 x half> %2,
    <vscale x 1 x i1> %3,
    i32 %4)

  ret <vscale x 1 x float> %a
}

declare <vscale x 2 x float> @llvm.riscv.vfwnmacc.nxv2f32.f16(
  <vscale x 2 x float>,
  half,
  <vscale x 2 x half>,
  i32);

define <vscale x 2 x float>  @intrinsic_vfwnmacc_vf_nxv2f32_f16_nxv2f16(<vscale x 2 x float> %0, half %1, <vscale x 2 x half> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_vf_nxv2f32_f16_nxv2f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,mf2,ta,mu
; CHECK-NEXT:    vfwnmacc.vf v16, ft0, v17
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x float> @llvm.riscv.vfwnmacc.nxv2f32.f16(
    <vscale x 2 x float> %0,
    half %1,
    <vscale x 2 x half> %2,
    i32 %3)

  ret <vscale x 2 x float> %a
}

declare <vscale x 2 x float> @llvm.riscv.vfwnmacc.mask.nxv2f32.f16(
  <vscale x 2 x float>,
  half,
  <vscale x 2 x half>,
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x float> @intrinsic_vfwnmacc_mask_vf_nxv2f32_f16_nxv2f16(<vscale x 2 x float> %0, half %1, <vscale x 2 x half> %2, <vscale x 2 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_mask_vf_nxv2f32_f16_nxv2f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,mf2,ta,mu
; CHECK-NEXT:    vfwnmacc.vf v16, ft0, v17, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 2 x float> @llvm.riscv.vfwnmacc.mask.nxv2f32.f16(
    <vscale x 2 x float> %0,
    half %1,
    <vscale x 2 x half> %2,
    <vscale x 2 x i1> %3,
    i32 %4)

  ret <vscale x 2 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.vfwnmacc.nxv4f32.f16(
  <vscale x 4 x float>,
  half,
  <vscale x 4 x half>,
  i32);

define <vscale x 4 x float>  @intrinsic_vfwnmacc_vf_nxv4f32_f16_nxv4f16(<vscale x 4 x float> %0, half %1, <vscale x 4 x half> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_vf_nxv4f32_f16_nxv4f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,m1,ta,mu
; CHECK-NEXT:    vfwnmacc.vf v16, ft0, v18
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x float> @llvm.riscv.vfwnmacc.nxv4f32.f16(
    <vscale x 4 x float> %0,
    half %1,
    <vscale x 4 x half> %2,
    i32 %3)

  ret <vscale x 4 x float> %a
}

declare <vscale x 4 x float> @llvm.riscv.vfwnmacc.mask.nxv4f32.f16(
  <vscale x 4 x float>,
  half,
  <vscale x 4 x half>,
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x float> @intrinsic_vfwnmacc_mask_vf_nxv4f32_f16_nxv4f16(<vscale x 4 x float> %0, half %1, <vscale x 4 x half> %2, <vscale x 4 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_mask_vf_nxv4f32_f16_nxv4f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,m1,ta,mu
; CHECK-NEXT:    vfwnmacc.vf v16, ft0, v18, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 4 x float> @llvm.riscv.vfwnmacc.mask.nxv4f32.f16(
    <vscale x 4 x float> %0,
    half %1,
    <vscale x 4 x half> %2,
    <vscale x 4 x i1> %3,
    i32 %4)

  ret <vscale x 4 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.vfwnmacc.nxv8f32.f16(
  <vscale x 8 x float>,
  half,
  <vscale x 8 x half>,
  i32);

define <vscale x 8 x float>  @intrinsic_vfwnmacc_vf_nxv8f32_f16_nxv8f16(<vscale x 8 x float> %0, half %1, <vscale x 8 x half> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_vf_nxv8f32_f16_nxv8f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,m2,ta,mu
; CHECK-NEXT:    vfwnmacc.vf v16, ft0, v20
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x float> @llvm.riscv.vfwnmacc.nxv8f32.f16(
    <vscale x 8 x float> %0,
    half %1,
    <vscale x 8 x half> %2,
    i32 %3)

  ret <vscale x 8 x float> %a
}

declare <vscale x 8 x float> @llvm.riscv.vfwnmacc.mask.nxv8f32.f16(
  <vscale x 8 x float>,
  half,
  <vscale x 8 x half>,
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x float> @intrinsic_vfwnmacc_mask_vf_nxv8f32_f16_nxv8f16(<vscale x 8 x float> %0, half %1, <vscale x 8 x half> %2, <vscale x 8 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_mask_vf_nxv8f32_f16_nxv8f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a1, e16,m2,ta,mu
; CHECK-NEXT:    vfwnmacc.vf v16, ft0, v20, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 8 x float> @llvm.riscv.vfwnmacc.mask.nxv8f32.f16(
    <vscale x 8 x float> %0,
    half %1,
    <vscale x 8 x half> %2,
    <vscale x 8 x i1> %3,
    i32 %4)

  ret <vscale x 8 x float> %a
}

declare <vscale x 16 x float> @llvm.riscv.vfwnmacc.nxv16f32.f16(
  <vscale x 16 x float>,
  half,
  <vscale x 16 x half>,
  i32);

define <vscale x 16 x float>  @intrinsic_vfwnmacc_vf_nxv16f32_f16_nxv16f16(<vscale x 16 x float> %0, half %1, <vscale x 16 x half> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_vf_nxv16f32_f16_nxv16f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a3, zero, e16,m4,ta,mu
; CHECK-NEXT:    vle16.v v28, (a1)
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a2, e16,m4,ta,mu
; CHECK-NEXT:    vfwnmacc.vf v16, ft0, v28
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x float> @llvm.riscv.vfwnmacc.nxv16f32.f16(
    <vscale x 16 x float> %0,
    half %1,
    <vscale x 16 x half> %2,
    i32 %3)

  ret <vscale x 16 x float> %a
}

declare <vscale x 16 x float> @llvm.riscv.vfwnmacc.mask.nxv16f32.f16(
  <vscale x 16 x float>,
  half,
  <vscale x 16 x half>,
  <vscale x 16 x i1>,
  i32);

define <vscale x 16 x float> @intrinsic_vfwnmacc_mask_vf_nxv16f32_f16_nxv16f16(<vscale x 16 x float> %0, half %1, <vscale x 16 x half> %2, <vscale x 16 x i1> %3, i32 %4) nounwind {
; CHECK-LABEL: intrinsic_vfwnmacc_mask_vf_nxv16f32_f16_nxv16f16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a3, zero, e16,m4,ta,mu
; CHECK-NEXT:    vle16.v v28, (a1)
; CHECK-NEXT:    fmv.h.x ft0, a0
; CHECK-NEXT:    vsetvli a0, a2, e16,m4,ta,mu
; CHECK-NEXT:    vfwnmacc.vf v16, ft0, v28, v0.t
; CHECK-NEXT:    jalr zero, 0(ra)
entry:
  %a = call <vscale x 16 x float> @llvm.riscv.vfwnmacc.mask.nxv16f32.f16(
    <vscale x 16 x float> %0,
    half %1,
    <vscale x 16 x half> %2,
    <vscale x 16 x i1> %3,
    i32 %4)

  ret <vscale x 16 x float> %a
}
