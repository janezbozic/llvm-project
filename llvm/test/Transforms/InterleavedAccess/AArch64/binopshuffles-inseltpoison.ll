; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -interleaved-access -S | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

define <4 x float> @vld2(<8 x float>* %pSrc) {
; CHECK-LABEL: @vld2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <8 x float>* [[PSRC:%.*]] to <4 x float>*
; CHECK-NEXT:    [[LDN:%.*]] = call { <4 x float>, <4 x float> } @llvm.aarch64.neon.ld2.v4f32.p0v4f32(<4 x float>* [[TMP0]])
; CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <4 x float>, <4 x float> } [[LDN]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x float>, <4 x float> } [[LDN]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x float>, <4 x float> } [[LDN]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x float>, <4 x float> } [[LDN]], 0
; CHECK-NEXT:    [[L26:%.*]] = fmul <4 x float> [[TMP3]], [[TMP4]]
; CHECK-NEXT:    [[L43:%.*]] = fmul <4 x float> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[L6:%.*]] = fadd fast <4 x float> [[L43]], [[L26]]
; CHECK-NEXT:    ret <4 x float> [[L6]]
;
entry:
  %wide.vec = load <8 x float>, <8 x float>* %pSrc, align 4
  %l2 = fmul fast <8 x float> %wide.vec, %wide.vec
  %l3 = shufflevector <8 x float> %l2, <8 x float> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %l4 = fmul fast <8 x float> %wide.vec, %wide.vec
  %l5 = shufflevector <8 x float> %l4, <8 x float> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %l6 = fadd fast <4 x float> %l5, %l3
  ret <4 x float> %l6
}

define <4 x float> @vld3(<12 x float>* %pSrc) {
; CHECK-LABEL: @vld3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <12 x float>* [[PSRC:%.*]] to <4 x float>*
; CHECK-NEXT:    [[LDN:%.*]] = call { <4 x float>, <4 x float>, <4 x float> } @llvm.aarch64.neon.ld3.v4f32.p0v4f32(<4 x float>* [[TMP0]])
; CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <4 x float>, <4 x float>, <4 x float> } [[LDN]], 2
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x float>, <4 x float>, <4 x float> } [[LDN]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x float>, <4 x float>, <4 x float> } [[LDN]], 1
; CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x float>, <4 x float>, <4 x float> } [[LDN]], 1
; CHECK-NEXT:    [[TMP5:%.*]] = extractvalue { <4 x float>, <4 x float>, <4 x float> } [[LDN]], 0
; CHECK-NEXT:    [[TMP6:%.*]] = extractvalue { <4 x float>, <4 x float>, <4 x float> } [[LDN]], 0
; CHECK-NEXT:    [[L29:%.*]] = fmul <4 x float> [[TMP5]], [[TMP6]]
; CHECK-NEXT:    [[L46:%.*]] = fmul <4 x float> [[TMP3]], [[TMP4]]
; CHECK-NEXT:    [[L6:%.*]] = fadd fast <4 x float> [[L46]], [[L29]]
; CHECK-NEXT:    [[L73:%.*]] = fmul <4 x float> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[L9:%.*]] = fadd fast <4 x float> [[L6]], [[L73]]
; CHECK-NEXT:    ret <4 x float> [[L9]]
;
entry:
  %wide.vec = load <12 x float>, <12 x float>* %pSrc, align 4
  %l2 = fmul fast <12 x float> %wide.vec, %wide.vec
  %l3 = shufflevector <12 x float> %l2, <12 x float> poison, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
  %l4 = fmul fast <12 x float> %wide.vec, %wide.vec
  %l5 = shufflevector <12 x float> %l4, <12 x float> poison, <4 x i32> <i32 1, i32 4, i32 7, i32 10>
  %l6 = fadd fast <4 x float> %l5, %l3
  %l7 = fmul fast <12 x float> %wide.vec, %wide.vec
  %l8 = shufflevector <12 x float> %l7, <12 x float> poison, <4 x i32> <i32 2, i32 5, i32 8, i32 11>
  %l9 = fadd fast <4 x float> %l6, %l8
  ret <4 x float> %l9
}

