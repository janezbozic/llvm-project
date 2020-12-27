; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-none-linux-gnu -mattr=+neon < %s -o -| FileCheck %s

define <8 x i16> @smull_v8i8_v8i16(<8 x i8>* %A, <8 x i8>* %B) nounwind {
; CHECK-LABEL: smull_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    smull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i8>, <8 x i8>* %A
  %tmp2 = load <8 x i8>, <8 x i8>* %B
  %tmp3 = sext <8 x i8> %tmp1 to <8 x i16>
  %tmp4 = sext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = mul <8 x i16> %tmp3, %tmp4
  ret <8 x i16> %tmp5
}

define <4 x i32> @smull_v4i16_v4i32(<4 x i16>* %A, <4 x i16>* %B) nounwind {
; CHECK-LABEL: smull_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    smull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i16>, <4 x i16>* %A
  %tmp2 = load <4 x i16>, <4 x i16>* %B
  %tmp3 = sext <4 x i16> %tmp1 to <4 x i32>
  %tmp4 = sext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = mul <4 x i32> %tmp3, %tmp4
  ret <4 x i32> %tmp5
}

define <2 x i64> @smull_v2i32_v2i64(<2 x i32>* %A, <2 x i32>* %B) nounwind {
; CHECK-LABEL: smull_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    smull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i32>, <2 x i32>* %A
  %tmp2 = load <2 x i32>, <2 x i32>* %B
  %tmp3 = sext <2 x i32> %tmp1 to <2 x i64>
  %tmp4 = sext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = mul <2 x i64> %tmp3, %tmp4
  ret <2 x i64> %tmp5
}

define <8 x i16> @umull_v8i8_v8i16(<8 x i8>* %A, <8 x i8>* %B) nounwind {
; CHECK-LABEL: umull_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    umull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i8>, <8 x i8>* %A
  %tmp2 = load <8 x i8>, <8 x i8>* %B
  %tmp3 = zext <8 x i8> %tmp1 to <8 x i16>
  %tmp4 = zext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = mul <8 x i16> %tmp3, %tmp4
  ret <8 x i16> %tmp5
}

define <4 x i32> @umull_v4i16_v4i32(<4 x i16>* %A, <4 x i16>* %B) nounwind {
; CHECK-LABEL: umull_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    umull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i16>, <4 x i16>* %A
  %tmp2 = load <4 x i16>, <4 x i16>* %B
  %tmp3 = zext <4 x i16> %tmp1 to <4 x i32>
  %tmp4 = zext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = mul <4 x i32> %tmp3, %tmp4
  ret <4 x i32> %tmp5
}

define <2 x i64> @umull_v2i32_v2i64(<2 x i32>* %A, <2 x i32>* %B) nounwind {
; CHECK-LABEL: umull_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    umull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i32>, <2 x i32>* %A
  %tmp2 = load <2 x i32>, <2 x i32>* %B
  %tmp3 = zext <2 x i32> %tmp1 to <2 x i64>
  %tmp4 = zext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = mul <2 x i64> %tmp3, %tmp4
  ret <2 x i64> %tmp5
}

define <8 x i16> @amull_v8i8_v8i16(<8 x i8>* %A, <8 x i8>* %B) nounwind {
; CHECK-LABEL: amull_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    ushll v1.8h, v1.8b, #0
; CHECK-NEXT:    mul v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    bic v0.8h, #255, lsl #8
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i8>, <8 x i8>* %A
  %tmp2 = load <8 x i8>, <8 x i8>* %B
  %tmp3 = zext <8 x i8> %tmp1 to <8 x i16>
  %tmp4 = zext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = mul <8 x i16> %tmp3, %tmp4
  %and = and <8 x i16> %tmp5, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  ret <8 x i16> %and
}

define <4 x i32> @amull_v4i16_v4i32(<4 x i16>* %A, <4 x i16>* %B) nounwind {
; CHECK-LABEL: amull_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-NEXT:    ushll v1.4s, v1.4h, #0
; CHECK-NEXT:    mul v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    movi v1.2d, #0x00ffff0000ffff
; CHECK-NEXT:    and v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i16>, <4 x i16>* %A
  %tmp2 = load <4 x i16>, <4 x i16>* %B
  %tmp3 = zext <4 x i16> %tmp1 to <4 x i32>
  %tmp4 = zext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = mul <4 x i32> %tmp3, %tmp4
  %and = and <4 x i32> %tmp5, <i32 65535, i32 65535, i32 65535, i32 65535>
  ret <4 x i32> %and
}

