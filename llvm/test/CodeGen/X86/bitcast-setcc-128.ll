; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse2 | FileCheck %s --check-prefixes=SSE2-SSSE3,SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+ssse3 | FileCheck %s --check-prefixes=SSE2-SSSE3,SSSE3
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefixes=AVX12,AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=AVX12,AVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512vl | FileCheck %s --check-prefix=AVX512F
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f,+avx512vl,+avx512bw | FileCheck %s --check-prefix=AVX512BW

define i8 @v8i16(<8 x i16> %a, <8 x i16> %b) {
; SSE2-SSSE3-LABEL: v8i16:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    pcmpgtw %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    packsswb %xmm0, %xmm0
; SSE2-SSSE3-NEXT:    pmovmskb %xmm0, %eax
; SSE2-SSSE3-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: v8i16:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vpcmpgtw %xmm1, %xmm0, %xmm0
; AVX12-NEXT:    vpacksswb %xmm0, %xmm0, %xmm0
; AVX12-NEXT:    vpmovmskb %xmm0, %eax
; AVX12-NEXT:    # kill: def $al killed $al killed $eax
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: v8i16:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpcmpgtw %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vpmovsxwd %xmm0, %ymm0
; AVX512F-NEXT:    vptestmd %ymm0, %ymm0, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    # kill: def $al killed $al killed $eax
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: v8i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpcmpgtw %xmm1, %xmm0, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    # kill: def $al killed $al killed $eax
; AVX512BW-NEXT:    retq
  %x = icmp sgt <8 x i16> %a, %b
  %res = bitcast <8 x i1> %x to i8
  ret i8 %res
}

define i4 @v4i32(<4 x i32> %a, <4 x i32> %b) {
; SSE2-SSSE3-LABEL: v4i32:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    pcmpgtd %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    movmskps %xmm0, %eax
; SSE2-SSSE3-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: v4i32:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vpcmpgtd %xmm1, %xmm0, %xmm0
; AVX12-NEXT:    vmovmskps %xmm0, %eax
; AVX12-NEXT:    # kill: def $al killed $al killed $eax
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: v4i32:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpcmpgtd %xmm1, %xmm0, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    # kill: def $al killed $al killed $eax
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: v4i32:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpcmpgtd %xmm1, %xmm0, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    # kill: def $al killed $al killed $eax
; AVX512BW-NEXT:    retq
  %x = icmp sgt <4 x i32> %a, %b
  %res = bitcast <4 x i1> %x to i4
  ret i4 %res
}

define i4 @v4f32(<4 x float> %a, <4 x float> %b) {
; SSE2-SSSE3-LABEL: v4f32:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    cmpltps %xmm0, %xmm1
; SSE2-SSSE3-NEXT:    movmskps %xmm1, %eax
; SSE2-SSSE3-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: v4f32:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vcmpltps %xmm0, %xmm1, %xmm0
; AVX12-NEXT:    vmovmskps %xmm0, %eax
; AVX12-NEXT:    # kill: def $al killed $al killed $eax
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: v4f32:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vcmpltps %xmm0, %xmm1, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    # kill: def $al killed $al killed $eax
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: v4f32:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vcmpltps %xmm0, %xmm1, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    # kill: def $al killed $al killed $eax
; AVX512BW-NEXT:    retq
  %x = fcmp ogt <4 x float> %a, %b
  %res = bitcast <4 x i1> %x to i4
  ret i4 %res
}

define i16 @v16i8(<16 x i8> %a, <16 x i8> %b) {
; SSE2-SSSE3-LABEL: v16i8:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    pcmpgtb %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pmovmskb %xmm0, %eax
; SSE2-SSSE3-NEXT:    # kill: def $ax killed $ax killed $eax
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: v16i8:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vpcmpgtb %xmm1, %xmm0, %xmm0
; AVX12-NEXT:    vpmovmskb %xmm0, %eax
; AVX12-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: v16i8:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpcmpgtb %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vpmovmskb %xmm0, %eax
; AVX512F-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: v16i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpcmpgtb %xmm1, %xmm0, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    # kill: def $ax killed $ax killed $eax
; AVX512BW-NEXT:    retq
  %x = icmp sgt <16 x i8> %a, %b
  %res = bitcast <16 x i1> %x to i16
  ret i16 %res
}

