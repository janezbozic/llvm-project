; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -aggressive-instcombine -S | FileCheck %s

define i32 @fshl(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @fshl(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[TMP0:%.*]] = freeze i32 [[B:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.fshl.i32(i32 [[A:%.*]], i32 [[TMP0]], i32 [[C]])
; CHECK-NEXT:    ret i32 [[TMP1]]
;
entry:
  %cmp = icmp eq i32 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i32 32, %c
  %shr = lshr i32 %b, %sub
  %shl = shl i32 %a, %c
  %or = or i32 %shr, %shl
  br label %end

end:
  %cond = phi i32 [ %or, %fshbb ], [ %a, %entry ]
  ret i32 %cond
}

define i32 @fshl_commute_phi(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @fshl_commute_phi(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[TMP0:%.*]] = freeze i32 [[B:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.fshl.i32(i32 [[A:%.*]], i32 [[TMP0]], i32 [[C]])
; CHECK-NEXT:    ret i32 [[TMP1]]
;
entry:
  %cmp = icmp eq i32 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i32 32, %c
  %shr = lshr i32 %b, %sub
  %shl = shl i32 %a, %c
  %or = or i32 %shr, %shl
  br label %end

end:
  %cond = phi i32 [ %a, %entry ], [ %or, %fshbb ]
  ret i32 %cond
}

define i32 @fshl_commute_or(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @fshl_commute_or(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[TMP0:%.*]] = freeze i32 [[B:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.fshl.i32(i32 [[A:%.*]], i32 [[TMP0]], i32 [[C]])
; CHECK-NEXT:    ret i32 [[TMP1]]
;
entry:
  %cmp = icmp eq i32 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i32 32, %c
  %shr = lshr i32 %b, %sub
  %shl = shl i32 %a, %c
  %or = or i32 %shl, %shr
  br label %end

end:
  %cond = phi i32 [ %a, %entry ], [ %or, %fshbb ]
  ret i32 %cond
}

; Verify that the intrinsic is inserted into a valid position.

define i32 @fshl_insert_valid_location(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @fshl_insert_valid_location(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[OTHER:%.*]] = phi i32 [ 1, [[FSHBB]] ], [ 2, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = freeze i32 [[B:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.fshl.i32(i32 [[A:%.*]], i32 [[TMP0]], i32 [[C]])
; CHECK-NEXT:    [[RES:%.*]] = or i32 [[TMP1]], [[OTHER]]
; CHECK-NEXT:    ret i32 [[RES]]
;
entry:
  %cmp = icmp eq i32 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i32 32, %c
  %shr = lshr i32 %b, %sub
  %shl = shl i32 %a, %c
  %or = or i32 %shr, %shl
  br label %end

end:
  %cond = phi i32 [ %or, %fshbb ], [ %a, %entry ]
  %other = phi i32 [ 1, %fshbb ], [ 2, %entry ]
  %res = or i32 %cond, %other
  ret i32 %res
}

define i32 @fshr(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @fshr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[TMP0:%.*]] = freeze i32 [[A:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.fshr.i32(i32 [[TMP0]], i32 [[B:%.*]], i32 [[C]])
; CHECK-NEXT:    ret i32 [[TMP1]]
;
entry:
  %cmp = icmp eq i32 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i32 32, %c
  %shl = shl i32 %a, %sub
  %shr = lshr i32 %b, %c
  %or = or i32 %shr, %shl
  br label %end

end:
  %cond = phi i32 [ %or, %fshbb ], [ %b, %entry ]
  ret i32 %cond
}

define i32 @fshr_commute_phi(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @fshr_commute_phi(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[TMP0:%.*]] = freeze i32 [[A:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.fshr.i32(i32 [[TMP0]], i32 [[B:%.*]], i32 [[C]])
; CHECK-NEXT:    ret i32 [[TMP1]]
;
entry:
  %cmp = icmp eq i32 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i32 32, %c
  %shl = shl i32 %a, %sub
  %shr = lshr i32 %b, %c
  %or = or i32 %shr, %shl
  br label %end

end:
  %cond = phi i32 [ %b, %entry ], [ %or, %fshbb ]
  ret i32 %cond
}

define i32 @fshr_commute_or(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @fshr_commute_or(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[TMP0:%.*]] = freeze i32 [[A:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.fshr.i32(i32 [[TMP0]], i32 [[B:%.*]], i32 [[C]])
; CHECK-NEXT:    ret i32 [[TMP1]]
;
entry:
  %cmp = icmp eq i32 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i32 32, %c
  %shl = shl i32 %a, %sub
  %shr = lshr i32 %b, %c
  %or = or i32 %shl, %shr
  br label %end

end:
  %cond = phi i32 [ %b, %entry ], [ %or, %fshbb ]
  ret i32 %cond
}

; Negative test - non-power-of-2 might require urem expansion in the backend.

define i12 @could_be_fshr_weird_type(i12 %a, i12 %b, i12 %c) {
; CHECK-LABEL: @could_be_fshr_weird_type(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i12 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    [[SUB:%.*]] = sub i12 12, [[C]]
; CHECK-NEXT:    [[SHL:%.*]] = shl i12 [[A:%.*]], [[SUB]]
; CHECK-NEXT:    [[SHR:%.*]] = lshr i12 [[B:%.*]], [[C]]
; CHECK-NEXT:    [[OR:%.*]] = or i12 [[SHL]], [[SHR]]
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[COND:%.*]] = phi i12 [ [[B]], [[ENTRY:%.*]] ], [ [[OR]], [[FSHBB]] ]
; CHECK-NEXT:    ret i12 [[COND]]
;
entry:
  %cmp = icmp eq i12 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i12 12, %c
  %shl = shl i12 %a, %sub
  %shr = lshr i12 %b, %c
  %or = or i12 %shl, %shr
  br label %end

end:
  %cond = phi i12 [ %b, %entry ], [ %or, %fshbb ]
  ret i12 %cond
}

; Negative test - wrong phi ops.

define i32 @not_fshr_1(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @not_fshr_1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 32, [[C]]
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[A:%.*]], [[SUB]]
; CHECK-NEXT:    [[SHR:%.*]] = lshr i32 [[B:%.*]], [[C]]
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[SHL]], [[SHR]]
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[C]], [[ENTRY:%.*]] ], [ [[OR]], [[FSHBB]] ]
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  %cmp = icmp eq i32 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i32 32, %c
  %shl = shl i32 %a, %sub
  %shr = lshr i32 %b, %c
  %or = or i32 %shl, %shr
  br label %end

end:
  %cond = phi i32 [ %c, %entry ], [ %or, %fshbb ]
  ret i32 %cond
}

; Negative test - too many phi ops.

define i32 @not_fshr_2(i32 %a, i32 %b, i32 %c, i32 %d) {
; CHECK-LABEL: @not_fshr_2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 32, [[C]]
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[A:%.*]], [[SUB]]
; CHECK-NEXT:    [[SHR:%.*]] = lshr i32 [[B:%.*]], [[C]]
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[SHL]], [[SHR]]
; CHECK-NEXT:    [[CMP42:%.*]] = icmp ugt i32 [[OR]], 42
; CHECK-NEXT:    br i1 [[CMP42]], label [[END]], label [[BOGUS:%.*]]
; CHECK:       bogus:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[B]], [[ENTRY:%.*]] ], [ [[OR]], [[FSHBB]] ], [ [[D:%.*]], [[BOGUS]] ]
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  %cmp = icmp eq i32 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i32 32, %c
  %shl = shl i32 %a, %sub
  %shr = lshr i32 %b, %c
  %or = or i32 %shl, %shr
  %cmp42 = icmp ugt i32 %or, 42
  br i1 %cmp42, label %end, label %bogus

bogus:
  br label %end

end:
  %cond = phi i32 [ %b, %entry ], [ %or, %fshbb ], [ %d, %bogus ]
  ret i32 %cond
}

; Negative test - wrong cmp (but this should match?).

define i32 @not_fshr_3(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @not_fshr_3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i32 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 32, [[C]]
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[A:%.*]], [[SUB]]
; CHECK-NEXT:    [[SHR:%.*]] = lshr i32 [[B:%.*]], [[C]]
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[SHL]], [[SHR]]
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[B]], [[ENTRY:%.*]] ], [ [[OR]], [[FSHBB]] ]
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  %cmp = icmp sle i32 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i32 32, %c
  %shl = shl i32 %a, %sub
  %shr = lshr i32 %b, %c
  %or = or i32 %shl, %shr
  br label %end

end:
  %cond = phi i32 [ %b, %entry ], [ %or, %fshbb ]
  ret i32 %cond
}

; Negative test - wrong shift.

define i32 @not_fshr_4(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @not_fshr_4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 32, [[C]]
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[A:%.*]], [[SUB]]
; CHECK-NEXT:    [[SHR:%.*]] = ashr i32 [[B:%.*]], [[C]]
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[SHL]], [[SHR]]
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[B]], [[ENTRY:%.*]] ], [ [[OR]], [[FSHBB]] ]
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  %cmp = icmp eq i32 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i32 32, %c
  %shl = shl i32 %a, %sub
  %shr = ashr i32 %b, %c
  %or = or i32 %shl, %shr
  br label %end

