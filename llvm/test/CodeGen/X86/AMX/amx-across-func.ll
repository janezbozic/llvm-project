; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+amx-int8 -mattr=+avx512f -verify-machineinstrs | FileCheck %s
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__tile_str = type <{ i16, i16, [60 x i8], <256 x i32> }>

@buf = dso_local global [3072 x i8] zeroinitializer, align 16

define dso_local void @test_api(i16 signext %0, i16 signext %1) local_unnamed_addr #2 {
; CHECK-LABEL: test_api:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    pushq %r15
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    pushq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 40
; CHECK-NEXT:    subq $4056, %rsp # imm = 0xFD8
; CHECK-NEXT:    .cfi_def_cfa_offset 4096
; CHECK-NEXT:    .cfi_offset %rbx, -40
; CHECK-NEXT:    .cfi_offset %r14, -32
; CHECK-NEXT:    .cfi_offset %r15, -24
; CHECK-NEXT:    .cfi_offset %rbp, -16
; CHECK-NEXT:    movl %esi, %ebx
; CHECK-NEXT:    movl %edi, %ebp
; CHECK-NEXT:    vpxord %zmm0, %zmm0, %zmm0
; CHECK-NEXT:    vmovdqu64 %zmm0, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $1, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %bpl, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw %bx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb %bpl, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movb $8, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    movw %bx, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    ldtilecfg {{[0-9]+}}(%rsp)
; CHECK-NEXT:    sttilecfg {{[-0-9]+}}(%r{{[sb]}}p) # 64-byte Folded Spill
; CHECK-NEXT:    movl $buf, %eax
; CHECK-NEXT:    movl $32, %r14d
; CHECK-NEXT:    movw $8, %r15w
; CHECK-NEXT:    tileloadd (%rax,%r14), %tmm1
; CHECK-NEXT:    movabsq $64, %rax
; CHECK-NEXT:    tilestored %tmm1, 2048(%rsp,%rax) # 1024-byte Folded Spill
; CHECK-NEXT:    movl $buf+1024, %eax
; CHECK-NEXT:    tileloadd (%rax,%r14), %tmm2
; CHECK-NEXT:    movabsq $64, %rax
; CHECK-NEXT:    tilestored %tmm2, 1024(%rsp,%rax) # 1024-byte Folded Spill
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    callq foo
; CHECK-NEXT:    movl $buf+2048, %eax
; CHECK-NEXT:    ldtilecfg {{[-0-9]+}}(%r{{[sb]}}p) # 64-byte Folded Reload
; CHECK-NEXT:    tileloadd (%rax,%r14), %tmm0
; CHECK-NEXT:    movabsq $64, %rcx
; CHECK-NEXT:    tileloadd 2048(%rsp,%rcx), %tmm1 # 1024-byte Folded Reload
; CHECK-NEXT:    movabsq $64, %rcx
; CHECK-NEXT:    tileloadd 1024(%rsp,%rcx), %tmm2 # 1024-byte Folded Reload
; CHECK-NEXT:    tdpbssd %tmm2, %tmm1, %tmm0
; CHECK-NEXT:    tilestored %tmm0, (%rax,%r14)
; CHECK-NEXT:    addq $4056, %rsp # imm = 0xFD8
; CHECK-NEXT:    .cfi_def_cfa_offset 40
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    .cfi_def_cfa_offset 32
; CHECK-NEXT:    popq %r14
; CHECK-NEXT:    .cfi_def_cfa_offset 24
; CHECK-NEXT:    popq %r15
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    tilerelease
; CHECK-NEXT:    retq
  %3 = tail call <256 x i32> @llvm.x86.tileloadd64.internal(i16 %0, i16 8, i8* getelementptr inbounds ([3072 x i8], [3072 x i8]* @buf, i64 0, i64 0), i64 32) #4
  %4 = tail call <256 x i32> @llvm.x86.tileloadd64.internal(i16 8, i16 %1, i8* getelementptr inbounds ([3072 x i8], [3072 x i8]* @buf, i64 0, i64 1024), i64 32) #4
  tail call void (...) @foo() #4
  %5 = tail call <256 x i32> @llvm.x86.tileloadd64.internal(i16 %0, i16 %1, i8* getelementptr inbounds ([3072 x i8], [3072 x i8]* @buf, i64 0, i64 2048), i64 32) #4
  %6 = tail call <256 x i32> @llvm.x86.tdpbssd.internal(i16 %0, i16 %1, i16 8, <256 x i32> %5, <256 x i32> %3, <256 x i32> %4) #4
  tail call void @llvm.x86.tilestored64.internal(i16 %0, i16 %1, i8* getelementptr inbounds ([3072 x i8], [3072 x i8]* @buf, i64 0, i64 2048), i64 32, <256 x i32> %6) #4
  ret void
}

declare dso_local void @foo(...) local_unnamed_addr #3

declare <256 x i32> @llvm.x86.tileloadd64.internal(i16, i16, i8*, i64) #4
declare <256 x i32> @llvm.x86.tdpbssd.internal(i16, i16, i16, <256 x i32>, <256 x i32>, <256 x i32>) #4
declare void @llvm.x86.tilestored64.internal(i16, i16, i8*, i64, <256 x i32>) #4

attributes #2 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="8192" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+amx-int8,+amx-tile,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+amx-int8,+amx-tile,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
