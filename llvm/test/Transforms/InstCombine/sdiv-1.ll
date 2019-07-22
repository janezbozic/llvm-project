; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -inline -S | FileCheck %s
; PR3142

define i32 @a(i32 %X) {
; CHECK-LABEL: @a(
; CHECK-NEXT:    [[T0:%.*]] = sub i32 0, [[X:%.*]]
; CHECK-NEXT:    [[T1:%.*]] = sdiv i32 [[T0]], -3
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = sub i32 0, %X
  %t1 = sdiv i32 %t0, -3
  ret i32 %t1
}

define i32 @b(i32 %X) {
; CHECK-LABEL: @b(
; CHECK-NEXT:    ret i32 715827882
;
  %t0 = call i32 @a(i32 -2147483648)
  ret i32 %t0
}

define i32 @c(i32 %X) {
; CHECK-LABEL: @c(
; CHECK-NEXT:    ret i32 715827882
;
  %t0 = sub i32 0, -2147483648
  %t1 = sdiv i32 %t0, -3
  ret i32 %t1
}
