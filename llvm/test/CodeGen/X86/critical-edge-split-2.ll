; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s

%0 = type <{ %1, %1 }>
%1 = type { i8, i8, i8, i8 }

@g_2 = global %0 zeroinitializer
@g_4 = global %1 zeroinitializer, align 4

; PR8642
define i16 @test1(i1 zeroext %C, i8** nocapture %argv) nounwind ssp {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movw $1, %ax
; CHECK-NEXT:    testl %edi, %edi
; CHECK-NEXT:    jne .LBB0_2
; CHECK-NEXT:  # %bb.1: # %cond.false.i
; CHECK-NEXT:    movl $g_2+4, %eax
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    cmpq $g_4, %rax
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    movl $1, %eax
; CHECK-NEXT:    xorl %edx, %edx
; CHECK-NEXT:    divl %ecx
; CHECK-NEXT:    movl %edx, %eax
; CHECK-NEXT:  .LBB0_2: # %cond.end.i
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq

entry:
  br i1 %C, label %cond.end.i, label %cond.false.i

cond.false.i:
  br label %cond.end.i

cond.end.i:
  %call1 = phi i16 [ trunc (i32 srem (i32 1, i32 zext (i1 icmp eq (%1* bitcast (i8* getelementptr inbounds (%0, %0* @g_2, i64 0, i32 1, i32 0) to %1*), %1* @g_4) to i32)) to i16), %cond.false.i ], [ 1, %entry ]
  ret i16 %call1
}