define <2 x i64> @amull_v2i32_v2i64(<2 x i32>* %A, <2 x i32>* %B) nounwind {
; CHECK-LABEL: amull_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ushll v0.2d, v0.2s, #0
; CHECK-NEXT:    ushll v1.2d, v1.2s, #0
; CHECK-NEXT:    fmov x10, d1
; CHECK-NEXT:    fmov x11, d0
; CHECK-NEXT:    mov x8, v1.d[1]
; CHECK-NEXT:    mov x9, v0.d[1]
; CHECK-NEXT:    mul x10, x11, x10
; CHECK-NEXT:    mul x8, x9, x8
; CHECK-NEXT:    fmov d0, x10
; CHECK-NEXT:    mov v0.d[1], x8
; CHECK-NEXT:    movi v1.2d, #0x000000ffffffff
; CHECK-NEXT:    and v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i32>, <2 x i32>* %A
  %tmp2 = load <2 x i32>, <2 x i32>* %B
  %tmp3 = zext <2 x i32> %tmp1 to <2 x i64>
  %tmp4 = zext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = mul <2 x i64> %tmp3, %tmp4
  %and = and <2 x i64> %tmp5, <i64 4294967295, i64 4294967295>
  ret <2 x i64> %and
}

define <8 x i16> @smlal_v8i8_v8i16(<8 x i16>* %A, <8 x i8>* %B, <8 x i8>* %C) nounwind {
; CHECK-LABEL: smlal_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    smlal v0.8h, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i16>, <8 x i16>* %A
  %tmp2 = load <8 x i8>, <8 x i8>* %B
  %tmp3 = load <8 x i8>, <8 x i8>* %C
  %tmp4 = sext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = sext <8 x i8> %tmp3 to <8 x i16>
  %tmp6 = mul <8 x i16> %tmp4, %tmp5
  %tmp7 = add <8 x i16> %tmp1, %tmp6
  ret <8 x i16> %tmp7
}

define <4 x i32> @smlal_v4i16_v4i32(<4 x i32>* %A, <4 x i16>* %B, <4 x i16>* %C) nounwind {
; CHECK-LABEL: smlal_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    smlal v0.4s, v1.4h, v2.4h
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i32>, <4 x i32>* %A
  %tmp2 = load <4 x i16>, <4 x i16>* %B
  %tmp3 = load <4 x i16>, <4 x i16>* %C
  %tmp4 = sext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = sext <4 x i16> %tmp3 to <4 x i32>
  %tmp6 = mul <4 x i32> %tmp4, %tmp5
  %tmp7 = add <4 x i32> %tmp1, %tmp6
  ret <4 x i32> %tmp7
}

define <2 x i64> @smlal_v2i32_v2i64(<2 x i64>* %A, <2 x i32>* %B, <2 x i32>* %C) nounwind {
; CHECK-LABEL: smlal_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    smlal v0.2d, v1.2s, v2.2s
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i64>, <2 x i64>* %A
  %tmp2 = load <2 x i32>, <2 x i32>* %B
  %tmp3 = load <2 x i32>, <2 x i32>* %C
  %tmp4 = sext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = sext <2 x i32> %tmp3 to <2 x i64>
  %tmp6 = mul <2 x i64> %tmp4, %tmp5
  %tmp7 = add <2 x i64> %tmp1, %tmp6
  ret <2 x i64> %tmp7
}

define <8 x i16> @umlal_v8i8_v8i16(<8 x i16>* %A, <8 x i8>* %B, <8 x i8>* %C) nounwind {
; CHECK-LABEL: umlal_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    umlal v0.8h, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i16>, <8 x i16>* %A
  %tmp2 = load <8 x i8>, <8 x i8>* %B
  %tmp3 = load <8 x i8>, <8 x i8>* %C
  %tmp4 = zext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = zext <8 x i8> %tmp3 to <8 x i16>
  %tmp6 = mul <8 x i16> %tmp4, %tmp5
  %tmp7 = add <8 x i16> %tmp1, %tmp6
  ret <8 x i16> %tmp7
}

define <4 x i32> @umlal_v4i16_v4i32(<4 x i32>* %A, <4 x i16>* %B, <4 x i16>* %C) nounwind {
; CHECK-LABEL: umlal_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    umlal v0.4s, v1.4h, v2.4h
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i32>, <4 x i32>* %A
  %tmp2 = load <4 x i16>, <4 x i16>* %B
  %tmp3 = load <4 x i16>, <4 x i16>* %C
  %tmp4 = zext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = zext <4 x i16> %tmp3 to <4 x i32>
  %tmp6 = mul <4 x i32> %tmp4, %tmp5
  %tmp7 = add <4 x i32> %tmp1, %tmp6
  ret <4 x i32> %tmp7
}

