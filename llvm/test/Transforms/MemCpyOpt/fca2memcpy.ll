; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -memcpyopt -S < %s -enable-memcpyopt-memoryssa=0 | FileCheck %s
; RUN: opt -memcpyopt -S < %s -enable-memcpyopt-memoryssa=1 -verify-memoryssa | FileCheck %s

target datalayout = "e-i64:64-f80:128-n8:16:32:64"
target triple = "x86_64-unknown-linux-gnu"

%S = type { i8*, i8, i32 }

define void @copy(%S* %src, %S* %dst) {
; CHECK-LABEL: @copy(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast %S* [[DST:%.*]] to i8*
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast %S* [[SRC:%.*]] to i8*
; CHECK-NEXT:    call void @llvm.memmove.p0i8.p0i8.i64(i8* align 8 [[TMP1]], i8* align 8 [[TMP2]], i64 16, i1 false)
; CHECK-NEXT:    ret void
;
  %1 = load %S, %S* %src
  store %S %1, %S* %dst
  ret void
}

define void @noaliassrc(%S* noalias %src, %S* %dst) {
; CHECK-LABEL: @noaliassrc(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast %S* [[DST:%.*]] to i8*
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast %S* [[SRC:%.*]] to i8*
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 [[TMP1]], i8* align 8 [[TMP2]], i64 16, i1 false)
; CHECK-NEXT:    ret void
;
  %1 = load %S, %S* %src
  store %S %1, %S* %dst
  ret void
}

define void @noaliasdst(%S* %src, %S* noalias %dst) {
; CHECK-LABEL: @noaliasdst(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast %S* [[DST:%.*]] to i8*
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast %S* [[SRC:%.*]] to i8*
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 [[TMP1]], i8* align 8 [[TMP2]], i64 16, i1 false)
; CHECK-NEXT:    ret void
;
  %1 = load %S, %S* %src
  store %S %1, %S* %dst
  ret void
}

define void @destroysrc(%S* %src, %S* %dst) {
; CHECK-LABEL: @destroysrc(
; CHECK-NEXT:    [[TMP1:%.*]] = load [[S:%.*]], %S* [[SRC:%.*]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast %S* [[SRC]] to i8*
; CHECK-NEXT:    call void @llvm.memset.p0i8.i64(i8* align 8 [[TMP2]], i8 0, i64 16, i1 false)
; CHECK-NEXT:    store [[S]] [[TMP1]], %S* [[DST:%.*]], align 8
; CHECK-NEXT:    ret void
;
  %1 = load %S, %S* %src
  store %S zeroinitializer, %S* %src
  store %S %1, %S* %dst
  ret void
}

define void @destroynoaliassrc(%S* noalias %src, %S* %dst) {
; CHECK-LABEL: @destroynoaliassrc(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast %S* [[SRC:%.*]] to i8*
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast %S* [[DST:%.*]] to i8*
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast %S* [[SRC]] to i8*
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 [[TMP2]], i8* align 8 [[TMP3]], i64 16, i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0i8.i64(i8* align 8 [[TMP1]], i8 0, i64 16, i1 false)
; CHECK-NEXT:    ret void
;
  %1 = load %S, %S* %src
  store %S zeroinitializer, %S* %src
  store %S %1, %S* %dst
  ret void
}

define void @copyalias(%S* %src, %S* %dst) {
; CHECK-LABEL: @copyalias(
; CHECK-NEXT:    [[TMP1:%.*]] = load [[S:%.*]], %S* [[SRC:%.*]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast %S* [[DST:%.*]] to i8*
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast %S* [[SRC]] to i8*
; CHECK-NEXT:    call void @llvm.memmove.p0i8.p0i8.i64(i8* align 8 [[TMP2]], i8* align 8 [[TMP3]], i64 16, i1 false)
; CHECK-NEXT:    store [[S]] [[TMP1]], %S* [[DST]], align 8
; CHECK-NEXT:    ret void
;
  %1 = load %S, %S* %src
  %2 = load %S, %S* %src
  store %S %1, %S* %dst
  store %S %2, %S* %dst
  ret void
}

; If the store address is computed in a complex manner, make
; sure we lift the computation as well if needed and possible.
define void @addrproducer(%S* %src, %S* %dst) {
; CHECK-LABEL: @addrproducer(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast %S* [[DST:%.*]] to i8*
; CHECK-NEXT:    [[DST2:%.*]] = getelementptr [[S:%.*]], %S* [[DST]], i64 1
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast %S* [[DST2]] to i8*
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast %S* [[SRC:%.*]] to i8*
; CHECK-NEXT:    call void @llvm.memmove.p0i8.p0i8.i64(i8* align 8 [[TMP2]], i8* align 8 [[TMP3]], i64 16, i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0i8.i64(i8* align 8 [[TMP1]], i8 undef, i64 16, i1 false)
; CHECK-NEXT:    ret void
;
  %1 = load %S, %S* %src
  store %S undef, %S* %dst
  %dst2 = getelementptr %S , %S* %dst, i64 1
  store %S %1, %S* %dst2
  ret void
}

define void @aliasaddrproducer(%S* %src, %S* %dst, i32* %dstidptr) {
; CHECK-LABEL: @aliasaddrproducer(
; CHECK-NEXT:    [[TMP1:%.*]] = load [[S:%.*]], %S* [[SRC:%.*]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast %S* [[DST:%.*]] to i8*
; CHECK-NEXT:    call void @llvm.memset.p0i8.i64(i8* align 8 [[TMP2]], i8 undef, i64 16, i1 false)
; CHECK-NEXT:    [[DSTINDEX:%.*]] = load i32, i32* [[DSTIDPTR:%.*]], align 4
; CHECK-NEXT:    [[DST2:%.*]] = getelementptr [[S]], %S* [[DST]], i32 [[DSTINDEX]]
; CHECK-NEXT:    store [[S]] [[TMP1]], %S* [[DST2]], align 8
; CHECK-NEXT:    ret void
;
  %1 = load %S, %S* %src
  store %S undef, %S* %dst
  %dstindex = load i32, i32* %dstidptr
  %dst2 = getelementptr %S , %S* %dst, i32 %dstindex
  store %S %1, %S* %dst2
  ret void
}

define void @noaliasaddrproducer(%S* %src, %S* noalias %dst, i32* noalias %dstidptr) {
; CHECK-LABEL: @noaliasaddrproducer(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast %S* [[SRC:%.*]] to i8*
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* [[DSTIDPTR:%.*]], align 4
; CHECK-NEXT:    [[DSTINDEX:%.*]] = or i32 [[TMP2]], 1
; CHECK-NEXT:    [[DST2:%.*]] = getelementptr [[S:%.*]], %S* [[DST:%.*]], i32 [[DSTINDEX]]
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast %S* [[DST2]] to i8*
; CHECK-NEXT:    [[TMP4:%.*]] = bitcast %S* [[SRC]] to i8*
; CHECK-NEXT:    call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 [[TMP3]], i8* align 8 [[TMP4]], i64 16, i1 false)
; CHECK-NEXT:    call void @llvm.memset.p0i8.i64(i8* align 8 [[TMP1]], i8 undef, i64 16, i1 false)
; CHECK-NEXT:    ret void
;
  %1 = load %S, %S* %src
  store %S undef, %S* %src
  %2 = load i32, i32* %dstidptr
  %dstindex = or i32 %2, 1
  %dst2 = getelementptr %S , %S* %dst, i32 %dstindex
  store %S %1, %S* %dst2
  ret void
}

define void @throwing_call(%S* noalias %src, %S* %dst) {
; CHECK-LABEL: @throwing_call(
; CHECK-NEXT:    [[TMP1:%.*]] = load [[S:%.*]], %S* [[SRC:%.*]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast %S* [[SRC]] to i8*
; CHECK-NEXT:    call void @llvm.memset.p0i8.i64(i8* align 8 [[TMP2]], i8 0, i64 16, i1 false)
; CHECK-NEXT:    call void @call() [[ATTR2:#.*]]
; CHECK-NEXT:    store [[S]] [[TMP1]], %S* [[DST:%.*]], align 8
; CHECK-NEXT:    ret void
;
  %1 = load %S, %S* %src
  store %S zeroinitializer, %S* %src
  call void @call() readnone
  store %S %1, %S* %dst
  ret void
}

declare void @call()
