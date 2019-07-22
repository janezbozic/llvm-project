; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -o - %s | FileCheck %s
; Check that selection dag legalization of fcopysign works in cases with
; different modes for the arguments.
target triple = "aarch64--"

declare fp128 @llvm.copysign.f128(fp128, fp128)

@val_float = global float zeroinitializer, align 4
@val_double = global double zeroinitializer, align 8
@val_fp128 = global fp128 zeroinitializer, align 16

define fp128 @copysign0() {
; CHECK-LABEL: copysign0:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    adrp x8, .LCPI0_0
; CHECK-NEXT:    ldr q0, [x8, :lo12:.LCPI0_0]
; CHECK-NEXT:    adrp x8, val_double
; CHECK-NEXT:    str q0, [sp, #-16]!
; CHECK-NEXT:    ldr x8, [x8, :lo12:val_double]
; CHECK-NEXT:    ldrb w9, [sp, #15]
; CHECK-NEXT:    and x8, x8, #0x8000000000000000
; CHECK-NEXT:    lsr x8, x8, #56
; CHECK-NEXT:    bfxil w8, w9, #0, #7
; CHECK-NEXT:    strb w8, [sp, #15]
; CHECK-NEXT:    ldr q0, [sp], #16
; CHECK-NEXT:    ret
entry:
  %v = load double, double* @val_double, align 8
  %conv = fpext double %v to fp128
  %call = tail call fp128 @llvm.copysign.f128(fp128 0xL00000000000000007FFF000000000000, fp128 %conv) #2
  ret fp128 %call
}

define fp128@copysign1() {
; CHECK-LABEL: copysign1:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    adrp x8, val_fp128
; CHECK-NEXT:    ldr q0, [x8, :lo12:val_fp128]
; CHECK-NEXT:    adrp x8, val_float
; CHECK-NEXT:    str q0, [sp, #-16]!
; CHECK-NEXT:    ldr w8, [x8, :lo12:val_float]
; CHECK-NEXT:    ldrb w9, [sp, #15]
; CHECK-NEXT:    and w8, w8, #0x80000000
; CHECK-NEXT:    lsr w8, w8, #24
; CHECK-NEXT:    bfxil w8, w9, #0, #7
; CHECK-NEXT:    strb w8, [sp, #15]
; CHECK-NEXT:    ldr q0, [sp], #16
; CHECK-NEXT:    ret
entry:
  %v0 = load fp128, fp128* @val_fp128, align 16
  %v1 = load float, float* @val_float, align 4
  %conv = fpext float %v1 to fp128
  %call = tail call fp128 @llvm.copysign.f128(fp128 %v0, fp128 %conv)
  ret fp128 %call
}