define <2 x i64> @umlal_v2i32_v2i64(<2 x i64>* %A, <2 x i32>* %B, <2 x i32>* %C) nounwind {
; CHECK-LABEL: umlal_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    umlal v0.2d, v1.2s, v2.2s
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i64>, <2 x i64>* %A
  %tmp2 = load <2 x i32>, <2 x i32>* %B
  %tmp3 = load <2 x i32>, <2 x i32>* %C
  %tmp4 = zext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = zext <2 x i32> %tmp3 to <2 x i64>
  %tmp6 = mul <2 x i64> %tmp4, %tmp5
  %tmp7 = add <2 x i64> %tmp1, %tmp6
  ret <2 x i64> %tmp7
}

define <8 x i16> @amlal_v8i8_v8i16(<8 x i16>* %A, <8 x i8>* %B, <8 x i8>* %C) nounwind {
; CHECK-LABEL: amlal_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ushll v1.8h, v1.8b, #0
; CHECK-NEXT:    ushll v2.8h, v2.8b, #0
; CHECK-NEXT:    mla v0.8h, v1.8h, v2.8h
; CHECK-NEXT:    bic v0.8h, #255, lsl #8
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i16>, <8 x i16>* %A
  %tmp2 = load <8 x i8>, <8 x i8>* %B
  %tmp3 = load <8 x i8>, <8 x i8>* %C
  %tmp4 = zext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = zext <8 x i8> %tmp3 to <8 x i16>
  %tmp6 = mul <8 x i16> %tmp4, %tmp5
  %tmp7 = add <8 x i16> %tmp1, %tmp6
  %and = and <8 x i16> %tmp7, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  ret <8 x i16> %and
}

define <4 x i32> @amlal_v4i16_v4i32(<4 x i32>* %A, <4 x i16>* %B, <4 x i16>* %C) nounwind {
; CHECK-LABEL: amlal_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x1]
; CHECK-NEXT:    ldr d1, [x2]
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-NEXT:    ushll v1.4s, v1.4h, #0
; CHECK-NEXT:    mla v2.4s, v0.4s, v1.4s
; CHECK-NEXT:    movi v0.2d, #0x00ffff0000ffff
; CHECK-NEXT:    and v0.16b, v2.16b, v0.16b
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i32>, <4 x i32>* %A
  %tmp2 = load <4 x i16>, <4 x i16>* %B
  %tmp3 = load <4 x i16>, <4 x i16>* %C
  %tmp4 = zext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = zext <4 x i16> %tmp3 to <4 x i32>
  %tmp6 = mul <4 x i32> %tmp4, %tmp5
  %tmp7 = add <4 x i32> %tmp1, %tmp6
  %and = and <4 x i32> %tmp7, <i32 65535, i32 65535, i32 65535, i32 65535>
  ret <4 x i32> %and
}

define <2 x i64> @amlal_v2i32_v2i64(<2 x i64>* %A, <2 x i32>* %B, <2 x i32>* %C) nounwind {
; CHECK-LABEL: amlal_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x1]
; CHECK-NEXT:    ldr d1, [x2]
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    ushll v0.2d, v0.2s, #0
; CHECK-NEXT:    ushll v1.2d, v1.2s, #0
; CHECK-NEXT:    fmov x10, d1
; CHECK-NEXT:    fmov x11, d0
; CHECK-NEXT:    mov x8, v1.d[1]
; CHECK-NEXT:    mov x9, v0.d[1]
; CHECK-NEXT:    mul x10, x11, x10
; CHECK-NEXT:    mul x8, x9, x8
; CHECK-NEXT:    fmov d0, x10
; CHECK-NEXT:    mov v0.d[1], x8
; CHECK-NEXT:    add v0.2d, v2.2d, v0.2d
; CHECK-NEXT:    movi v1.2d, #0x000000ffffffff
; CHECK-NEXT:    and v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i64>, <2 x i64>* %A
  %tmp2 = load <2 x i32>, <2 x i32>* %B
  %tmp3 = load <2 x i32>, <2 x i32>* %C
  %tmp4 = zext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = zext <2 x i32> %tmp3 to <2 x i64>
  %tmp6 = mul <2 x i64> %tmp4, %tmp5
  %tmp7 = add <2 x i64> %tmp1, %tmp6
  %and = and <2 x i64> %tmp7, <i64 4294967295, i64 4294967295>
  ret <2 x i64> %and
}

define <8 x i16> @smlsl_v8i8_v8i16(<8 x i16>* %A, <8 x i8>* %B, <8 x i8>* %C) nounwind {
; CHECK-LABEL: smlsl_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    smlsl v0.8h, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i16>, <8 x i16>* %A
  %tmp2 = load <8 x i8>, <8 x i8>* %B
  %tmp3 = load <8 x i8>, <8 x i8>* %C
  %tmp4 = sext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = sext <8 x i8> %tmp3 to <8 x i16>
  %tmp6 = mul <8 x i16> %tmp4, %tmp5
  %tmp7 = sub <8 x i16> %tmp1, %tmp6
  ret <8 x i16> %tmp7
}

