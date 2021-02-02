; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instsimplify -S | FileCheck %s

declare float @llvm.amdgcn.fma.legacy(float, float, float)

define void @test(float* %p) {
; CHECK-LABEL: @test(
; CHECK-NEXT:    store volatile float 1.000000e+01, float* [[P:%.*]], align 4
; CHECK-NEXT:    store volatile float 4.000000e+00, float* [[P]], align 4
; CHECK-NEXT:    store volatile float 4.000000e+00, float* [[P]], align 4
; CHECK-NEXT:    store volatile float 0.000000e+00, float* [[P]], align 4
; CHECK-NEXT:    store volatile float 0.000000e+00, float* [[P]], align 4
; CHECK-NEXT:    store volatile float 0.000000e+00, float* [[P]], align 4
; CHECK-NEXT:    store volatile float 0.000000e+00, float* [[P]], align 4
; CHECK-NEXT:    store volatile float 4.000000e+00, float* [[P]], align 4
; CHECK-NEXT:    store volatile float 4.000000e+00, float* [[P]], align 4
; CHECK-NEXT:    store volatile float 4.000000e+00, float* [[P]], align 4
; CHECK-NEXT:    store volatile float 4.000000e+00, float* [[P]], align 4
; CHECK-NEXT:    ret void
;
  %a = call float @llvm.amdgcn.fma.legacy(float +2.0, float +3.0, float +4.0)
  store volatile float %a, float* %p
  %b = call float @llvm.amdgcn.fma.legacy(float +2.0, float +0.0, float +4.0)
  store volatile float %b, float* %p
  %c = call float @llvm.amdgcn.fma.legacy(float +2.0, float -0.0, float +4.0)
  store volatile float %c, float* %p
  %d = call float @llvm.amdgcn.fma.legacy(float +0.0, float +0.0, float -0.0)
  store volatile float %d, float* %p
  %e = call float @llvm.amdgcn.fma.legacy(float +0.0, float -0.0, float -0.0)
  store volatile float %e, float* %p
  %f = call float @llvm.amdgcn.fma.legacy(float -0.0, float +0.0, float -0.0)
  store volatile float %f, float* %p
  %g = call float @llvm.amdgcn.fma.legacy(float -0.0, float -0.0, float -0.0)
  store volatile float %g, float* %p
  %h = call float @llvm.amdgcn.fma.legacy(float +0.0, float 0x7ff0000000000000, float +4.0) ; +inf
  store volatile float %h, float* %p
  %i = call float @llvm.amdgcn.fma.legacy(float 0xfff0000000000000, float +0.0, float +4.0) ; -inf
  store volatile float %i, float* %p
  %j = call float @llvm.amdgcn.fma.legacy(float 0x7ff0001000000000, float -0.0, float +4.0) ; +nan
  store volatile float %j, float* %p
  %k = call float @llvm.amdgcn.fma.legacy(float -0.0, float 0xfff0000100000000, float +4.0) ; -nan
  store volatile float %k, float* %p
  ret void
}
