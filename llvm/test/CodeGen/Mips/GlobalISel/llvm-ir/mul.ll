; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc  -O0 -mtriple=mipsel-linux-gnu -global-isel  -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=MIPS32
define i32 @mul_i32(i32 %x, i32 %y) {
; MIPS32-LABEL: mul_i32:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $2, $4, $5
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %z = mul i32 %x, %y
  ret i32 %z
}

define signext i8 @mul_i8_sext(i8 signext %a, i8 signext %b) {
; MIPS32-LABEL: mul_i8_sext:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $1, $5, $4
; MIPS32-NEXT:    sll $1, $1, 24
; MIPS32-NEXT:    sra $2, $1, 24
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i8 %b, %a
  ret i8 %mul
}

define zeroext i8 @mul_i8_zext(i8 zeroext %a, i8 zeroext %b) {
; MIPS32-LABEL: mul_i8_zext:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $1, $5, $4
; MIPS32-NEXT:    ori $2, $zero, 255
; MIPS32-NEXT:    and $2, $1, $2
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i8 %b, %a
  ret i8 %mul
}

define i8 @mul_i8_aext(i8 %a, i8 %b) {
; MIPS32-LABEL: mul_i8_aext:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $2, $5, $4
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i8 %b, %a
  ret i8 %mul
}

define signext i16 @mul_i16_sext(i16 signext %a, i16 signext %b) {
; MIPS32-LABEL: mul_i16_sext:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $1, $5, $4
; MIPS32-NEXT:    sll $1, $1, 16
; MIPS32-NEXT:    sra $2, $1, 16
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i16 %b, %a
  ret i16 %mul
}

define zeroext i16 @mul_i16_zext(i16 zeroext %a, i16 zeroext %b) {
; MIPS32-LABEL: mul_i16_zext:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $1, $5, $4
; MIPS32-NEXT:    ori $2, $zero, 65535
; MIPS32-NEXT:    and $2, $1, $2
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i16 %b, %a
  ret i16 %mul
}

define i16 @mul_i16_aext(i16 %a, i16 %b) {
; MIPS32-LABEL: mul_i16_aext:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $2, $5, $4
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i16 %b, %a
  ret i16 %mul
}

define i64 @mul_i64(i64 %a, i64 %b) {
; MIPS32-LABEL: mul_i64:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    mul $2, $6, $4
; MIPS32-NEXT:    mul $1, $7, $4
; MIPS32-NEXT:    mul $3, $6, $5
; MIPS32-NEXT:    multu $6, $4
; MIPS32-NEXT:    mfhi $4
; MIPS32-NEXT:    addu $1, $1, $3
; MIPS32-NEXT:    addu $3, $1, $4
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i64 %b, %a
  ret i64 %mul
}

