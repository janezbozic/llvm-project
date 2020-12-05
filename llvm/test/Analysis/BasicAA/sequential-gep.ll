; RUN: opt < %s -basic-aa -aa-eval -print-all-alias-modref-info -disable-output 2>&1 | FileCheck %s

; CHECK: Function: t1
; CHECK: NoAlias: i32* %gep1, i32* %gep2
define void @t1([8 x i32]* %p, i32 %addend, i32* %q) {
  %knownnonzero = load i32, i32* %q, !range !0
  %add = add nsw nuw i32 %addend, %knownnonzero
  %gep1 = getelementptr [8 x i32], [8 x i32]* %p, i32 2, i32 %addend
  %gep2 = getelementptr [8 x i32], [8 x i32]* %p, i32 2, i32 %add
  ret void
}

; CHECK: Function: t2
; CHECK: MayAlias: i32* %gep1, i32* %gep2
define void @t2([8 x i32]* %p, i32 %addend, i32* %q) {
  %knownnonzero = load i32, i32* %q, !range !0
  %add = add nsw nuw i32 %addend, %knownnonzero
  %gep1 = getelementptr [8 x i32], [8 x i32]* %p, i32 1, i32 %addend
  %gep2 = getelementptr [8 x i32], [8 x i32]* %p, i32 0, i32 %add
  ret void
}

; CHECK: Function: t3
; CHECK: MustAlias: i32* %gep1, i32* %gep2
define void @t3([8 x i32]* %p, i32 %addend, i32* %q) {
  %knownnonzero = load i32, i32* %q, !range !0
  %add = add nsw nuw i32 %addend, %knownnonzero
  %gep1 = getelementptr [8 x i32], [8 x i32]* %p, i32 0, i32 %add
  %gep2 = getelementptr [8 x i32], [8 x i32]* %p, i32 0, i32 %add
  ret void
}

; CHECK: Function: t4
; CHECK: MayAlias: i32* %gep1, i32* %gep2
define void @t4([8 x i32]* %p, i32 %addend, i32* %q) {
  %knownnonzero = load i32, i32* %q, !range !0
  %add = add nsw nuw i32 %addend, %knownnonzero
  %gep1 = getelementptr [8 x i32], [8 x i32]* %p, i32 1, i32 %addend
  %gep2 = getelementptr [8 x i32], [8 x i32]* %p, i32 %add, i32 %add
  ret void
}

; CHECK: Function: t5
; CHECK: MayAlias: i32* %gep2, i64* %bc
define void @t5([8 x i32]* %p, i32 %addend, i32* %q) {
  %knownnonzero = load i32, i32* %q, !range !0
  %add = add nsw nuw i32 %addend, %knownnonzero
  %gep1 = getelementptr [8 x i32], [8 x i32]* %p, i32 2, i32 %addend
  %gep2 = getelementptr [8 x i32], [8 x i32]* %p, i32 2, i32 %add
  %bc = bitcast i32* %gep1 to i64*
  ret void
}

; CHECK-LABEL: Function: add_non_zero_simple
; CHECK: MayAlias: i32* %gep1, i32* %gep2
; TODO: This could be NoAlias.
define void @add_non_zero_simple(i32* %p, i32 %addend, i32* %q) {
  %knownnonzero = load i32, i32* %q, !range !0
  %add = add i32 %addend, %knownnonzero
  %gep1 = getelementptr i32, i32* %p, i32 %addend
  %gep2 = getelementptr i32, i32* %p, i32 %add
  ret void
}

; CHECK-LABEL: Function: add_non_zero_different_scales
; CHECK: MayAlias: i16* %gep2, i32* %gep1
define void @add_non_zero_different_scales(i32* %p, i32 %addend, i32* %q) {
  %knownnonzero = load i32, i32* %q, !range !0
  %add = add i32 %addend, %knownnonzero
  %p16 = bitcast i32* %p to i16*
  %gep1 = getelementptr i32, i32* %p, i32 %addend
  %gep2 = getelementptr i16, i16* %p16, i32 %add
  ret void
}

; CHECK-LABEL: Function: add_non_zero_different_sizes
; CHECK: MayAlias: i16* %gep1.16, i32* %gep2
; CHECK: MayAlias: i16* %gep2.16, i32* %gep1
; CHECK: MayAlias: i16* %gep1.16, i16* %gep2.16
; CHECK: MayAlias: i32* %gep2, i64* %gep1.64
; CHECK: MayAlias: i16* %gep2.16, i64* %gep1.64
; CHECK: MayAlias: i32* %gep1, i64* %gep2.64
; CHECK: MayAlias: i16* %gep1.16, i64* %gep2.64
; CHECK: MayAlias: i64* %gep1.64, i64* %gep2.64
; TODO: The first three could be NoAlias.
define void @add_non_zero_different_sizes(i32* %p, i32 %addend, i32* %q) {
  %knownnonzero = load i32, i32* %q, !range !0
  %add = add i32 %addend, %knownnonzero
  %gep1 = getelementptr i32, i32* %p, i32 %addend
  %gep2 = getelementptr i32, i32* %p, i32 %add
  %gep1.16 = bitcast i32* %gep1 to i16*
  %gep2.16 = bitcast i32* %gep2 to i16*
  %gep1.64 = bitcast i32* %gep1 to i64*
  %gep2.64 = bitcast i32* %gep2 to i64*
  ret void
}


; CHECK-LABEL: add_non_zero_with_offset
; MayAlias: i32* %gep1, i32* %gep2
; NoAlias: i16* %gep1.16, i16* %gep2.16
define void @add_non_zero_with_offset(i32* %p, i32 %addend, i32* %q) {
  %knownnonzero = load i32, i32* %q, !range !0
  %add = add i32 %addend, %knownnonzero
  %p.8 = bitcast i32* %p to i8*
  %p.off.8 = getelementptr i8, i8* %p.8, i32 2
  %p.off = bitcast i8* %p.off.8 to i32*
  %gep1 = getelementptr i32, i32* %p.off, i32 %addend
  %gep2 = getelementptr i32, i32* %p, i32 %add
  %gep1.16 = bitcast i32* %gep1 to i16*
  %gep2.16 = bitcast i32* %gep2 to i16*
  ret void
}

!0 = !{ i32 1, i32 5 }