define <4 x float> @vld4(<16 x float>* %pSrc) {
; CHECK-LABEL: @vld4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <16 x float>* [[PSRC:%.*]] to <4 x float>*
; CHECK-NEXT:    [[LDN:%.*]] = call { <4 x float>, <4 x float>, <4 x float>, <4 x float> } @llvm.aarch64.neon.ld4.v4f32.p0v4f32(<4 x float>* [[TMP0]])
; CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <4 x float>, <4 x float>, <4 x float>, <4 x float> } [[LDN]], 3
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x float>, <4 x float>, <4 x float>, <4 x float> } [[LDN]], 3
; CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x float>, <4 x float>, <4 x float>, <4 x float> } [[LDN]], 2
; CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x float>, <4 x float>, <4 x float>, <4 x float> } [[LDN]], 2
; CHECK-NEXT:    [[TMP5:%.*]] = extractvalue { <4 x float>, <4 x float>, <4 x float>, <4 x float> } [[LDN]], 1
; CHECK-NEXT:    [[TMP6:%.*]] = extractvalue { <4 x float>, <4 x float>, <4 x float>, <4 x float> } [[LDN]], 1
; CHECK-NEXT:    [[TMP7:%.*]] = extractvalue { <4 x float>, <4 x float>, <4 x float>, <4 x float> } [[LDN]], 0
; CHECK-NEXT:    [[TMP8:%.*]] = extractvalue { <4 x float>, <4 x float>, <4 x float>, <4 x float> } [[LDN]], 0
; CHECK-NEXT:    [[L312:%.*]] = fmul <4 x float> [[TMP7]], [[TMP8]]
; CHECK-NEXT:    [[L59:%.*]] = fmul <4 x float> [[TMP5]], [[TMP6]]
; CHECK-NEXT:    [[L7:%.*]] = fadd fast <4 x float> [[L59]], [[L312]]
; CHECK-NEXT:    [[L86:%.*]] = fmul <4 x float> [[TMP3]], [[TMP4]]
; CHECK-NEXT:    [[L103:%.*]] = fmul <4 x float> [[TMP1]], [[TMP2]]
; CHECK-NEXT:    [[L12:%.*]] = fadd fast <4 x float> [[L103]], [[L86]]
; CHECK-NEXT:    ret <4 x float> [[L12]]
;
entry:
  %wide.vec = load <16 x float>, <16 x float>* %pSrc, align 4
  %l3 = fmul fast <16 x float> %wide.vec, %wide.vec
  %l4 = shufflevector <16 x float> %l3, <16 x float> poison, <4 x i32> <i32 0, i32 4, i32 8, i32 12>
  %l5 = fmul fast <16 x float> %wide.vec, %wide.vec
  %l6 = shufflevector <16 x float> %l5, <16 x float> poison, <4 x i32> <i32 1, i32 5, i32 9, i32 13>
  %l7 = fadd fast <4 x float> %l6, %l4
  %l8 = fmul fast <16 x float> %wide.vec, %wide.vec
  %l9 = shufflevector <16 x float> %l8, <16 x float> poison, <4 x i32> <i32 2, i32 6, i32 10, i32 14>
  %l10 = fmul fast <16 x float> %wide.vec, %wide.vec
  %l11 = shufflevector <16 x float> %l10, <16 x float> poison, <4 x i32> <i32 3, i32 7, i32 11, i32 15>
  %l12 = fadd fast <4 x float> %l11, %l9
  ret <4 x float> %l12
}