define i128 @mul_i128(i128 %a, i128 %b) {
; MIPS32-LABEL: mul_i128:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    addiu $1, $sp, 16
; MIPS32-NEXT:    lw $1, 0($1)
; MIPS32-NEXT:    addiu $2, $sp, 20
; MIPS32-NEXT:    lw $2, 0($2)
; MIPS32-NEXT:    addiu $3, $sp, 24
; MIPS32-NEXT:    lw $3, 0($3)
; MIPS32-NEXT:    addiu $8, $sp, 28
; MIPS32-NEXT:    lw $8, 0($8)
; MIPS32-NEXT:    mul $9, $1, $4
; MIPS32-NEXT:    mul $10, $2, $4
; MIPS32-NEXT:    mul $11, $1, $5
; MIPS32-NEXT:    multu $1, $4
; MIPS32-NEXT:    mfhi $12
; MIPS32-NEXT:    addu $10, $10, $11
; MIPS32-NEXT:    sltu $11, $10, $11
; MIPS32-NEXT:    ori $13, $zero, 1
; MIPS32-NEXT:    and $11, $11, $13
; MIPS32-NEXT:    addu $10, $10, $12
; MIPS32-NEXT:    sltu $12, $10, $12
; MIPS32-NEXT:    and $12, $12, $13
; MIPS32-NEXT:    addu $11, $11, $12
; MIPS32-NEXT:    mul $12, $3, $4
; MIPS32-NEXT:    mul $14, $2, $5
; MIPS32-NEXT:    mul $15, $1, $6
; MIPS32-NEXT:    multu $2, $4
; MIPS32-NEXT:    mfhi $24
; MIPS32-NEXT:    multu $1, $5
; MIPS32-NEXT:    mfhi $25
; MIPS32-NEXT:    addu $12, $12, $14
; MIPS32-NEXT:    sltu $14, $12, $14
; MIPS32-NEXT:    and $14, $14, $13
; MIPS32-NEXT:    addu $12, $12, $15
; MIPS32-NEXT:    sltu $15, $12, $15
; MIPS32-NEXT:    and $15, $15, $13
; MIPS32-NEXT:    addu $14, $14, $15
; MIPS32-NEXT:    addu $12, $12, $24
; MIPS32-NEXT:    sltu $15, $12, $24
; MIPS32-NEXT:    and $15, $15, $13
; MIPS32-NEXT:    addu $14, $14, $15
; MIPS32-NEXT:    addu $12, $12, $25
; MIPS32-NEXT:    sltu $15, $12, $25
; MIPS32-NEXT:    and $15, $15, $13
; MIPS32-NEXT:    addu $14, $14, $15
; MIPS32-NEXT:    addu $12, $12, $11
; MIPS32-NEXT:    sltu $11, $12, $11
; MIPS32-NEXT:    and $11, $11, $13
; MIPS32-NEXT:    addu $11, $14, $11
; MIPS32-NEXT:    mul $8, $8, $4
; MIPS32-NEXT:    mul $13, $3, $5
; MIPS32-NEXT:    mul $14, $2, $6
; MIPS32-NEXT:    mul $7, $1, $7
; MIPS32-NEXT:    multu $3, $4
; MIPS32-NEXT:    mfhi $3
; MIPS32-NEXT:    multu $2, $5
; MIPS32-NEXT:    mfhi $2
; MIPS32-NEXT:    multu $1, $6
; MIPS32-NEXT:    mfhi $1
; MIPS32-NEXT:    addu $4, $8, $13
; MIPS32-NEXT:    addu $4, $4, $14
; MIPS32-NEXT:    addu $4, $4, $7
; MIPS32-NEXT:    addu $3, $4, $3
; MIPS32-NEXT:    addu $2, $3, $2
; MIPS32-NEXT:    addu $1, $2, $1
; MIPS32-NEXT:    addu $5, $1, $11
; MIPS32-NEXT:    move $2, $9
; MIPS32-NEXT:    move $3, $10
; MIPS32-NEXT:    move $4, $12
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
entry:
  %mul = mul i128 %b, %a
  ret i128 %mul
}

declare { i32, i1 } @llvm.umul.with.overflow.i32(i32, i32)
define void @umul_with_overflow(i32 %lhs, i32 %rhs, i32* %pmul, i1* %pcarry_flag) {
; MIPS32-LABEL: umul_with_overflow:
; MIPS32:       # %bb.0:
; MIPS32-NEXT:    mul $1, $4, $5
; MIPS32-NEXT:    multu $4, $5
; MIPS32-NEXT:    mfhi $2
; MIPS32-NEXT:    ori $3, $zero, 0
; MIPS32-NEXT:    xor $2, $2, $3
; MIPS32-NEXT:    sltu $2, $zero, $2
; MIPS32-NEXT:    ori $3, $zero, 1
; MIPS32-NEXT:    and $2, $2, $3
; MIPS32-NEXT:    sb $2, 0($7)
; MIPS32-NEXT:    sw $1, 0($6)
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
  %res = call { i32, i1 } @llvm.umul.with.overflow.i32(i32 %lhs, i32 %rhs)
  %carry_flag = extractvalue { i32, i1 } %res, 1
  %mul = extractvalue { i32, i1 } %res, 0
  store i1 %carry_flag, i1* %pcarry_flag
  store i32 %mul, i32* %pmul
  ret void
}