define <4 x i32> @smlsl_v4i16_v4i32(<4 x i32>* %A, <4 x i16>* %B, <4 x i16>* %C) nounwind {
; CHECK-LABEL: smlsl_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    smlsl v0.4s, v1.4h, v2.4h
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i32>, <4 x i32>* %A
  %tmp2 = load <4 x i16>, <4 x i16>* %B
  %tmp3 = load <4 x i16>, <4 x i16>* %C
  %tmp4 = sext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = sext <4 x i16> %tmp3 to <4 x i32>
  %tmp6 = mul <4 x i32> %tmp4, %tmp5
  %tmp7 = sub <4 x i32> %tmp1, %tmp6
  ret <4 x i32> %tmp7
}

define <2 x i64> @smlsl_v2i32_v2i64(<2 x i64>* %A, <2 x i32>* %B, <2 x i32>* %C) nounwind {
; CHECK-LABEL: smlsl_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    smlsl v0.2d, v1.2s, v2.2s
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i64>, <2 x i64>* %A
  %tmp2 = load <2 x i32>, <2 x i32>* %B
  %tmp3 = load <2 x i32>, <2 x i32>* %C
  %tmp4 = sext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = sext <2 x i32> %tmp3 to <2 x i64>
  %tmp6 = mul <2 x i64> %tmp4, %tmp5
  %tmp7 = sub <2 x i64> %tmp1, %tmp6
  ret <2 x i64> %tmp7
}

define <8 x i16> @umlsl_v8i8_v8i16(<8 x i16>* %A, <8 x i8>* %B, <8 x i8>* %C) nounwind {
; CHECK-LABEL: umlsl_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    umlsl v0.8h, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i16>, <8 x i16>* %A
  %tmp2 = load <8 x i8>, <8 x i8>* %B
  %tmp3 = load <8 x i8>, <8 x i8>* %C
  %tmp4 = zext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = zext <8 x i8> %tmp3 to <8 x i16>
  %tmp6 = mul <8 x i16> %tmp4, %tmp5
  %tmp7 = sub <8 x i16> %tmp1, %tmp6
  ret <8 x i16> %tmp7
}

define <4 x i32> @umlsl_v4i16_v4i32(<4 x i32>* %A, <4 x i16>* %B, <4 x i16>* %C) nounwind {
; CHECK-LABEL: umlsl_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    umlsl v0.4s, v1.4h, v2.4h
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i32>, <4 x i32>* %A
  %tmp2 = load <4 x i16>, <4 x i16>* %B
  %tmp3 = load <4 x i16>, <4 x i16>* %C
  %tmp4 = zext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = zext <4 x i16> %tmp3 to <4 x i32>
  %tmp6 = mul <4 x i32> %tmp4, %tmp5
  %tmp7 = sub <4 x i32> %tmp1, %tmp6
  ret <4 x i32> %tmp7
}

define <2 x i64> @umlsl_v2i32_v2i64(<2 x i64>* %A, <2 x i32>* %B, <2 x i32>* %C) nounwind {
; CHECK-LABEL: umlsl_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    umlsl v0.2d, v1.2s, v2.2s
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i64>, <2 x i64>* %A
  %tmp2 = load <2 x i32>, <2 x i32>* %B
  %tmp3 = load <2 x i32>, <2 x i32>* %C
  %tmp4 = zext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = zext <2 x i32> %tmp3 to <2 x i64>
  %tmp6 = mul <2 x i64> %tmp4, %tmp5
  %tmp7 = sub <2 x i64> %tmp1, %tmp6
  ret <2 x i64> %tmp7
}

define <8 x i16> @amlsl_v8i8_v8i16(<8 x i16>* %A, <8 x i8>* %B, <8 x i8>* %C) nounwind {
; CHECK-LABEL: amlsl_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d1, [x1]
; CHECK-NEXT:    ldr d2, [x2]
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ushll v1.8h, v1.8b, #0
; CHECK-NEXT:    ushll v2.8h, v2.8b, #0
; CHECK-NEXT:    mls v0.8h, v1.8h, v2.8h
; CHECK-NEXT:    bic v0.8h, #255, lsl #8
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i16>, <8 x i16>* %A
  %tmp2 = load <8 x i8>, <8 x i8>* %B
  %tmp3 = load <8 x i8>, <8 x i8>* %C
  %tmp4 = zext <8 x i8> %tmp2 to <8 x i16>
  %tmp5 = zext <8 x i8> %tmp3 to <8 x i16>
  %tmp6 = mul <8 x i16> %tmp4, %tmp5
  %tmp7 = sub <8 x i16> %tmp1, %tmp6
  %and = and <8 x i16> %tmp7, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  ret <8 x i16> %and
}

