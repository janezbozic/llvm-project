; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

; Check that we skip transformations if the attribute unsafe-fp-math
; is not set.

define float @mysqrt(float %x, float %y) #0 {
; CHECK-LABEL: @mysqrt(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MUL:%.*]] = fmul fast float [[X:%.*]], [[X]]
; CHECK-NEXT:    [[TMP0:%.*]] = call float @llvm.sqrt.f32(float [[MUL]])
; CHECK-NEXT:    ret float [[TMP0]]
;
entry:
  %x.addr = alloca float, align 4
  %y.addr = alloca float, align 4
  store float %x, float* %x.addr, align 4
  store float %y, float* %y.addr, align 4
  %0 = load float, float* %x.addr, align 4
  %1 = load float, float* %x.addr, align 4
  %mul = fmul fast float %0, %1
  %2 = call float @llvm.sqrt.f32(float %mul)
  ret float %2
}

declare float @llvm.sqrt.f32(float) #1

; FIXME:
; This is a function called "sqrtf", but its type is double.
; Assume it is a user function rather than a libm function,
; so don't transform it.

define double @fake_sqrt(double %a, double %b) {
; CHECK-LABEL: @fake_sqrt(
; CHECK-NEXT:    [[FABS:%.*]] = call fast double @llvm.fabs.f64(double [[A:%.*]])
; CHECK-NEXT:    ret double [[FABS]]
;
  %c = fmul fast double %a, %a
  %e = call fast double @sqrtf(double %c) readnone
  ret double %e
}

declare double @sqrtf(double) readnone ; This is not the 'sqrt' you're looking for.
