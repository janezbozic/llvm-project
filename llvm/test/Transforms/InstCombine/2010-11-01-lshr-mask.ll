; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -instcombine -instcombine-infinite-loop-threshold=2 -S < %s | FileCheck %s

; <rdar://problem/8606771>
define i32 @main(i32 %argc) {
; CHECK-LABEL: @main(
; CHECK-NEXT:    [[T3151:%.*]] = trunc i32 [[ARGC:%.*]] to i8
; CHECK-NEXT:    [[T3163:%.*]] = xor i8 [[T3151]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = shl i8 [[T3163]], 5
; CHECK-NEXT:    [[T4127:%.*]] = and i8 [[TMP1]], 64
; CHECK-NEXT:    [[T4086:%.*]] = zext i8 [[T4127]] to i32
; CHECK-NEXT:    ret i32 [[T4086]]
;
  %t3151 = trunc i32 %argc to i8
  %t3161 = or i8 %t3151, -17
  %t3162 = and i8 %t3151, 122
  %t3163 = xor i8 %t3162, -17
  %t4114 = shl i8 %t3163, 6
  %t4115 = xor i8 %t4114, %t3163
  %t4120 = xor i8 %t3161, %t4115
  %t4126 = lshr i8 %t4120, 7
  %t4127 = mul i8 %t4126, 64
  %t4086 = zext i8 %t4127 to i32
  ret i32 %t4086
}

; rdar://8739316
define i8 @foo(i8 %arg, i8 %arg1) {
; CHECK-LABEL: @foo(
; CHECK-NEXT:    [[T:%.*]] = shl i8 [[ARG:%.*]], 7
; CHECK-NEXT:    [[T2:%.*]] = and i8 [[ARG1:%.*]], 84
; CHECK-NEXT:    [[T3:%.*]] = and i8 [[ARG1]], -118
; CHECK-NEXT:    [[T4:%.*]] = and i8 [[ARG1]], 33
; CHECK-NEXT:    [[T5:%.*]] = sub nsw i8 40, [[T2]]
; CHECK-NEXT:    [[T6:%.*]] = and i8 [[T5]], 84
; CHECK-NEXT:    [[T7:%.*]] = or i8 [[T4]], [[T6]]
; CHECK-NEXT:    [[T8:%.*]] = xor i8 [[T]], [[T3]]
; CHECK-NEXT:    [[T9:%.*]] = or i8 [[T7]], [[T8]]
; CHECK-NEXT:    [[TMP1:%.*]] = lshr i8 [[T8]], 2
; CHECK-NEXT:    [[T11:%.*]] = and i8 [[TMP1]], 32
; CHECK-NEXT:    [[T12:%.*]] = xor i8 [[T11]], [[T9]]
; CHECK-NEXT:    ret i8 [[T12]]
;
  %t = shl i8 %arg, 7
  %t2 = and i8 %arg1, 84
  %t3 = and i8 %arg1, -118
  %t4 = and i8 %arg1, 33
  %t5 = sub i8 -88, %t2
  %t6 = and i8 %t5, 84
  %t7 = or i8 %t4, %t6
  %t8 = xor i8 %t, %t3
  %t9 = or i8 %t7, %t8
  %t10 = lshr i8 %t8, 7
  %t11 = shl i8 %t10, 5
  %t12 = xor i8 %t11, %t9
  ret i8 %t12
}