define <4 x i32> @amlsl_v4i16_v4i32(<4 x i32>* %A, <4 x i16>* %B, <4 x i16>* %C) nounwind {
; CHECK-LABEL: amlsl_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x1]
; CHECK-NEXT:    ldr d1, [x2]
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-NEXT:    ushll v1.4s, v1.4h, #0
; CHECK-NEXT:    mls v2.4s, v0.4s, v1.4s
; CHECK-NEXT:    movi v0.2d, #0x00ffff0000ffff
; CHECK-NEXT:    and v0.16b, v2.16b, v0.16b
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i32>, <4 x i32>* %A
  %tmp2 = load <4 x i16>, <4 x i16>* %B
  %tmp3 = load <4 x i16>, <4 x i16>* %C
  %tmp4 = zext <4 x i16> %tmp2 to <4 x i32>
  %tmp5 = zext <4 x i16> %tmp3 to <4 x i32>
  %tmp6 = mul <4 x i32> %tmp4, %tmp5
  %tmp7 = sub <4 x i32> %tmp1, %tmp6
  %and = and <4 x i32> %tmp7, <i32 65535, i32 65535, i32 65535, i32 65535>
  ret <4 x i32> %and
}

define <2 x i64> @amlsl_v2i32_v2i64(<2 x i64>* %A, <2 x i32>* %B, <2 x i32>* %C) nounwind {
; CHECK-LABEL: amlsl_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr d0, [x1]
; CHECK-NEXT:    ldr d1, [x2]
; CHECK-NEXT:    ldr q2, [x0]
; CHECK-NEXT:    ushll v0.2d, v0.2s, #0
; CHECK-NEXT:    ushll v1.2d, v1.2s, #0
; CHECK-NEXT:    fmov x10, d1
; CHECK-NEXT:    fmov x11, d0
; CHECK-NEXT:    mov x8, v1.d[1]
; CHECK-NEXT:    mov x9, v0.d[1]
; CHECK-NEXT:    mul x10, x11, x10
; CHECK-NEXT:    mul x8, x9, x8
; CHECK-NEXT:    fmov d0, x10
; CHECK-NEXT:    mov v0.d[1], x8
; CHECK-NEXT:    sub v0.2d, v2.2d, v0.2d
; CHECK-NEXT:    movi v1.2d, #0x000000ffffffff
; CHECK-NEXT:    and v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %tmp1 = load <2 x i64>, <2 x i64>* %A
  %tmp2 = load <2 x i32>, <2 x i32>* %B
  %tmp3 = load <2 x i32>, <2 x i32>* %C
  %tmp4 = zext <2 x i32> %tmp2 to <2 x i64>
  %tmp5 = zext <2 x i32> %tmp3 to <2 x i64>
  %tmp6 = mul <2 x i64> %tmp4, %tmp5
  %tmp7 = sub <2 x i64> %tmp1, %tmp6
  %and = and <2 x i64> %tmp7, <i64 4294967295, i64 4294967295>
  ret <2 x i64> %and
}

; SMULL recognizing BUILD_VECTORs with sign/zero-extended elements.
define <8 x i16> @smull_extvec_v8i8_v8i16(<8 x i8> %arg) nounwind {
; CHECK-LABEL: smull_extvec_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8b, #244
; CHECK-NEXT:    smull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ret
  %tmp3 = sext <8 x i8> %arg to <8 x i16>
  %tmp4 = mul <8 x i16> %tmp3, <i16 -12, i16 -12, i16 -12, i16 -12, i16 -12, i16 -12, i16 -12, i16 -12>
  ret <8 x i16> %tmp4
}

define <8 x i16> @smull_noextvec_v8i8_v8i16(<8 x i8> %arg) nounwind {
; Do not use SMULL if the BUILD_VECTOR element values are too big.
; CHECK-LABEL: smull_noextvec_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #64537
; CHECK-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-NEXT:    dup v1.8h, w8
; CHECK-NEXT:    mul v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %tmp3 = sext <8 x i8> %arg to <8 x i16>
  %tmp4 = mul <8 x i16> %tmp3, <i16 -999, i16 -999, i16 -999, i16 -999, i16 -999, i16 -999, i16 -999, i16 -999>
  ret <8 x i16> %tmp4
}

define <4 x i32> @smull_extvec_v4i16_v4i32(<4 x i16> %arg) nounwind {
; CHECK-LABEL: smull_extvec_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v1.4h, #11
; CHECK-NEXT:    smull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ret
  %tmp3 = sext <4 x i16> %arg to <4 x i32>
  %tmp4 = mul <4 x i32> %tmp3, <i32 -12, i32 -12, i32 -12, i32 -12>
  ret <4 x i32> %tmp4
}

