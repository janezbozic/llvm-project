; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-vectorizer -o - -S -slp-threshold=-1000 | FileCheck %s

target datalayout = "e-p:32:32-i64:64-v16:16-v32:32-n16:32:64"
target triple = "nvptx--nvidiacl"

; CTLZ cannot be vectorized currently because the second argument is a scalar
; for both the scalar and vector forms of the intrinsic. In the future it
; should be possible to vectorize such functions.
; Test causes an assert if LLVM tries to vectorize CTLZ.

define <2 x i8> @cltz_test(<2 x i8> %x) #0 {
; CHECK-LABEL: @cltz_test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = extractelement <2 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    [[CALL_I:%.*]] = call i8 @llvm.ctlz.i8(i8 [[TMP0]], i1 false)
; CHECK-NEXT:    [[VECINIT:%.*]] = insertelement <2 x i8> poison, i8 [[CALL_I]], i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x i8> [[X]], i32 1
; CHECK-NEXT:    [[CALL_I4:%.*]] = call i8 @llvm.ctlz.i8(i8 [[TMP1]], i1 false)
; CHECK-NEXT:    [[VECINIT2:%.*]] = insertelement <2 x i8> [[VECINIT]], i8 [[CALL_I4]], i32 1
; CHECK-NEXT:    ret <2 x i8> [[VECINIT2]]
;
entry:
  %0 = extractelement <2 x i8> %x, i32 0
  %call.i = call i8 @llvm.ctlz.i8(i8 %0, i1 false)
  %vecinit = insertelement <2 x i8> poison, i8 %call.i, i32 0
  %1 = extractelement <2 x i8> %x, i32 1
  %call.i4 = call i8 @llvm.ctlz.i8(i8 %1, i1 false)
  %vecinit2 = insertelement <2 x i8> %vecinit, i8 %call.i4, i32 1
  ret <2 x i8> %vecinit2
}

define <2 x i8> @cltz_test2(<2 x i8> %x) #1 {
; CHECK-LABEL: @cltz_test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = extractelement <2 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x i8> [[X]], i32 1
; CHECK-NEXT:    [[CALL_I:%.*]] = call i8 @llvm.ctlz.i8(i8 [[TMP0]], i1 false)
; CHECK-NEXT:    [[CALL_I4:%.*]] = call i8 @llvm.ctlz.i8(i8 [[TMP1]], i1 false)
; CHECK-NEXT:    [[VECINIT:%.*]] = insertelement <2 x i8> poison, i8 [[CALL_I]], i32 0
; CHECK-NEXT:    [[VECINIT2:%.*]] = insertelement <2 x i8> [[VECINIT]], i8 [[CALL_I4]], i32 1
; CHECK-NEXT:    ret <2 x i8> [[VECINIT2]]
;
entry:
  %0 = extractelement <2 x i8> %x, i32 0
  %1 = extractelement <2 x i8> %x, i32 1
  %call.i = call i8 @llvm.ctlz.i8(i8 %0, i1 false)
  %call.i4 = call i8 @llvm.ctlz.i8(i8 %1, i1 false)
  %vecinit = insertelement <2 x i8> poison, i8 %call.i, i32 0
  %vecinit2 = insertelement <2 x i8> %vecinit, i8 %call.i4, i32 1
  ret <2 x i8> %vecinit2
}

declare i8 @llvm.ctlz.i8(i8, i1) #3

attributes #0 = { alwaysinline nounwind "less-precise-fpmad"="false" "frame-pointer"="all" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
