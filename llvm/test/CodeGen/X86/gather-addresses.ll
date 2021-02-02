; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-linux -mattr=+sse2 < %s | FileCheck %s --check-prefix=LIN-SSE2
; RUN: llc -mtriple=x86_64-linux -mcpu=nehalem < %s | FileCheck %s --check-prefix=LIN-SSE4
; RUN: llc -mtriple=x86_64-win32 -mattr=+sse2 < %s | FileCheck %s --check-prefix=WIN-SSE2
; RUN: llc -mtriple=x86_64-win32 -mcpu=nehalem < %s | FileCheck %s --check-prefix=WIN-SSE4
; RUN: llc -mtriple=i686-win32 -mcpu=nehalem < %s | FileCheck %s --check-prefix=LIN32
; rdar://7398554

; When doing vector gather-scatter index calculation with 32-bit indices,
; minimize shuffling of each individual element out of the index vector.

define <4 x double> @foo(double* %p, <4 x i32>* %i, <4 x i32>* %h) nounwind {
; LIN-SSE2-LABEL: foo:
; LIN-SSE2:       # %bb.0:
; LIN-SSE2-NEXT:    movdqa (%rsi), %xmm0
; LIN-SSE2-NEXT:    pand (%rdx), %xmm0
; LIN-SSE2-NEXT:    movd %xmm0, %eax
; LIN-SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,1,1]
; LIN-SSE2-NEXT:    movd %xmm1, %ecx
; LIN-SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; LIN-SSE2-NEXT:    movd %xmm1, %edx
; LIN-SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,3,3,3]
; LIN-SSE2-NEXT:    movd %xmm0, %esi
; LIN-SSE2-NEXT:    cltq
; LIN-SSE2-NEXT:    movslq %ecx, %rcx
; LIN-SSE2-NEXT:    movslq %edx, %rdx
; LIN-SSE2-NEXT:    movslq %esi, %rsi
; LIN-SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; LIN-SSE2-NEXT:    movhps {{.*#+}} xmm0 = xmm0[0,1],mem[0,1]
; LIN-SSE2-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; LIN-SSE2-NEXT:    movhps {{.*#+}} xmm1 = xmm1[0,1],mem[0,1]
; LIN-SSE2-NEXT:    retq
;
; LIN-SSE4-LABEL: foo:
; LIN-SSE4:       # %bb.0:
; LIN-SSE4-NEXT:    movdqa (%rsi), %xmm0
; LIN-SSE4-NEXT:    pand (%rdx), %xmm0
; LIN-SSE4-NEXT:    movd %xmm0, %eax
; LIN-SSE4-NEXT:    pextrd $1, %xmm0, %ecx
; LIN-SSE4-NEXT:    pextrd $2, %xmm0, %edx
; LIN-SSE4-NEXT:    pextrd $3, %xmm0, %esi
; LIN-SSE4-NEXT:    cltq
; LIN-SSE4-NEXT:    movslq %ecx, %rcx
; LIN-SSE4-NEXT:    movslq %edx, %rdx
; LIN-SSE4-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; LIN-SSE4-NEXT:    movhps {{.*#+}} xmm0 = xmm0[0,1],mem[0,1]
; LIN-SSE4-NEXT:    movslq %esi, %rax
; LIN-SSE4-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; LIN-SSE4-NEXT:    movhps {{.*#+}} xmm1 = xmm1[0,1],mem[0,1]
; LIN-SSE4-NEXT:    retq
;
; WIN-SSE2-LABEL: foo:
; WIN-SSE2:       # %bb.0:
; WIN-SSE2-NEXT:    movdqa (%rdx), %xmm0
; WIN-SSE2-NEXT:    pand (%r8), %xmm0
; WIN-SSE2-NEXT:    movd %xmm0, %r8d
; WIN-SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,1,1]
; WIN-SSE2-NEXT:    movd %xmm1, %r9d
; WIN-SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; WIN-SSE2-NEXT:    movd %xmm1, %r10d
; WIN-SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,3,3,3]
; WIN-SSE2-NEXT:    movd %xmm0, %edx
; WIN-SSE2-NEXT:    movslq %r8d, %rax
; WIN-SSE2-NEXT:    movslq %r9d, %r8
; WIN-SSE2-NEXT:    movslq %r10d, %r9
; WIN-SSE2-NEXT:    movslq %edx, %rdx
; WIN-SSE2-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; WIN-SSE2-NEXT:    movhps {{.*#+}} xmm0 = xmm0[0,1],mem[0,1]
; WIN-SSE2-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; WIN-SSE2-NEXT:    movhps {{.*#+}} xmm1 = xmm1[0,1],mem[0,1]
; WIN-SSE2-NEXT:    retq
;
; WIN-SSE4-LABEL: foo:
; WIN-SSE4:       # %bb.0:
; WIN-SSE4-NEXT:    movdqa (%rdx), %xmm0
; WIN-SSE4-NEXT:    pand (%r8), %xmm0
; WIN-SSE4-NEXT:    movd %xmm0, %eax
; WIN-SSE4-NEXT:    pextrd $1, %xmm0, %edx
; WIN-SSE4-NEXT:    pextrd $2, %xmm0, %r8d
; WIN-SSE4-NEXT:    pextrd $3, %xmm0, %r9d
; WIN-SSE4-NEXT:    cltq
; WIN-SSE4-NEXT:    movslq %edx, %rdx
; WIN-SSE4-NEXT:    movslq %r8d, %r8
; WIN-SSE4-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; WIN-SSE4-NEXT:    movhps {{.*#+}} xmm0 = xmm0[0,1],mem[0,1]
; WIN-SSE4-NEXT:    movslq %r9d, %rax
; WIN-SSE4-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; WIN-SSE4-NEXT:    movhps {{.*#+}} xmm1 = xmm1[0,1],mem[0,1]
; WIN-SSE4-NEXT:    retq
;
; LIN32-LABEL: foo:
; LIN32:       # %bb.0:
; LIN32-NEXT:    pushl %edi
; LIN32-NEXT:    pushl %esi
; LIN32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; LIN32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; LIN32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; LIN32-NEXT:    movdqa (%edx), %xmm0
; LIN32-NEXT:    pand (%ecx), %xmm0
; LIN32-NEXT:    pextrd $1, %xmm0, %ecx
; LIN32-NEXT:    pextrd $2, %xmm0, %edx
; LIN32-NEXT:    pextrd $3, %xmm0, %esi
; LIN32-NEXT:    movd %xmm0, %edi
; LIN32-NEXT:    movsd {{.*#+}} xmm0 = mem[0],zero
; LIN32-NEXT:    movhps {{.*#+}} xmm0 = xmm0[0,1],mem[0,1]
; LIN32-NEXT:    movsd {{.*#+}} xmm1 = mem[0],zero
; LIN32-NEXT:    movhps {{.*#+}} xmm1 = xmm1[0,1],mem[0,1]
; LIN32-NEXT:    popl %esi
; LIN32-NEXT:    popl %edi
; LIN32-NEXT:    retl
  %a = load <4 x i32>, <4 x i32>* %i
  %b = load <4 x i32>, <4 x i32>* %h
  %j = and <4 x i32> %a, %b
  %d0 = extractelement <4 x i32> %j, i32 0
  %d1 = extractelement <4 x i32> %j, i32 1
  %d2 = extractelement <4 x i32> %j, i32 2
  %d3 = extractelement <4 x i32> %j, i32 3
  %q0 = getelementptr double, double* %p, i32 %d0
  %q1 = getelementptr double, double* %p, i32 %d1
  %q2 = getelementptr double, double* %p, i32 %d2
  %q3 = getelementptr double, double* %p, i32 %d3
  %r0 = load double, double* %q0
  %r1 = load double, double* %q1
  %r2 = load double, double* %q2
  %r3 = load double, double* %q3
  %v0 = insertelement <4 x double> undef, double %r0, i32 0
  %v1 = insertelement <4 x double> %v0, double %r1, i32 1
  %v2 = insertelement <4 x double> %v1, double %r2, i32 2
  %v3 = insertelement <4 x double> %v2, double %r3, i32 3
  ret <4 x double> %v3
}

; Check that the sequence previously used above, which bounces the vector off the
; cache works for x86-32. Note that in this case it will not be used for index
; calculation, since indexes are 32-bit, not 64.
define <4 x i64> @old(double* %p, <4 x i32>* %i, <4 x i32>* %h, i64 %f) nounwind {
; LIN-SSE2-LABEL: old:
; LIN-SSE2:       # %bb.0:
; LIN-SSE2-NEXT:    movdqa (%rsi), %xmm0
; LIN-SSE2-NEXT:    pand (%rdx), %xmm0
; LIN-SSE2-NEXT:    movd %xmm0, %eax
; LIN-SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,1,1]
; LIN-SSE2-NEXT:    movd %xmm1, %edx
; LIN-SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; LIN-SSE2-NEXT:    movd %xmm1, %esi
; LIN-SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,3,3,3]
; LIN-SSE2-NEXT:    movd %xmm0, %edi
; LIN-SSE2-NEXT:    andl %ecx, %eax
; LIN-SSE2-NEXT:    andl %ecx, %edx
; LIN-SSE2-NEXT:    andl %ecx, %esi
; LIN-SSE2-NEXT:    andl %ecx, %edi
; LIN-SSE2-NEXT:    movq %rax, %xmm0
; LIN-SSE2-NEXT:    movq %rdx, %xmm1
; LIN-SSE2-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; LIN-SSE2-NEXT:    movq %rdi, %xmm2
; LIN-SSE2-NEXT:    movq %rsi, %xmm1
; LIN-SSE2-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm2[0]
; LIN-SSE2-NEXT:    retq
;
; LIN-SSE4-LABEL: old:
; LIN-SSE4:       # %bb.0:
; LIN-SSE4-NEXT:    movdqa (%rsi), %xmm0
; LIN-SSE4-NEXT:    pand (%rdx), %xmm0
; LIN-SSE4-NEXT:    movd %xmm0, %eax
; LIN-SSE4-NEXT:    pextrd $1, %xmm0, %edx
; LIN-SSE4-NEXT:    pextrd $2, %xmm0, %esi
; LIN-SSE4-NEXT:    pextrd $3, %xmm0, %edi
; LIN-SSE4-NEXT:    andl %ecx, %eax
; LIN-SSE4-NEXT:    andl %ecx, %edx
; LIN-SSE4-NEXT:    andl %ecx, %esi
; LIN-SSE4-NEXT:    andl %ecx, %edi
; LIN-SSE4-NEXT:    movq %rdx, %xmm1
; LIN-SSE4-NEXT:    movq %rax, %xmm0
; LIN-SSE4-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; LIN-SSE4-NEXT:    movq %rdi, %xmm2
; LIN-SSE4-NEXT:    movq %rsi, %xmm1
; LIN-SSE4-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm2[0]
; LIN-SSE4-NEXT:    retq
;
; WIN-SSE2-LABEL: old:
; WIN-SSE2:       # %bb.0:
; WIN-SSE2-NEXT:    movdqa (%rdx), %xmm0
; WIN-SSE2-NEXT:    pand (%r8), %xmm0
; WIN-SSE2-NEXT:    movd %xmm0, %eax
; WIN-SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[1,1,1,1]
; WIN-SSE2-NEXT:    movd %xmm1, %ecx
; WIN-SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,2,3]
; WIN-SSE2-NEXT:    movd %xmm1, %r8d
; WIN-SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[3,3,3,3]
; WIN-SSE2-NEXT:    movd %xmm0, %edx
; WIN-SSE2-NEXT:    andl %r9d, %eax
; WIN-SSE2-NEXT:    andl %r9d, %ecx
; WIN-SSE2-NEXT:    andl %r9d, %r8d
; WIN-SSE2-NEXT:    andl %r9d, %edx
; WIN-SSE2-NEXT:    movq %rax, %xmm0
; WIN-SSE2-NEXT:    movq %rcx, %xmm1
; WIN-SSE2-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; WIN-SSE2-NEXT:    movq %rdx, %xmm2
; WIN-SSE2-NEXT:    movq %r8, %xmm1
; WIN-SSE2-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm2[0]
; WIN-SSE2-NEXT:    retq
;
; WIN-SSE4-LABEL: old:
; WIN-SSE4:       # %bb.0:
; WIN-SSE4-NEXT:    movdqa (%rdx), %xmm0
; WIN-SSE4-NEXT:    pand (%r8), %xmm0
; WIN-SSE4-NEXT:    movd %xmm0, %eax
; WIN-SSE4-NEXT:    pextrd $1, %xmm0, %ecx
; WIN-SSE4-NEXT:    pextrd $2, %xmm0, %r8d
; WIN-SSE4-NEXT:    pextrd $3, %xmm0, %edx
; WIN-SSE4-NEXT:    andl %r9d, %eax
; WIN-SSE4-NEXT:    andl %r9d, %ecx
; WIN-SSE4-NEXT:    andl %r9d, %r8d
; WIN-SSE4-NEXT:    andl %r9d, %edx
; WIN-SSE4-NEXT:    movq %rcx, %xmm1
; WIN-SSE4-NEXT:    movq %rax, %xmm0
; WIN-SSE4-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; WIN-SSE4-NEXT:    movq %rdx, %xmm2
; WIN-SSE4-NEXT:    movq %r8, %xmm1
; WIN-SSE4-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm2[0]
; WIN-SSE4-NEXT:    retq
;
; LIN32-LABEL: old:
; LIN32:       # %bb.0:
; LIN32-NEXT:    pushl %edi
; LIN32-NEXT:    pushl %esi
; LIN32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; LIN32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; LIN32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; LIN32-NEXT:    movdqa (%edx), %xmm0
; LIN32-NEXT:    pand (%ecx), %xmm0
; LIN32-NEXT:    movd %xmm0, %ecx
; LIN32-NEXT:    pextrd $1, %xmm0, %edx
; LIN32-NEXT:    pextrd $2, %xmm0, %esi
; LIN32-NEXT:    pextrd $3, %xmm0, %edi
; LIN32-NEXT:    andl %eax, %ecx
; LIN32-NEXT:    andl %eax, %edx
; LIN32-NEXT:    andl %eax, %esi
; LIN32-NEXT:    andl %eax, %edi
; LIN32-NEXT:    movd %edx, %xmm1
; LIN32-NEXT:    movd %ecx, %xmm0
; LIN32-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; LIN32-NEXT:    movd %edi, %xmm2
; LIN32-NEXT:    movd %esi, %xmm1
; LIN32-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm2[0]
; LIN32-NEXT:    popl %esi
; LIN32-NEXT:    popl %edi
; LIN32-NEXT:    retl
  %a = load <4 x i32>, <4 x i32>* %i
  %b = load <4 x i32>, <4 x i32>* %h
  %j = and <4 x i32> %a, %b
  %d0 = extractelement <4 x i32> %j, i32 0
  %d1 = extractelement <4 x i32> %j, i32 1
  %d2 = extractelement <4 x i32> %j, i32 2
  %d3 = extractelement <4 x i32> %j, i32 3
  %q0 = zext i32 %d0 to i64
  %q1 = zext i32 %d1 to i64
  %q2 = zext i32 %d2 to i64
  %q3 = zext i32 %d3 to i64
  %r0 = and i64 %q0, %f
  %r1 = and i64 %q1, %f
  %r2 = and i64 %q2, %f
  %r3 = and i64 %q3, %f
  %v0 = insertelement <4 x i64> undef, i64 %r0, i32 0
  %v1 = insertelement <4 x i64> %v0, i64 %r1, i32 1
  %v2 = insertelement <4 x i64> %v1, i64 %r2, i32 2
  %v3 = insertelement <4 x i64> %v2, i64 %r3, i32 3
  ret <4 x i64> %v3
}
