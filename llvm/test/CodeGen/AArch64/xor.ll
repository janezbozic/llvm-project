; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-- | FileCheck %s

define i32 @PR39657(i8* %p, i64 %x) {
; CHECK-LABEL: PR39657:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvn x8, x1
; CHECK-NEXT:    ldr w0, [x0, x8, lsl #2]
; CHECK-NEXT:    ret
  %sh = shl i64 %x, 2
  %mul = xor i64 %sh, -4
  %add.ptr = getelementptr inbounds i8, i8* %p, i64 %mul
  %bc = bitcast i8* %add.ptr to i32*
  %load = load i32, i32* %bc, align 4
  ret i32 %load
}

define i32 @add_of_not(i32 %x, i32 %y) {
; CHECK-LABEL: add_of_not:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvn w8, w1
; CHECK-NEXT:    add w0, w8, w0
; CHECK-NEXT:    ret
  %t0 = sub i32 %x, %y
  %r = add i32 %t0, -1
  ret i32 %r
}

define i32 @add_of_not_decrement(i32 %x, i32 %y) {
; CHECK-LABEL: add_of_not_decrement:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvn w8, w1
; CHECK-NEXT:    add w0, w8, w0
; CHECK-NEXT:    ret
  %t0 = sub i32 %x, %y
  %r = sub i32 %t0, 1
  ret i32 %r
}

define <4 x i32> @vec_add_of_not(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: vec_add_of_not:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvn v1.16b, v1.16b
; CHECK-NEXT:    add v0.4s, v1.4s, v0.4s
; CHECK-NEXT:    ret
  %t0 = sub <4 x i32> %x, %y
  %r = add <4 x i32> %t0, <i32 -1, i32 -1, i32 -1, i32 -1>
  ret <4 x i32> %r
}

define <4 x i32> @vec_add_of_not_decrement(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: vec_add_of_not_decrement:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvn v1.16b, v1.16b
; CHECK-NEXT:    add v0.4s, v1.4s, v0.4s
; CHECK-NEXT:    ret
  %t0 = sub <4 x i32> %x, %y
  %r = sub <4 x i32> %t0, <i32 1, i32 1, i32 1, i32 1>
  ret <4 x i32> %r
}

define <4 x i32> @vec_add_of_not_with_undef(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: vec_add_of_not_with_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    movi v1.2d, #0xffffffffffffffff
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
  %t0 = sub <4 x i32> %x, %y
  %r = add <4 x i32> %t0, <i32 -1, i32 undef, i32 -1, i32 -1>
  ret <4 x i32> %r
}

define <4 x i32> @vec_add_of_not_with_undef_decrement(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: vec_add_of_not_with_undef_decrement:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    movi v1.4s, #1
; CHECK-NEXT:    add v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
  %t0 = sub <4 x i32> %x, %y
  %r = add <4 x i32> %t0, <i32 1, i32 undef, i32 1, i32 1>
  ret <4 x i32> %r
}