define i2 @v2i8(<2 x i8> %a, <2 x i8> %b) {
; SSE2-LABEL: v2i8:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pcmpgtb %xmm1, %xmm0
; SSE2-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; SSE2-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,0,2,1,4,5,6,7]
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,1,1]
; SSE2-NEXT:    movmskpd %xmm0, %eax
; SSE2-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-NEXT:    retq
;
; SSSE3-LABEL: v2i8:
; SSSE3:       # %bb.0:
; SSSE3-NEXT:    pcmpgtb %xmm1, %xmm0
; SSSE3-NEXT:    pshufb {{.*#+}} xmm0 = xmm0[u,u,u,u,u,u,u,0,u,u,u,u,u,u,u,1]
; SSSE3-NEXT:    movmskpd %xmm0, %eax
; SSSE3-NEXT:    # kill: def $al killed $al killed $eax
; SSSE3-NEXT:    retq
;
; AVX12-LABEL: v2i8:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vpcmpgtb %xmm1, %xmm0, %xmm0
; AVX12-NEXT:    vpmovsxbq %xmm0, %xmm0
; AVX12-NEXT:    vmovmskpd %xmm0, %eax
; AVX12-NEXT:    # kill: def $al killed $al killed $eax
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: v2i8:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpcmpgtb %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vpmovsxbd %xmm0, %zmm0
; AVX512F-NEXT:    vptestmd %zmm0, %zmm0, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    # kill: def $al killed $al killed $eax
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: v2i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpcmpgtb %xmm1, %xmm0, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    # kill: def $al killed $al killed $eax
; AVX512BW-NEXT:    retq
  %x = icmp sgt <2 x i8> %a, %b
  %res = bitcast <2 x i1> %x to i2
  ret i2 %res
}

define i2 @v2i16(<2 x i16> %a, <2 x i16> %b) {
; SSE2-SSSE3-LABEL: v2i16:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    pcmpgtw %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pshuflw {{.*#+}} xmm0 = xmm0[0,0,2,1,4,5,6,7]
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,1,1]
; SSE2-SSSE3-NEXT:    movmskpd %xmm0, %eax
; SSE2-SSSE3-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: v2i16:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vpcmpgtw %xmm1, %xmm0, %xmm0
; AVX12-NEXT:    vpmovsxwq %xmm0, %xmm0
; AVX12-NEXT:    vmovmskpd %xmm0, %eax
; AVX12-NEXT:    # kill: def $al killed $al killed $eax
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: v2i16:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpcmpgtw %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vpmovsxwd %xmm0, %ymm0
; AVX512F-NEXT:    vptestmd %ymm0, %ymm0, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    # kill: def $al killed $al killed $eax
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: v2i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpcmpgtw %xmm1, %xmm0, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    # kill: def $al killed $al killed $eax
; AVX512BW-NEXT:    retq
  %x = icmp sgt <2 x i16> %a, %b
  %res = bitcast <2 x i1> %x to i2
  ret i2 %res
}

define i2 @v2i32(<2 x i32> %a, <2 x i32> %b) {
; SSE2-SSSE3-LABEL: v2i32:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    pcmpgtd %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,0,1,1]
; SSE2-SSSE3-NEXT:    movmskpd %xmm0, %eax
; SSE2-SSSE3-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: v2i32:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vpcmpgtd %xmm1, %xmm0, %xmm0
; AVX12-NEXT:    vpmovsxdq %xmm0, %xmm0
; AVX12-NEXT:    vmovmskpd %xmm0, %eax
; AVX12-NEXT:    # kill: def $al killed $al killed $eax
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: v2i32:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpcmpgtd %xmm1, %xmm0, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    # kill: def $al killed $al killed $eax
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: v2i32:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpcmpgtd %xmm1, %xmm0, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    # kill: def $al killed $al killed $eax
; AVX512BW-NEXT:    retq
  %x = icmp sgt <2 x i32> %a, %b
  %res = bitcast <2 x i1> %x to i2
  ret i2 %res
}

define i2 @v2i64(<2 x i64> %a, <2 x i64> %b) {
; SSE2-SSSE3-LABEL: v2i64:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    movdqa {{.*#+}} xmm2 = [2147483648,2147483648]
; SSE2-SSSE3-NEXT:    pxor %xmm2, %xmm1
; SSE2-SSSE3-NEXT:    pxor %xmm2, %xmm0
; SSE2-SSSE3-NEXT:    movdqa %xmm0, %xmm2
; SSE2-SSSE3-NEXT:    pcmpeqd %xmm1, %xmm2
; SSE2-SSSE3-NEXT:    pcmpgtd %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[0,0,2,2]
; SSE2-SSSE3-NEXT:    pand %xmm2, %xmm1
; SSE2-SSSE3-NEXT:    por %xmm0, %xmm1
; SSE2-SSSE3-NEXT:    movmskpd %xmm1, %eax
; SSE2-SSSE3-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: v2i64:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vpcmpgtq %xmm1, %xmm0, %xmm0
; AVX12-NEXT:    vmovmskpd %xmm0, %eax
; AVX12-NEXT:    # kill: def $al killed $al killed $eax
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: v2i64:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpcmpgtq %xmm1, %xmm0, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    # kill: def $al killed $al killed $eax
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: v2i64:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpcmpgtq %xmm1, %xmm0, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    # kill: def $al killed $al killed $eax
; AVX512BW-NEXT:    retq
  %x = icmp sgt <2 x i64> %a, %b
  %res = bitcast <2 x i1> %x to i2
  ret i2 %res
}

define i2 @v2f64(<2 x double> %a, <2 x double> %b) {
; SSE2-SSSE3-LABEL: v2f64:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    cmpltpd %xmm0, %xmm1
; SSE2-SSSE3-NEXT:    movmskpd %xmm1, %eax
; SSE2-SSSE3-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: v2f64:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vcmpltpd %xmm0, %xmm1, %xmm0
; AVX12-NEXT:    vmovmskpd %xmm0, %eax
; AVX12-NEXT:    # kill: def $al killed $al killed $eax
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: v2f64:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vcmpltpd %xmm0, %xmm1, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    # kill: def $al killed $al killed $eax
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: v2f64:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vcmpltpd %xmm0, %xmm1, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    # kill: def $al killed $al killed $eax
; AVX512BW-NEXT:    retq
  %x = fcmp ogt <2 x double> %a, %b
  %res = bitcast <2 x i1> %x to i2
  ret i2 %res
}

define i4 @v4i8(<4 x i8> %a, <4 x i8> %b) {
; SSE2-SSSE3-LABEL: v4i8:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    pcmpgtb %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; SSE2-SSSE3-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3]
; SSE2-SSSE3-NEXT:    movmskps %xmm0, %eax
; SSE2-SSSE3-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: v4i8:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vpcmpgtb %xmm1, %xmm0, %xmm0
; AVX12-NEXT:    vpmovsxbd %xmm0, %xmm0
; AVX12-NEXT:    vmovmskps %xmm0, %eax
; AVX12-NEXT:    # kill: def $al killed $al killed $eax
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: v4i8:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpcmpgtb %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vpmovsxbd %xmm0, %zmm0
; AVX512F-NEXT:    vptestmd %zmm0, %zmm0, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    # kill: def $al killed $al killed $eax
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: v4i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpcmpgtb %xmm1, %xmm0, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    # kill: def $al killed $al killed $eax
; AVX512BW-NEXT:    retq
  %x = icmp sgt <4 x i8> %a, %b
  %res = bitcast <4 x i1> %x to i4
  ret i4 %res
}

define i4 @v4i16(<4 x i16> %a, <4 x i16> %b) {
; SSE2-SSSE3-LABEL: v4i16:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    pcmpgtw %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3]
; SSE2-SSSE3-NEXT:    movmskps %xmm0, %eax
; SSE2-SSSE3-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: v4i16:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vpcmpgtw %xmm1, %xmm0, %xmm0
; AVX12-NEXT:    vpmovsxwd %xmm0, %xmm0
; AVX12-NEXT:    vmovmskps %xmm0, %eax
; AVX12-NEXT:    # kill: def $al killed $al killed $eax
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: v4i16:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpcmpgtw %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vpmovsxwd %xmm0, %ymm0
; AVX512F-NEXT:    vptestmd %ymm0, %ymm0, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    # kill: def $al killed $al killed $eax
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: v4i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpcmpgtw %xmm1, %xmm0, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    # kill: def $al killed $al killed $eax
; AVX512BW-NEXT:    retq
  %x = icmp sgt <4 x i16> %a, %b
  %res = bitcast <4 x i1> %x to i4
  ret i4 %res
}

define i8 @v8i8(<8 x i8> %a, <8 x i8> %b) {
; SSE2-SSSE3-LABEL: v8i8:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    pcmpgtb %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pmovmskb %xmm0, %eax
; SSE2-SSSE3-NEXT:    # kill: def $al killed $al killed $eax
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: v8i8:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vpcmpgtb %xmm1, %xmm0, %xmm0
; AVX12-NEXT:    vpmovmskb %xmm0, %eax
; AVX12-NEXT:    # kill: def $al killed $al killed $eax
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: v8i8:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpcmpgtb %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vpmovsxbd %xmm0, %zmm0
; AVX512F-NEXT:    vptestmd %zmm0, %zmm0, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    # kill: def $al killed $al killed $eax
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: v8i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpcmpgtb %xmm1, %xmm0, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    # kill: def $al killed $al killed $eax
; AVX512BW-NEXT:    retq
  %x = icmp sgt <8 x i8> %a, %b
  %res = bitcast <8 x i1> %x to i8
  ret i8 %res
}

define i64 @v16i8_widened_with_zeroes(<16 x i8> %a, <16 x i8> %b) {
; SSE2-SSSE3-LABEL: v16i8_widened_with_zeroes:
; SSE2-SSSE3:       # %bb.0: # %entry
; SSE2-SSSE3-NEXT:    pcmpeqb %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pmovmskb %xmm0, %eax
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: v16i8_widened_with_zeroes:
; AVX1:       # %bb.0: # %entry
; AVX1-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpmovmskb %xmm0, %eax
; AVX1-NEXT:    retq
;
; AVX2-LABEL: v16i8_widened_with_zeroes:
; AVX2:       # %bb.0: # %entry
; AVX2-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpmovmskb %ymm0, %eax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: v16i8_widened_with_zeroes:
; AVX512F:       # %bb.0: # %entry
; AVX512F-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vpmovsxbd %xmm0, %zmm0
; AVX512F-NEXT:    vptestmd %zmm0, %zmm0, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: v16i8_widened_with_zeroes:
; AVX512BW:       # %bb.0: # %entry
; AVX512BW-NEXT:    vpcmpeqb %xmm1, %xmm0, %k0
; AVX512BW-NEXT:    kmovq %k0, %rax
; AVX512BW-NEXT:    retq
entry:
  %c = icmp eq <16 x i8> %a, %b
  %d = shufflevector <16 x i1> %c, <16 x i1> zeroinitializer, <64 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %e = bitcast <64 x i1> %d to i64
  ret i64 %e
}

define i64 @v16i8_widened_with_ones(<16 x i8> %a, <16 x i8> %b) {
; SSE2-SSSE3-LABEL: v16i8_widened_with_ones:
; SSE2-SSSE3:       # %bb.0: # %entry
; SSE2-SSSE3-NEXT:    pcmpeqb %xmm1, %xmm0
; SSE2-SSSE3-NEXT:    pmovmskb %xmm0, %ecx
; SSE2-SSSE3-NEXT:    orl $-65536, %ecx # imm = 0xFFFF0000
; SSE2-SSSE3-NEXT:    movabsq $-4294967296, %rax # imm = 0xFFFFFFFF00000000
; SSE2-SSSE3-NEXT:    orq %rcx, %rax
; SSE2-SSSE3-NEXT:    retq
;
; AVX1-LABEL: v16i8_widened_with_ones:
; AVX1:       # %bb.0: # %entry
; AVX1-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpmovmskb %xmm0, %ecx
; AVX1-NEXT:    orl $-65536, %ecx # imm = 0xFFFF0000
; AVX1-NEXT:    movabsq $-4294967296, %rax # imm = 0xFFFFFFFF00000000
; AVX1-NEXT:    orq %rcx, %rax
; AVX1-NEXT:    retq
;
; AVX2-LABEL: v16i8_widened_with_ones:
; AVX2:       # %bb.0: # %entry
; AVX2-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vinserti128 $1, {{.*}}(%rip), %ymm0, %ymm0
; AVX2-NEXT:    vpsllw $7, %ymm0, %ymm0
; AVX2-NEXT:    vpmovmskb %ymm0, %ecx
; AVX2-NEXT:    movabsq $-4294967296, %rax # imm = 0xFFFFFFFF00000000
; AVX2-NEXT:    orq %rcx, %rax
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: v16i8_widened_with_ones:
; AVX512F:       # %bb.0: # %entry
; AVX512F-NEXT:    vpcmpeqb %xmm1, %xmm0, %xmm0
; AVX512F-NEXT:    vpmovsxbd %xmm0, %zmm0
; AVX512F-NEXT:    vptestmd %zmm0, %zmm0, %k0
; AVX512F-NEXT:    kmovw %k0, %ecx
; AVX512F-NEXT:    orl $-65536, %ecx # imm = 0xFFFF0000
; AVX512F-NEXT:    movabsq $-4294967296, %rax # imm = 0xFFFFFFFF00000000
; AVX512F-NEXT:    orq %rcx, %rax
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: v16i8_widened_with_ones:
; AVX512BW:       # %bb.0: # %entry
; AVX512BW-NEXT:    vpcmpeqb %xmm1, %xmm0, %k0
; AVX512BW-NEXT:    kxnorw %k0, %k0, %k1
; AVX512BW-NEXT:    kunpckwd %k0, %k1, %k0
; AVX512BW-NEXT:    kxnord %k0, %k0, %k1
; AVX512BW-NEXT:    kunpckdq %k0, %k1, %k0
; AVX512BW-NEXT:    kmovq %k0, %rax
; AVX512BW-NEXT:    retq
entry:
  %c = icmp eq <16 x i8> %a, %b
  %d = shufflevector <16 x i1> %c, <16 x i1> <i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1, i1 -1>, <64 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %e = bitcast <64 x i1> %d to i64
  ret i64 %e
}

define void @bitcast_16i8_store(i16* %p, <16 x i8> %a0) {
; SSE2-SSSE3-LABEL: bitcast_16i8_store:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    pmovmskb %xmm0, %eax
; SSE2-SSSE3-NEXT:    movw %ax, (%rdi)
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: bitcast_16i8_store:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vpmovmskb %xmm0, %eax
; AVX12-NEXT:    movw %ax, (%rdi)
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: bitcast_16i8_store:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512F-NEXT:    vpcmpgtb %xmm0, %xmm1, %xmm0
; AVX512F-NEXT:    vpmovsxbd %xmm0, %zmm0
; AVX512F-NEXT:    vptestmd %zmm0, %zmm0, %k0
; AVX512F-NEXT:    kmovw %k0, (%rdi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: bitcast_16i8_store:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpmovb2m %xmm0, %k0
; AVX512BW-NEXT:    kmovw %k0, (%rdi)
; AVX512BW-NEXT:    retq
  %a1 = icmp slt <16 x i8> %a0, zeroinitializer
  %a2 = bitcast <16 x i1> %a1 to i16
  store i16 %a2, i16* %p
  ret void
}

define void @bitcast_8i16_store(i8* %p, <8 x i16> %a0) {
; SSE2-SSSE3-LABEL: bitcast_8i16_store:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    packsswb %xmm0, %xmm0
; SSE2-SSSE3-NEXT:    pmovmskb %xmm0, %eax
; SSE2-SSSE3-NEXT:    movb %al, (%rdi)
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: bitcast_8i16_store:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vpacksswb %xmm0, %xmm0, %xmm0
; AVX12-NEXT:    vpmovmskb %xmm0, %eax
; AVX12-NEXT:    movb %al, (%rdi)
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: bitcast_8i16_store:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512F-NEXT:    vpcmpgtw %xmm0, %xmm1, %xmm0
; AVX512F-NEXT:    vpmovsxwd %xmm0, %ymm0
; AVX512F-NEXT:    vptestmd %ymm0, %ymm0, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    movb %al, (%rdi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: bitcast_8i16_store:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpmovw2m %xmm0, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    movb %al, (%rdi)
; AVX512BW-NEXT:    retq
  %a1 = icmp slt <8 x i16> %a0, zeroinitializer
  %a2 = bitcast <8 x i1> %a1 to i8
  store i8 %a2, i8* %p
  ret void
}

define void @bitcast_4i32_store(i4* %p, <4 x i32> %a0) {
; SSE2-SSSE3-LABEL: bitcast_4i32_store:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    movmskps %xmm0, %eax
; SSE2-SSSE3-NEXT:    movb %al, (%rdi)
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: bitcast_4i32_store:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vmovmskps %xmm0, %eax
; AVX12-NEXT:    movb %al, (%rdi)
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: bitcast_4i32_store:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512F-NEXT:    vpcmpgtd %xmm0, %xmm1, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    movb %al, (%rdi)
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: bitcast_4i32_store:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512BW-NEXT:    vpcmpgtd %xmm0, %xmm1, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    movb %al, (%rdi)
; AVX512BW-NEXT:    retq
  %a1 = icmp slt <4 x i32> %a0, zeroinitializer
  %a2 = bitcast <4 x i1> %a1 to i4
  store i4 %a2, i4* %p
  ret void
}

define void @bitcast_2i64_store(i2* %p, <2 x i64> %a0) {
; SSE2-SSSE3-LABEL: bitcast_2i64_store:
; SSE2-SSSE3:       # %bb.0:
; SSE2-SSSE3-NEXT:    movmskpd %xmm0, %eax
; SSE2-SSSE3-NEXT:    movb %al, (%rdi)
; SSE2-SSSE3-NEXT:    retq
;
; AVX12-LABEL: bitcast_2i64_store:
; AVX12:       # %bb.0:
; AVX12-NEXT:    vmovmskpd %xmm0, %eax
; AVX12-NEXT:    movb %al, (%rdi)
; AVX12-NEXT:    retq
;
; AVX512F-LABEL: bitcast_2i64_store:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512F-NEXT:    vpcmpgtq %xmm0, %xmm1, %k0
; AVX512F-NEXT:    kmovw %k0, %eax
; AVX512F-NEXT:    movb %al, (%rdi)
; AVX512F-NEXT:    retq
;
; AVX512BW-LABEL: bitcast_2i64_store:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512BW-NEXT:    vpcmpgtq %xmm0, %xmm1, %k0
; AVX512BW-NEXT:    kmovd %k0, %eax
; AVX512BW-NEXT:    movb %al, (%rdi)
; AVX512BW-NEXT:    retq
  %a1 = icmp slt <2 x i64> %a0, zeroinitializer
  %a2 = bitcast <2 x i1> %a1 to i2
  store i2 %a2, i2* %p
  ret void
}