define <2 x i64> @smull_extvec_v2i32_v2i64(<2 x i32> %arg) nounwind {
; CHECK-LABEL: smull_extvec_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-1234
; CHECK-NEXT:    dup v1.2s, w8
; CHECK-NEXT:    smull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    ret
  %tmp3 = sext <2 x i32> %arg to <2 x i64>
  %tmp4 = mul <2 x i64> %tmp3, <i64 -1234, i64 -1234>
  ret <2 x i64> %tmp4
}

define <8 x i16> @umull_extvec_v8i8_v8i16(<8 x i8> %arg) nounwind {
; CHECK-LABEL: umull_extvec_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8b, #12
; CHECK-NEXT:    umull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    ret
  %tmp3 = zext <8 x i8> %arg to <8 x i16>
  %tmp4 = mul <8 x i16> %tmp3, <i16 12, i16 12, i16 12, i16 12, i16 12, i16 12, i16 12, i16 12>
  ret <8 x i16> %tmp4
}

define <8 x i16> @umull_noextvec_v8i8_v8i16(<8 x i8> %arg) nounwind {
; Do not use SMULL if the BUILD_VECTOR element values are too big.
; CHECK-LABEL: umull_noextvec_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #999
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    dup v1.8h, w8
; CHECK-NEXT:    mul v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %tmp3 = zext <8 x i8> %arg to <8 x i16>
  %tmp4 = mul <8 x i16> %tmp3, <i16 999, i16 999, i16 999, i16 999, i16 999, i16 999, i16 999, i16 999>
  ret <8 x i16> %tmp4
}

define <4 x i32> @umull_extvec_v4i16_v4i32(<4 x i16> %arg) nounwind {
; CHECK-LABEL: umull_extvec_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1234
; CHECK-NEXT:    dup v1.4h, w8
; CHECK-NEXT:    umull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    ret
  %tmp3 = zext <4 x i16> %arg to <4 x i32>
  %tmp4 = mul <4 x i32> %tmp3, <i32 1234, i32 1234, i32 1234, i32 1234>
  ret <4 x i32> %tmp4
}

define <2 x i64> @umull_extvec_v2i32_v2i64(<2 x i32> %arg) nounwind {
; CHECK-LABEL: umull_extvec_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1234
; CHECK-NEXT:    dup v1.2s, w8
; CHECK-NEXT:    umull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    ret
  %tmp3 = zext <2 x i32> %arg to <2 x i64>
  %tmp4 = mul <2 x i64> %tmp3, <i64 1234, i64 1234>
  ret <2 x i64> %tmp4
}

define <8 x i16> @amull_extvec_v8i8_v8i16(<8 x i8> %arg) nounwind {
; CHECK-LABEL: amull_extvec_v8i8_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    movi v1.8h, #12
; CHECK-NEXT:    mul v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    bic v0.8h, #255, lsl #8
; CHECK-NEXT:    ret
  %tmp3 = zext <8 x i8> %arg to <8 x i16>
  %tmp4 = mul <8 x i16> %tmp3, <i16 12, i16 12, i16 12, i16 12, i16 12, i16 12, i16 12, i16 12>
  %and = and <8 x i16> %tmp4, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  ret <8 x i16> %and
}

define <4 x i32> @amull_extvec_v4i16_v4i32(<4 x i16> %arg) nounwind {
; CHECK-LABEL: amull_extvec_v4i16_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1234
; CHECK-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-NEXT:    dup v1.4s, w8
; CHECK-NEXT:    mul v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    movi v1.2d, #0x00ffff0000ffff
; CHECK-NEXT:    and v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %tmp3 = zext <4 x i16> %arg to <4 x i32>
  %tmp4 = mul <4 x i32> %tmp3, <i32 1234, i32 1234, i32 1234, i32 1234>
  %and = and <4 x i32> %tmp4, <i32 65535, i32 65535, i32 65535, i32 65535>
  ret <4 x i32> %and
}

define <2 x i64> @amull_extvec_v2i32_v2i64(<2 x i32> %arg) nounwind {
; CHECK-LABEL: amull_extvec_v2i32_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushll v0.2d, v0.2s, #0
; CHECK-NEXT:    mov w8, #1234
; CHECK-NEXT:    fmov x10, d0
; CHECK-NEXT:    mov x9, v0.d[1]
; CHECK-NEXT:    mul x10, x10, x8
; CHECK-NEXT:    mul x8, x9, x8
; CHECK-NEXT:    fmov d0, x10
; CHECK-NEXT:    mov v0.d[1], x8
; CHECK-NEXT:    movi v1.2d, #0x000000ffffffff
; CHECK-NEXT:    and v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ret
  %tmp3 = zext <2 x i32> %arg to <2 x i64>
  %tmp4 = mul <2 x i64> %tmp3, <i64 1234, i64 1234>
  %and = and <2 x i64> %tmp4, <i64 4294967295, i64 4294967295>
  ret <2 x i64> %and
}