end:
  %cond = phi i32 [ %b, %entry ], [ %or, %fshbb ]
  ret i32 %cond
}

; Negative test - wrong shift for rotate (but can be folded to a generic funnel shift).

define i32 @not_fshr_5(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @not_fshr_5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[TMP0:%.*]] = freeze i32 [[C]]
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.fshr.i32(i32 [[TMP0]], i32 [[B:%.*]], i32 [[C]])
; CHECK-NEXT:    ret i32 [[TMP1]]
;
entry:
  %cmp = icmp eq i32 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i32 32, %c
  %shl = shl i32 %c, %sub
  %shr = lshr i32 %b, %c
  %or = or i32 %shl, %shr
  br label %end

end:
  %cond = phi i32 [ %b, %entry ], [ %or, %fshbb ]
  ret i32 %cond
}

; Negative test - wrong sub.

define i32 @not_fshr_6(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: @not_fshr_6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 8, [[C]]
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[A:%.*]], [[SUB]]
; CHECK-NEXT:    [[SHR:%.*]] = lshr i32 [[B:%.*]], [[C]]
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[SHL]], [[SHR]]
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[B]], [[ENTRY:%.*]] ], [ [[OR]], [[FSHBB]] ]
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  %cmp = icmp eq i32 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i32 8, %c
  %shl = shl i32 %a, %sub
  %shr = lshr i32 %b, %c
  %or = or i32 %shl, %shr
  br label %end