define <4 x float> @twosrc(<8 x float>* %pSrc1, <8 x float>* %pSrc2) {
; CHECK-LABEL: @twosrc(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <8 x float>* [[PSRC1:%.*]] to <4 x float>*
; CHECK-NEXT:    [[LDN:%.*]] = call { <4 x float>, <4 x float> } @llvm.aarch64.neon.ld2.v4f32.p0v4f32(<4 x float>* [[TMP0]])
; CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <4 x float>, <4 x float> } [[LDN]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x float>, <4 x float> } [[LDN]], 0
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <8 x float>* [[PSRC2:%.*]] to <4 x float>*
; CHECK-NEXT:    [[LDN7:%.*]] = call { <4 x float>, <4 x float> } @llvm.aarch64.neon.ld2.v4f32.p0v4f32(<4 x float>* [[TMP3]])
; CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x float>, <4 x float> } [[LDN7]], 0
; CHECK-NEXT:    [[TMP5:%.*]] = extractvalue { <4 x float>, <4 x float> } [[LDN7]], 1
; CHECK-NEXT:    [[L46:%.*]] = fmul <4 x float> [[TMP4]], [[TMP2]]
; CHECK-NEXT:    [[L63:%.*]] = fmul <4 x float> [[TMP5]], [[TMP1]]
; CHECK-NEXT:    [[L8:%.*]] = fadd fast <4 x float> [[L63]], [[L46]]
; CHECK-NEXT:    ret <4 x float> [[L8]]
;
entry:
  %wide.vec = load <8 x float>, <8 x float>* %pSrc1, align 4
  %wide.vec26 = load <8 x float>, <8 x float>* %pSrc2, align 4
  %l4 = fmul fast <8 x float> %wide.vec26, %wide.vec
  %l5 = shufflevector <8 x float> %l4, <8 x float> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %l6 = fmul fast <8 x float> %wide.vec26, %wide.vec
  %l7 = shufflevector <8 x float> %l6, <8 x float> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %l8 = fadd fast <4 x float> %l7, %l5
  ret <4 x float> %l8
}

define <4 x float> @twosrc2(<8 x float>* %pSrc1, <8 x float>* %pSrc2) {
; CHECK-LABEL: @twosrc2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast <8 x float>* [[PSRC1:%.*]] to <4 x float>*
; CHECK-NEXT:    [[LDN:%.*]] = call { <4 x float>, <4 x float> } @llvm.aarch64.neon.ld2.v4f32.p0v4f32(<4 x float>* [[TMP0]])
; CHECK-NEXT:    [[TMP1:%.*]] = extractvalue { <4 x float>, <4 x float> } [[LDN]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x float>, <4 x float> } [[LDN]], 0
; CHECK-NEXT:    [[TMP3:%.*]] = bitcast <8 x float>* [[PSRC2:%.*]] to <4 x float>*
; CHECK-NEXT:    [[LDN4:%.*]] = call { <4 x float>, <4 x float> } @llvm.aarch64.neon.ld2.v4f32.p0v4f32(<4 x float>* [[TMP3]])
; CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { <4 x float>, <4 x float> } [[LDN4]], 0
; CHECK-NEXT:    [[TMP5:%.*]] = extractvalue { <4 x float>, <4 x float> } [[LDN4]], 1
; CHECK-NEXT:    [[L43:%.*]] = fmul <4 x float> [[TMP4]], [[TMP2]]
; CHECK-NEXT:    [[L6:%.*]] = fmul fast <4 x float> [[TMP5]], [[TMP1]]
; CHECK-NEXT:    [[L8:%.*]] = fadd fast <4 x float> [[L6]], [[L43]]
; CHECK-NEXT:    ret <4 x float> [[L8]]
;
entry:
  %wide.vec = load <8 x float>, <8 x float>* %pSrc1, align 4
  %wide.vec26 = load <8 x float>, <8 x float>* %pSrc2, align 4
  %l4 = fmul fast <8 x float> %wide.vec26, %wide.vec
  %l5 = shufflevector <8 x float> %l4, <8 x float> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %s1 = shufflevector <8 x float> %wide.vec26, <8 x float> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %s2 = shufflevector <8 x float> %wide.vec, <8 x float> poison, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %l6 = fmul fast <4 x float> %s1, %s2
  %l8 = fadd fast <4 x float> %l6, %l5
  ret <4 x float> %l8
}