define i16 @smullWithInconsistentExtensions(<8 x i8> %x, <8 x i8> %y) {
; If one operand has a zero-extend and the other a sign-extend, smull
; cannot be used.
; CHECK-LABEL: smullWithInconsistentExtensions:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sshll v0.8h, v0.8b, #0
; CHECK-NEXT:    ushll v1.8h, v1.8b, #0
; CHECK-NEXT:    mul v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    umov w0, v0.h[0]
; CHECK-NEXT:    ret
  %s = sext <8 x i8> %x to <8 x i16>
  %z = zext <8 x i8> %y to <8 x i16>
  %m = mul <8 x i16> %s, %z
  %r = extractelement <8 x i16> %m, i32 0
  ret i16 %r
}

define void @distribute(<8 x i16>* %dst, <16 x i8>* %src, i32 %mul) nounwind {
; CHECK-LABEL: distribute:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr q0, [x1]
; CHECK-NEXT:    dup v1.8b, w2
; CHECK-NEXT:    mov d2, v0.d[1]
; CHECK-NEXT:    umull v2.8h, v2.8b, v1.8b
; CHECK-NEXT:    umlal v2.8h, v0.8b, v1.8b
; CHECK-NEXT:    str q2, [x0]
; CHECK-NEXT:    ret
entry:
  %0 = trunc i32 %mul to i8
  %1 = insertelement <8 x i8> undef, i8 %0, i32 0
  %2 = shufflevector <8 x i8> %1, <8 x i8> undef, <8 x i32> zeroinitializer
  %3 = load <16 x i8>, <16 x i8>* %src, align 1
  %4 = bitcast <16 x i8> %3 to <2 x double>
  %5 = extractelement <2 x double> %4, i32 1
  %6 = bitcast double %5 to <8 x i8>
  %7 = zext <8 x i8> %6 to <8 x i16>
  %8 = zext <8 x i8> %2 to <8 x i16>
  %9 = extractelement <2 x double> %4, i32 0
  %10 = bitcast double %9 to <8 x i8>
  %11 = zext <8 x i8> %10 to <8 x i16>
  %12 = add <8 x i16> %7, %11
  %13 = mul <8 x i16> %12, %8
  store <8 x i16> %13, <8 x i16>* %dst, align 2
  ret void
}

define <16 x i16> @umull2_i8(<16 x i8> %arg1, <16 x i8> %arg2) {
; CHECK-LABEL: umull2_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umull2 v2.8h, v0.16b, v1.16b
; CHECK-NEXT:    umull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = zext <16 x i8> %arg1 to <16 x i16>
  %arg2_ext = zext <16 x i8> %arg2 to <16 x i16>
  %mul = mul <16 x i16> %arg1_ext, %arg2_ext
  ret <16 x i16> %mul
}

define <16 x i16> @smull2_i8(<16 x i8> %arg1, <16 x i8> %arg2) {
; CHECK-LABEL: smull2_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smull2 v2.8h, v0.16b, v1.16b
; CHECK-NEXT:    smull v0.8h, v0.8b, v1.8b
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = sext <16 x i8> %arg1 to <16 x i16>
  %arg2_ext = sext <16 x i8> %arg2 to <16 x i16>
  %mul = mul <16 x i16> %arg1_ext, %arg2_ext
  ret <16 x i16> %mul
}

define <8 x i32> @umull2_i16(<8 x i16> %arg1, <8 x i16> %arg2) {
; CHECK-LABEL: umull2_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umull2 v2.4s, v0.8h, v1.8h
; CHECK-NEXT:    umull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = zext <8 x i16> %arg1 to <8 x i32>
  %arg2_ext = zext <8 x i16> %arg2 to <8 x i32>
  %mul = mul <8 x i32> %arg1_ext, %arg2_ext
  ret <8 x i32> %mul
}

define <8 x i32> @smull2_i16(<8 x i16> %arg1, <8 x i16> %arg2) {
; CHECK-LABEL: smull2_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smull2 v2.4s, v0.8h, v1.8h
; CHECK-NEXT:    smull v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = sext <8 x i16> %arg1 to <8 x i32>
  %arg2_ext = sext <8 x i16> %arg2 to <8 x i32>
  %mul = mul <8 x i32> %arg1_ext, %arg2_ext
  ret <8 x i32> %mul
}

define <4 x i64> @umull2_i32(<4 x i32> %arg1, <4 x i32> %arg2) {
; CHECK-LABEL: umull2_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umull2 v2.2d, v0.4s, v1.4s
; CHECK-NEXT:    umull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = zext <4 x i32> %arg1 to <4 x i64>
  %arg2_ext = zext <4 x i32> %arg2 to <4 x i64>
  %mul = mul <4 x i64> %arg1_ext, %arg2_ext
  ret <4 x i64> %mul
}