end:
  %cond = phi i32 [ %b, %entry ], [ %or, %fshbb ]
  ret i32 %cond
}

; Negative test - extra use. Technically, we could transform this
; because it doesn't increase the instruction count, but we're
; being cautious not to cause a potential perf pessimization for
; targets that do not have a fshate instruction.

define i32 @could_be_fshr(i32 %a, i32 %b, i32 %c, i32* %p) {
; CHECK-LABEL: @could_be_fshr(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[C:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[END:%.*]], label [[FSHBB:%.*]]
; CHECK:       fshbb:
; CHECK-NEXT:    [[SUB:%.*]] = sub i32 32, [[C]]
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[A:%.*]], [[SUB]]
; CHECK-NEXT:    [[SHR:%.*]] = lshr i32 [[B:%.*]], [[C]]
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[SHL]], [[SHR]]
; CHECK-NEXT:    store i32 [[OR]], i32* [[P:%.*]], align 4
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[COND:%.*]] = phi i32 [ [[B]], [[ENTRY:%.*]] ], [ [[OR]], [[FSHBB]] ]
; CHECK-NEXT:    ret i32 [[COND]]
;
entry:
  %cmp = icmp eq i32 %c, 0
  br i1 %cmp, label %end, label %fshbb

fshbb:
  %sub = sub i32 32, %c
  %shl = shl i32 %a, %sub
  %shr = lshr i32 %b, %c
  %or = or i32 %shl, %shr
  store i32 %or, i32* %p
  br label %end

end:
  %cond = phi i32 [ %b, %entry ], [ %or, %fshbb ]
  ret i32 %cond
}

; PR48068 - Ensure we don't fold a funnel shift that depends on a shift value that
; can't be hoisted out of a basic block.
@a = global i32 0, align 4
declare i32 @i(...)
declare i32 @f(...)

define i32 @PR48068() {
; CHECK-LABEL: @PR48068(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CALL:%.*]] = call i32 bitcast (i32 (...)* @i to i32 ()*)()
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* @a, align 4
; CHECK-NEXT:    [[TOBOOL_NOT:%.*]] = icmp eq i32 [[TMP0]], 0
; CHECK-NEXT:    br i1 [[TOBOOL_NOT]], label [[IF_END:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    [[SHL:%.*]] = shl i32 [[CALL]], [[TMP0]]
; CHECK-NEXT:    [[CALL_I:%.*]] = call i32 bitcast (i32 (...)* @f to i32 ()*)()
; CHECK-NEXT:    [[SUB_I:%.*]] = sub nsw i32 32, [[TMP0]]
; CHECK-NEXT:    [[SHR_I:%.*]] = lshr i32 [[CALL_I]], [[SUB_I]]
; CHECK-NEXT:    [[OR:%.*]] = or i32 [[SHL]], [[SHR_I]]
; CHECK-NEXT:    br label [[IF_END]]
; CHECK:       if.end:
; CHECK-NEXT:    [[H_0:%.*]] = phi i32 [ [[OR]], [[IF_THEN]] ], [ [[CALL]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i32 [[H_0]]
;
entry:
  %call = call i32 bitcast (i32 (...)* @i to i32 ()*)()
  %0 = load i32, i32* @a, align 4
  %tobool.not = icmp eq i32 %0, 0
  br i1 %tobool.not, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %shl = shl i32 %call, %0
  %call.i = call i32 bitcast (i32 (...)* @f to i32 ()*)()
  %sub.i = sub nsw i32 32, %0
  %shr.i = lshr i32 %call.i, %sub.i
  %or = or i32 %shl, %shr.i
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %h.0 = phi i32 [ %or, %if.then ], [ %call, %entry ]
  ret i32 %h.0
}
