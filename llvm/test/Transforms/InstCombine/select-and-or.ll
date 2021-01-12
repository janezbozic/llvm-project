; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine -instcombine-unsafe-select-transform=0 < %s | FileCheck %s

; Should not be converted to "and", which has different poison semantics.
define i1 @logical_and(i1 %a, i1 %b) {
; CHECK-LABEL: @logical_and(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 [[B:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %res = select i1 %a, i1 %b, i1 false
  ret i1 %res
}

; Should not be converted to "or", which has different poison semantics.
define i1 @logical_or(i1 %a, i1 %b) {
; CHECK-LABEL: @logical_or(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 true, i1 [[B:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %res = select i1 %a, i1 true, i1 %b
  ret i1 %res
}
; Canonicalize to logical and form, even if that requires adding a "not".
define i1 @logical_and_not(i1 %a, i1 %b) {
; CHECK-LABEL: @logical_and_not(
; CHECK-NEXT:    [[NOT_A:%.*]] = xor i1 [[A:%.*]], true
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[NOT_A]], i1 [[B:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %res = select i1 %a, i1 false, i1 %b
  ret i1 %res
}

; Canonicalize to logical or form, even if that requires adding a "not".
define i1 @logical_or_not(i1 %a, i1 %b) {
; CHECK-LABEL: @logical_or_not(
; CHECK-NEXT:    [[NOT_A:%.*]] = xor i1 [[A:%.*]], true
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[NOT_A]], i1 true, i1 [[B:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %res = select i1 %a, i1 %b, i1 true
  ret i1 %res
}

; These are variants where condition or !condition is used to represent true
; or false in one of the select arms. It should be canonicalized to the
; constants.

define i1 @logical_and_cond_reuse(i1 %a, i1 %b) {
; CHECK-LABEL: @logical_and_cond_reuse(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 [[B:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %res = select i1 %a, i1 %b, i1 %a
  ret i1 %res
}

define i1 @logical_or_cond_reuse(i1 %a, i1 %b) {
; CHECK-LABEL: @logical_or_cond_reuse(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 true, i1 [[B:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %res = select i1 %a, i1 %a, i1 %b
  ret i1 %res
}

define i1 @logical_and_not_cond_reuse(i1 %a, i1 %b) {
; CHECK-LABEL: @logical_and_not_cond_reuse(
; CHECK-NEXT:    [[A_NOT:%.*]] = xor i1 [[A:%.*]], true
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A_NOT]], i1 true, i1 [[B:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %a.not = xor i1 %a, true
  %res = select i1 %a, i1 %b, i1 %a.not
  ret i1 %res
}

define i1 @logical_or_not_cond_reuse(i1 %a, i1 %b) {
; CHECK-LABEL: @logical_or_not_cond_reuse(
; CHECK-NEXT:    [[A_NOT:%.*]] = xor i1 [[A:%.*]], true
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A_NOT]], i1 [[B:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %a.not = xor i1 %a, true
  %res = select i1 %a, i1 %a.not, i1 %b
  ret i1 %res
}

; Safe to convert to or due to poison implication.
define i1 @logical_or_implies(i32 %x) {
; CHECK-LABEL: @logical_or_implies(
; CHECK-NEXT:    [[C1:%.*]] = icmp eq i32 [[X:%.*]], 0
; CHECK-NEXT:    [[C2:%.*]] = icmp eq i32 [[X]], 42
; CHECK-NEXT:    [[RES:%.*]] = or i1 [[C1]], [[C2]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %c1 = icmp eq i32 %x, 0
  %c2 = icmp eq i32 %x, 42
  %res = select i1 %c1, i1 true, i1 %c2
  ret i1 %res
}

; Will fold after conversion to or.
define i1 @logical_or_implies_folds(i32 %x) {
; CHECK-LABEL: @logical_or_implies_folds(
; CHECK-NEXT:    ret i1 true
;
  %c1 = icmp slt i32 %x, 0
  %c2 = icmp sge i32 %x, 0
  %res = select i1 %c1, i1 true, i1 %c2
  ret i1 %res
}

; Safe to convert to and due to poison implication.
define i1 @logical_and_implies(i32 %x) {
; CHECK-LABEL: @logical_and_implies(
; CHECK-NEXT:    [[C1:%.*]] = icmp ne i32 [[X:%.*]], 0
; CHECK-NEXT:    [[C2:%.*]] = icmp ne i32 [[X]], 42
; CHECK-NEXT:    [[RES:%.*]] = and i1 [[C1]], [[C2]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %c1 = icmp ne i32 %x, 0
  %c2 = icmp ne i32 %x, 42
  %res = select i1 %c1, i1 %c2, i1 false
  ret i1 %res
}

; Will fold after conversion to and.
define i1 @logical_and_implies_folds(i32 %x) {
; CHECK-LABEL: @logical_and_implies_folds(
; CHECK-NEXT:    [[C1:%.*]] = icmp ugt i32 [[X:%.*]], 42
; CHECK-NEXT:    ret i1 [[C1]]
;
  %c1 = icmp ugt i32 %x, 42
  %c2 = icmp ne i32 %x, 0
  %res = select i1 %c1, i1 %c2, i1 false
  ret i1 %res
}

; Noundef on condition has no effect.
define i1 @logical_or_noundef_a(i1 noundef %a, i1 %b) {
; CHECK-LABEL: @logical_or_noundef_a(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 true, i1 [[B:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %res = select i1 %a, i1 true, i1 %b
  ret i1 %res
}

; Noundef on false value allows conversion to or.
; TODO: impliesPoison doesn't handle this yet.
define i1 @logical_or_noundef_b(i1 %a, i1 noundef %b) {
; CHECK-LABEL: @logical_or_noundef_b(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 true, i1 [[B:%.*]]
; CHECK-NEXT:    ret i1 [[RES]]
;
  %res = select i1 %a, i1 true, i1 %b
  ret i1 %res
}

; Noundef on condition has no effect.
define i1 @logical_and_noundef_a(i1 noundef %a, i1 %b) {
; CHECK-LABEL: @logical_and_noundef_a(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 [[B:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %res = select i1 %a, i1 %b, i1 false
  ret i1 %res
}

; Noundef on false value allows conversion to and.
; TODO: impliesPoison doesn't handle this yet.
define i1 @logical_and_noundef_b(i1 %a, i1 noundef %b) {
; CHECK-LABEL: @logical_and_noundef_b(
; CHECK-NEXT:    [[RES:%.*]] = select i1 [[A:%.*]], i1 [[B:%.*]], i1 false
; CHECK-NEXT:    ret i1 [[RES]]
;
  %res = select i1 %a, i1 %b, i1 false
  ret i1 %res
}