define <4 x i64> @smull2_i32(<4 x i32> %arg1, <4 x i32> %arg2) {
; CHECK-LABEL: smull2_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    smull2 v2.2d, v0.4s, v1.4s
; CHECK-NEXT:    smull v0.2d, v0.2s, v1.2s
; CHECK-NEXT:    mov v1.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = sext <4 x i32> %arg1 to <4 x i64>
  %arg2_ext = sext <4 x i32> %arg2 to <4 x i64>
  %mul = mul <4 x i64> %arg1_ext, %arg2_ext
  ret <4 x i64> %mul
}

define <16 x i16> @amull2_i8(<16 x i8> %arg1, <16 x i8> %arg2) {
; CHECK-LABEL: amull2_i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushll2 v2.8h, v0.16b, #0
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    ushll2 v3.8h, v1.16b, #0
; CHECK-NEXT:    ushll v1.8h, v1.8b, #0
; CHECK-NEXT:    mul v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    mul v1.8h, v2.8h, v3.8h
; CHECK-NEXT:    bic v1.8h, #255, lsl #8
; CHECK-NEXT:    bic v0.8h, #255, lsl #8
; CHECK-NEXT:    ret
  %arg1_ext = zext <16 x i8> %arg1 to <16 x i16>
  %arg2_ext = zext <16 x i8> %arg2 to <16 x i16>
  %mul = mul <16 x i16> %arg1_ext, %arg2_ext
  %and = and <16 x i16> %mul, <i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255, i16 255>
  ret <16 x i16> %and
}

define <8 x i32> @amull2_i16(<8 x i16> %arg1, <8 x i16> %arg2) {
; CHECK-LABEL: amull2_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushll2 v2.4s, v0.8h, #0
; CHECK-NEXT:    ushll v0.4s, v0.4h, #0
; CHECK-NEXT:    ushll2 v3.4s, v1.8h, #0
; CHECK-NEXT:    ushll v1.4s, v1.4h, #0
; CHECK-NEXT:    movi v4.2d, #0x00ffff0000ffff
; CHECK-NEXT:    mul v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    mul v1.4s, v2.4s, v3.4s
; CHECK-NEXT:    and v1.16b, v1.16b, v4.16b
; CHECK-NEXT:    and v0.16b, v0.16b, v4.16b
; CHECK-NEXT:    ret
  %arg1_ext = zext <8 x i16> %arg1 to <8 x i32>
  %arg2_ext = zext <8 x i16> %arg2 to <8 x i32>
  %mul = mul <8 x i32> %arg1_ext, %arg2_ext
  %and = and <8 x i32> %mul, <i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535, i32 65535>
  ret <8 x i32> %and
}

define <4 x i64> @amull2_i32(<4 x i32> %arg1, <4 x i32> %arg2) {
; CHECK-LABEL: amull2_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushll2 v2.2d, v0.4s, #0
; CHECK-NEXT:    ushll v0.2d, v0.2s, #0
; CHECK-NEXT:    ushll2 v3.2d, v1.4s, #0
; CHECK-NEXT:    ushll v1.2d, v1.2s, #0
; CHECK-NEXT:    fmov x10, d1
; CHECK-NEXT:    fmov x11, d0
; CHECK-NEXT:    fmov x13, d3
; CHECK-NEXT:    fmov x14, d2
; CHECK-NEXT:    mov x8, v1.d[1]
; CHECK-NEXT:    mov x9, v0.d[1]
; CHECK-NEXT:    mul x10, x11, x10
; CHECK-NEXT:    mov x11, v3.d[1]
; CHECK-NEXT:    mov x12, v2.d[1]
; CHECK-NEXT:    mul x13, x14, x13
; CHECK-NEXT:    mul x8, x9, x8
; CHECK-NEXT:    fmov d0, x10
; CHECK-NEXT:    mul x9, x12, x11
; CHECK-NEXT:    fmov d1, x13
; CHECK-NEXT:    movi v2.2d, #0x000000ffffffff
; CHECK-NEXT:    mov v0.d[1], x8
; CHECK-NEXT:    mov v1.d[1], x9
; CHECK-NEXT:    and v1.16b, v1.16b, v2.16b
; CHECK-NEXT:    and v0.16b, v0.16b, v2.16b
; CHECK-NEXT:    ret
  %arg1_ext = zext <4 x i32> %arg1 to <4 x i64>
  %arg2_ext = zext <4 x i32> %arg2 to <4 x i64>
  %mul = mul <4 x i64> %arg1_ext, %arg2_ext
  %and = and <4 x i64> %mul, <i64 4294967295, i64 4294967295, i64 4294967295, i64 4294967295>
  ret <4 x i64> %and
}

