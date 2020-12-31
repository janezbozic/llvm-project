; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -mtriple aarch64 -stop-after=irtranslator -global-isel -verify-machineinstrs %s -o - 2>&1 | FileCheck %s

declare i32 @bar(...)
define void @or_cond(i32 %X, i32 %Y, i32 %Z) nounwind {
  ; CHECK-LABEL: name: or_cond
  ; CHECK: bb.1.entry:
  ; CHECK:   successors: %bb.2(0x20000000), %bb.4(0x60000000)
  ; CHECK:   liveins: $w0, $w1, $w2
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s32) = COPY $w1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w2
  ; CHECK:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; CHECK:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 5
  ; CHECK:   [[ICMP:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[COPY]](s32), [[C]]
  ; CHECK:   [[ICMP1:%[0-9]+]]:_(s1) = G_ICMP intpred(slt), [[COPY1]](s32), [[C1]]
  ; CHECK:   [[OR:%[0-9]+]]:_(s1) = G_OR [[ICMP1]], [[ICMP]]
  ; CHECK:   [[ICMP2:%[0-9]+]]:_(s1) = G_ICMP intpred(slt), [[COPY1]](s32), [[C1]]
  ; CHECK:   G_BRCOND [[ICMP2]](s1), %bb.2
  ; CHECK:   G_BR %bb.4
  ; CHECK: bb.4.entry:
  ; CHECK:   successors: %bb.2(0x2aaaaaab), %bb.3(0x55555555)
  ; CHECK:   [[ICMP3:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[COPY]](s32), [[C]]
  ; CHECK:   G_BRCOND [[ICMP3]](s1), %bb.2
  ; CHECK:   G_BR %bb.3
  ; CHECK: bb.2.cond_true:
  ; CHECK:   TCRETURNdi @bar, 0, csr_aarch64_aapcs, implicit $sp
  ; CHECK: bb.3.UnifiedReturnBlock:
  ; CHECK:   RET_ReallyLR
entry:
  %tmp1 = icmp eq i32 %X, 0
  %tmp3 = icmp slt i32 %Y, 5
  %tmp4 = or i1 %tmp3, %tmp1
  br i1 %tmp4, label %cond_true, label %UnifiedReturnBlock

cond_true:
  %tmp5 = tail call i32 (...) @bar( )
  ret void

UnifiedReturnBlock:
  ret void
}

define void @or_cond_select(i32 %X, i32 %Y, i32 %Z) nounwind {
  ; CHECK-LABEL: name: or_cond_select
  ; CHECK: bb.1.entry:
  ; CHECK:   successors: %bb.2(0x20000000), %bb.4(0x60000000)
  ; CHECK:   liveins: $w0, $w1, $w2
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s32) = COPY $w1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w2
  ; CHECK:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; CHECK:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 5
  ; CHECK:   [[C2:%[0-9]+]]:_(s1) = G_CONSTANT i1 true
  ; CHECK:   [[ICMP:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[COPY]](s32), [[C]]
  ; CHECK:   [[ICMP1:%[0-9]+]]:_(s1) = G_ICMP intpred(slt), [[COPY1]](s32), [[C1]]
  ; CHECK:   [[SELECT:%[0-9]+]]:_(s1) = G_SELECT [[ICMP1]](s1), [[C2]], [[ICMP]]
  ; CHECK:   [[ICMP2:%[0-9]+]]:_(s1) = G_ICMP intpred(slt), [[COPY1]](s32), [[C1]]
  ; CHECK:   G_BRCOND [[ICMP2]](s1), %bb.2
  ; CHECK:   G_BR %bb.4
  ; CHECK: bb.4.entry:
  ; CHECK:   successors: %bb.2(0x2aaaaaab), %bb.3(0x55555555)
  ; CHECK:   [[ICMP3:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[COPY]](s32), [[C]]
  ; CHECK:   G_BRCOND [[ICMP3]](s1), %bb.2
  ; CHECK:   G_BR %bb.3
  ; CHECK: bb.2.cond_true:
  ; CHECK:   TCRETURNdi @bar, 0, csr_aarch64_aapcs, implicit $sp
  ; CHECK: bb.3.UnifiedReturnBlock:
  ; CHECK:   RET_ReallyLR
entry:
  %tmp1 = icmp eq i32 %X, 0
  %tmp3 = icmp slt i32 %Y, 5
  %tmp4 = select i1 %tmp3, i1 true, i1 %tmp1
  br i1 %tmp4, label %cond_true, label %UnifiedReturnBlock

cond_true:
  %tmp5 = tail call i32 (...) @bar( )
  ret void

UnifiedReturnBlock:
  ret void
}

define void @and_cond(i32 %X, i32 %Y, i32 %Z) nounwind {
  ; CHECK-LABEL: name: and_cond
  ; CHECK: bb.1.entry:
  ; CHECK:   successors: %bb.4(0x60000000), %bb.3(0x20000000)
  ; CHECK:   liveins: $w0, $w1, $w2
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s32) = COPY $w1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w2
  ; CHECK:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; CHECK:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 5
  ; CHECK:   [[ICMP:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[COPY]](s32), [[C]]
  ; CHECK:   [[ICMP1:%[0-9]+]]:_(s1) = G_ICMP intpred(slt), [[COPY1]](s32), [[C1]]
  ; CHECK:   [[AND:%[0-9]+]]:_(s1) = G_AND [[ICMP1]], [[ICMP]]
  ; CHECK:   [[ICMP2:%[0-9]+]]:_(s1) = G_ICMP intpred(slt), [[COPY1]](s32), [[C1]]
  ; CHECK:   G_BRCOND [[ICMP2]](s1), %bb.4
  ; CHECK:   G_BR %bb.3
  ; CHECK: bb.4.entry:
  ; CHECK:   successors: %bb.2(0x55555555), %bb.3(0x2aaaaaab)
  ; CHECK:   [[ICMP3:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[COPY]](s32), [[C]]
  ; CHECK:   G_BRCOND [[ICMP3]](s1), %bb.2
  ; CHECK:   G_BR %bb.3
  ; CHECK: bb.2.cond_true:
  ; CHECK:   TCRETURNdi @bar, 0, csr_aarch64_aapcs, implicit $sp
  ; CHECK: bb.3.UnifiedReturnBlock:
  ; CHECK:   RET_ReallyLR
entry:
  %tmp1 = icmp eq i32 %X, 0
  %tmp3 = icmp slt i32 %Y, 5
  %tmp4 = and i1 %tmp3, %tmp1
  br i1 %tmp4, label %cond_true, label %UnifiedReturnBlock

cond_true:
  %tmp5 = tail call i32 (...) @bar( )
  ret void

UnifiedReturnBlock:
  ret void
}

define void @and_cond_select(i32 %X, i32 %Y, i32 %Z) nounwind {
  ; CHECK-LABEL: name: and_cond_select
  ; CHECK: bb.1.entry:
  ; CHECK:   successors: %bb.4(0x60000000), %bb.3(0x20000000)
  ; CHECK:   liveins: $w0, $w1, $w2
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s32) = COPY $w1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w2
  ; CHECK:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; CHECK:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 5
  ; CHECK:   [[C2:%[0-9]+]]:_(s1) = G_CONSTANT i1 false
  ; CHECK:   [[ICMP:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[COPY]](s32), [[C]]
  ; CHECK:   [[ICMP1:%[0-9]+]]:_(s1) = G_ICMP intpred(slt), [[COPY1]](s32), [[C1]]
  ; CHECK:   [[SELECT:%[0-9]+]]:_(s1) = G_SELECT [[ICMP1]](s1), [[ICMP]], [[C2]]
  ; CHECK:   [[ICMP2:%[0-9]+]]:_(s1) = G_ICMP intpred(slt), [[COPY1]](s32), [[C1]]
  ; CHECK:   G_BRCOND [[ICMP2]](s1), %bb.4
  ; CHECK:   G_BR %bb.3
  ; CHECK: bb.4.entry:
  ; CHECK:   successors: %bb.2(0x55555555), %bb.3(0x2aaaaaab)
  ; CHECK:   [[ICMP3:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[COPY]](s32), [[C]]
  ; CHECK:   G_BRCOND [[ICMP3]](s1), %bb.2
  ; CHECK:   G_BR %bb.3
  ; CHECK: bb.2.cond_true:
  ; CHECK:   TCRETURNdi @bar, 0, csr_aarch64_aapcs, implicit $sp
  ; CHECK: bb.3.UnifiedReturnBlock:
  ; CHECK:   RET_ReallyLR
entry:
  %tmp1 = icmp eq i32 %X, 0
  %tmp3 = icmp slt i32 %Y, 5
  %tmp4 = select i1 %tmp3, i1 %tmp1, i1 false
  br i1 %tmp4, label %cond_true, label %UnifiedReturnBlock

cond_true:
  %tmp5 = tail call i32 (...) @bar( )
  ret void

UnifiedReturnBlock:
  ret void
}

; Don't emit two branches for same operands.
define void @or_cond_same_values_cmp(i32 %X, i32 %Y, i32 %Z) nounwind {
  ; CHECK-LABEL: name: or_cond_same_values_cmp
  ; CHECK: bb.1.entry:
  ; CHECK:   successors: %bb.2(0x40000000), %bb.3(0x40000000)
  ; CHECK:   liveins: $w0, $w1, $w2
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s32) = COPY $w1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w2
  ; CHECK:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 5
  ; CHECK:   [[ICMP:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[COPY]](s32), [[C]]
  ; CHECK:   [[ICMP1:%[0-9]+]]:_(s1) = G_ICMP intpred(slt), [[COPY]](s32), [[C]]
  ; CHECK:   [[OR:%[0-9]+]]:_(s1) = G_OR [[ICMP1]], [[ICMP]]
  ; CHECK:   G_BRCOND [[OR]](s1), %bb.2
  ; CHECK:   G_BR %bb.3
  ; CHECK: bb.2.cond_true:
  ; CHECK:   TCRETURNdi @bar, 0, csr_aarch64_aapcs, implicit $sp
  ; CHECK: bb.3.UnifiedReturnBlock:
  ; CHECK:   RET_ReallyLR
entry:
  %tmp1 = icmp eq i32 %X, 5
  %tmp3 = icmp slt i32 %X, 5
  %tmp4 = or i1 %tmp3, %tmp1
  br i1 %tmp4, label %cond_true, label %UnifiedReturnBlock

cond_true:
  %tmp5 = tail call i32 (...) @bar( )
  ret void

UnifiedReturnBlock:
  ret void
}

; Emit multiple branches for more than 2 cases.
define void @or_cond_multiple_cases(i32 %X, i32 %Y, i32 %Z) nounwind {
  ; CHECK-LABEL: name: or_cond_multiple_cases
  ; CHECK: bb.1.entry:
  ; CHECK:   successors: %bb.2(0x10000000), %bb.5(0x70000000)
  ; CHECK:   liveins: $w0, $w1, $w2
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s32) = COPY $w1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w2
  ; CHECK:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 5
  ; CHECK:   [[ICMP:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[COPY]](s32), [[C]]
  ; CHECK:   [[ICMP1:%[0-9]+]]:_(s1) = G_ICMP intpred(slt), [[COPY]](s32), [[C]]
  ; CHECK:   [[ICMP2:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[COPY2]](s32), [[C]]
  ; CHECK:   [[OR:%[0-9]+]]:_(s1) = G_OR [[ICMP1]], [[ICMP]]
  ; CHECK:   [[OR1:%[0-9]+]]:_(s1) = G_OR [[OR]], [[ICMP2]]
  ; CHECK:   [[ICMP3:%[0-9]+]]:_(s1) = G_ICMP intpred(slt), [[COPY]](s32), [[C]]
  ; CHECK:   G_BRCOND [[ICMP3]](s1), %bb.2
  ; CHECK:   G_BR %bb.5
  ; CHECK: bb.5.entry:
  ; CHECK:   successors: %bb.2(0x12492492), %bb.4(0x6db6db6e)
  ; CHECK:   [[ICMP4:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[COPY]](s32), [[C]]
  ; CHECK:   G_BRCOND [[ICMP4]](s1), %bb.2
  ; CHECK:   G_BR %bb.4
  ; CHECK: bb.4.entry:
  ; CHECK:   successors: %bb.2(0x2aaaaaab), %bb.3(0x55555555)
  ; CHECK:   [[ICMP5:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[COPY2]](s32), [[C]]
  ; CHECK:   G_BRCOND [[ICMP5]](s1), %bb.2
  ; CHECK:   G_BR %bb.3
  ; CHECK: bb.2.cond_true:
  ; CHECK:   TCRETURNdi @bar, 0, csr_aarch64_aapcs, implicit $sp
  ; CHECK: bb.3.UnifiedReturnBlock:
  ; CHECK:   RET_ReallyLR
entry:
  %tmp1 = icmp eq i32 %X, 5
  %tmp3 = icmp slt i32 %X, 5
  %tmpZ = icmp eq i32 %Z, 5
  %tmp4 = or i1 %tmp3, %tmp1
  %final = or i1 %tmp4, %tmpZ
  br i1 %final, label %cond_true, label %UnifiedReturnBlock

cond_true:
  %tmp5 = tail call i32 (...) @bar( )
  ret void

UnifiedReturnBlock:
  ret void
}

; (X != null) | (Y != null) --> (X|Y) != 0
; Don't emit two branches.
define void @or_cond_ne_null(i32 %X, i32 %Y, i32 %Z) nounwind {
  ; CHECK-LABEL: name: or_cond_ne_null
  ; CHECK: bb.1.entry:
  ; CHECK:   successors: %bb.2(0x40000000), %bb.3(0x40000000)
  ; CHECK:   liveins: $w0, $w1, $w2
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s32) = COPY $w1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w2
  ; CHECK:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; CHECK:   [[ICMP:%[0-9]+]]:_(s1) = G_ICMP intpred(ne), [[COPY]](s32), [[C]]
  ; CHECK:   [[ICMP1:%[0-9]+]]:_(s1) = G_ICMP intpred(ne), [[COPY1]](s32), [[C]]
  ; CHECK:   [[OR:%[0-9]+]]:_(s1) = G_OR [[ICMP1]], [[ICMP]]
  ; CHECK:   G_BRCOND [[OR]](s1), %bb.2
  ; CHECK:   G_BR %bb.3
  ; CHECK: bb.2.cond_true:
  ; CHECK:   TCRETURNdi @bar, 0, csr_aarch64_aapcs, implicit $sp
  ; CHECK: bb.3.UnifiedReturnBlock:
  ; CHECK:   RET_ReallyLR
entry:
  %tmp1 = icmp ne i32 %X, 0
  %tmp3 = icmp ne i32 %Y, 0
  %tmp4 = or i1 %tmp3, %tmp1
  br i1 %tmp4, label %cond_true, label %UnifiedReturnBlock

cond_true:
  %tmp5 = tail call i32 (...) @bar( )
  ret void

UnifiedReturnBlock:
  ret void
}

; If the branch is unpredictable, don't add another branch
; regardless of whether they are expensive or not.

define void @unpredictable(i32 %X, i32 %Y, i32 %Z) nounwind {
  ; CHECK-LABEL: name: unpredictable
  ; CHECK: bb.1.entry:
  ; CHECK:   successors: %bb.2(0x40000000), %bb.3(0x40000000)
  ; CHECK:   liveins: $w0, $w1, $w2
  ; CHECK:   [[COPY:%[0-9]+]]:_(s32) = COPY $w0
  ; CHECK:   [[COPY1:%[0-9]+]]:_(s32) = COPY $w1
  ; CHECK:   [[COPY2:%[0-9]+]]:_(s32) = COPY $w2
  ; CHECK:   [[C:%[0-9]+]]:_(s32) = G_CONSTANT i32 0
  ; CHECK:   [[C1:%[0-9]+]]:_(s32) = G_CONSTANT i32 5
  ; CHECK:   [[ICMP:%[0-9]+]]:_(s1) = G_ICMP intpred(eq), [[COPY]](s32), [[C]]
  ; CHECK:   [[ICMP1:%[0-9]+]]:_(s1) = G_ICMP intpred(slt), [[COPY1]](s32), [[C1]]
  ; CHECK:   [[OR:%[0-9]+]]:_(s1) = G_OR [[ICMP1]], [[ICMP]]
  ; CHECK:   G_BRCOND [[OR]](s1), %bb.2
  ; CHECK:   G_BR %bb.3
  ; CHECK: bb.2.cond_true:
  ; CHECK:   TCRETURNdi @bar, 0, csr_aarch64_aapcs, implicit $sp
  ; CHECK: bb.3.UnifiedReturnBlock:
  ; CHECK:   RET_ReallyLR
entry:
  %tmp1 = icmp eq i32 %X, 0
  %tmp3 = icmp slt i32 %Y, 5
  %tmp4 = or i1 %tmp3, %tmp1
  br i1 %tmp4, label %cond_true, label %UnifiedReturnBlock, !unpredictable !0

cond_true:
  %tmp5 = tail call i32 (...) @bar( )
  ret void

UnifiedReturnBlock:
  ret void
}

!0 = !{}
