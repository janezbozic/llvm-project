; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=mips -mcpu=mips32 < %s | FileCheck %s -check-prefixes=32
; RUN: llc -march=mips -mcpu=mips32r2 < %s | FileCheck %s -check-prefixes=32
; RUN: llc -march=mips -mcpu=mips32r6 < %s | FileCheck %s -check-prefixes=32R6
; RUN: llc -march=mips -mcpu=mips32r2 -mattr=dsp < %s | FileCheck %s -check-prefix=DSP
; RUN: llc -march=mips -mcpu=mips64   -target-abi n64 < %s | FileCheck %s -check-prefixes=64
; RUN: llc -march=mips -mcpu=mips64r2 -target-abi n64 < %s | FileCheck %s -check-prefixes=64
; RUN: llc -march=mips -mcpu=mips64r6 -target-abi n64 < %s | FileCheck %s -check-prefixes=64R6
; RUN: llc -march=mips -mattr=mips16 < %s | FileCheck %s -check-prefixes=16

define i64 @madd1(i32 %a, i32 %b, i32 %c) nounwind readnone {
; 32-LABEL: madd1:
; 32:       # %bb.0: # %entry
; 32-NEXT:    sra $1, $6, 31
; 32-NEXT:    mtlo $6
; 32-NEXT:    mthi $1
; 32-NEXT:    madd $5, $4
; 32-NEXT:    mfhi $2
; 32-NEXT:    jr $ra
; 32-NEXT:    mflo $3
;
; 32R6-LABEL: madd1:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    mul $1, $5, $4
; 32R6-NEXT:    addu $3, $1, $6
; 32R6-NEXT:    sltu $1, $3, $1
; 32R6-NEXT:    muh $2, $5, $4
; 32R6-NEXT:    sra $4, $6, 31
; 32R6-NEXT:    addu $2, $2, $4
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    addu $2, $2, $1
;
; DSP-LABEL: madd1:
; DSP:       # %bb.0: # %entry
; DSP-NEXT:    sra $1, $6, 31
; DSP-NEXT:    mtlo $6, $ac0
; DSP-NEXT:    mthi $1, $ac0
; DSP-NEXT:    madd $ac0, $5, $4
; DSP-NEXT:    mfhi $2, $ac0
; DSP-NEXT:    jr $ra
; DSP-NEXT:    mflo $3, $ac0
;
; 64-LABEL: madd1:
; 64:       # %bb.0: # %entry
; 64-NEXT:    sll $1, $4, 0
; 64-NEXT:    sll $2, $5, 0
; 64-NEXT:    dmult $2, $1
; 64-NEXT:    mflo $1
; 64-NEXT:    sll $2, $6, 0
; 64-NEXT:    jr $ra
; 64-NEXT:    daddu $2, $1, $2
;
; 64R6-LABEL: madd1:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    sll $1, $4, 0
; 64R6-NEXT:    sll $2, $5, 0
; 64R6-NEXT:    dmul $1, $2, $1
; 64R6-NEXT:    sll $2, $6, 0
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    daddu $2, $1, $2
;
; 16-LABEL: madd1:
; 16:       # %bb.0: # %entry
; 16-NEXT:    mult $5, $4
; 16-NEXT:    mflo $2
; 16-NEXT:    mfhi $3
; 16-NEXT:    sra $4, $6, 31
; 16-NEXT:    addu $4, $3, $4
; 16-NEXT:    addu $3, $2, $6
; 16-NEXT:    sltu $3, $2
; 16-NEXT:    move $2, $24
; 16-NEXT:    addu $2, $4, $2
; 16-NEXT:    jrc $ra
entry:
  %conv = sext i32 %a to i64
  %conv2 = sext i32 %b to i64
  %mul = mul nsw i64 %conv2, %conv
  %conv4 = sext i32 %c to i64
  %add = add nsw i64 %mul, %conv4
  ret i64 %add
}

define i64 @madd2(i32 zeroext %a, i32 zeroext %b, i32 zeroext %c) nounwind readnone {
; 32-LABEL: madd2:
; 32:       # %bb.0: # %entry
; 32-NEXT:    addiu $1, $zero, 0
; 32-NEXT:    mtlo $6
; 32-NEXT:    mthi $1
; 32-NEXT:    maddu $5, $4
; 32-NEXT:    mfhi $2
; 32-NEXT:    jr $ra
; 32-NEXT:    mflo $3
;
; 32R6-LABEL: madd2:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    mul $1, $5, $4
; 32R6-NEXT:    addu $3, $1, $6
; 32R6-NEXT:    sltu $1, $3, $1
; 32R6-NEXT:    muhu $2, $5, $4
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    addu $2, $2, $1
;
; DSP-LABEL: madd2:
; DSP:       # %bb.0: # %entry
; DSP-NEXT:    addiu $1, $zero, 0
; DSP-NEXT:    mtlo $6, $ac0
; DSP-NEXT:    mthi $1, $ac0
; DSP-NEXT:    maddu $ac0, $5, $4
; DSP-NEXT:    mfhi $2, $ac0
; DSP-NEXT:    jr $ra
; DSP-NEXT:    mflo $3, $ac0
;
; 64-LABEL: madd2:
; 64:       # %bb.0: # %entry
; 64-NEXT:    dmult $5, $4
; 64-NEXT:    mflo $1
; 64-NEXT:    jr $ra
; 64-NEXT:    daddu $2, $1, $6
;
; 64R6-LABEL: madd2:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    dmul $1, $5, $4
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    daddu $2, $1, $6
;
; 16-LABEL: madd2:
; 16:       # %bb.0: # %entry
; 16-NEXT:    multu $5, $4
; 16-NEXT:    mflo $2
; 16-NEXT:    mfhi $4
; 16-NEXT:    addu $3, $2, $6
; 16-NEXT:    sltu $3, $2
; 16-NEXT:    move $2, $24
; 16-NEXT:    addu $2, $4, $2
; 16-NEXT:    jrc $ra
entry:
  %conv = zext i32 %a to i64
  %conv2 = zext i32 %b to i64
  %mul = mul nsw i64 %conv2, %conv
  %conv4 = zext i32 %c to i64
  %add = add nsw i64 %mul, %conv4
  ret i64 %add
}

define i64 @madd3(i32 %a, i32 %b, i64 %c) nounwind readnone {
; 32-LABEL: madd3:
; 32:       # %bb.0: # %entry
; 32-NEXT:    mtlo $7
; 32-NEXT:    mthi $6
; 32-NEXT:    madd $5, $4
; 32-NEXT:    mfhi $2
; 32-NEXT:    jr $ra
; 32-NEXT:    mflo $3
;
; 32R6-LABEL: madd3:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    mul $1, $5, $4
; 32R6-NEXT:    addu $3, $1, $7
; 32R6-NEXT:    sltu $1, $3, $1
; 32R6-NEXT:    muh $2, $5, $4
; 32R6-NEXT:    addu $2, $2, $6
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    addu $2, $2, $1
;
; DSP-LABEL: madd3:
; DSP:       # %bb.0: # %entry
; DSP-NEXT:    mtlo $7, $ac0
; DSP-NEXT:    mthi $6, $ac0
; DSP-NEXT:    madd $ac0, $5, $4
; DSP-NEXT:    mfhi $2, $ac0
; DSP-NEXT:    jr $ra
; DSP-NEXT:    mflo $3, $ac0
;
; 64-LABEL: madd3:
; 64:       # %bb.0: # %entry
; 64-NEXT:    sll $1, $4, 0
; 64-NEXT:    sll $2, $5, 0
; 64-NEXT:    dmult $2, $1
; 64-NEXT:    mflo $1
; 64-NEXT:    jr $ra
; 64-NEXT:    daddu $2, $1, $6
;
; 64R6-LABEL: madd3:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    sll $1, $4, 0
; 64R6-NEXT:    sll $2, $5, 0
; 64R6-NEXT:    dmul $1, $2, $1
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    daddu $2, $1, $6
;
; 16-LABEL: madd3:
; 16:       # %bb.0: # %entry
; 16-NEXT:    mult $5, $4
; 16-NEXT:    mflo $2
; 16-NEXT:    mfhi $3
; 16-NEXT:    addu $4, $3, $6
; 16-NEXT:    addu $3, $2, $7
; 16-NEXT:    sltu $3, $2
; 16-NEXT:    move $2, $24
; 16-NEXT:    addu $2, $4, $2
; 16-NEXT:    jrc $ra
entry:
  %conv = sext i32 %a to i64
  %conv2 = sext i32 %b to i64
  %mul = mul nsw i64 %conv2, %conv
  %add = add nsw i64 %mul, %c
  ret i64 %add
}

define i32 @madd4(i32 %a, i32 %b, i32 %c) {
; 32-LABEL: madd4:
; 32:       # %bb.0: # %entry
; 32-NEXT:    mul $1, $4, $5
; 32-NEXT:    jr $ra
; 32-NEXT:    addu $2, $6, $1
;
; 32R6-LABEL: madd4:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    mul $1, $4, $5
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    addu $2, $6, $1
;
; DSP-LABEL: madd4:
; DSP:       # %bb.0: # %entry
; DSP-NEXT:    mul $1, $4, $5
; DSP-NEXT:    jr $ra
; DSP-NEXT:    addu $2, $6, $1
;
; 64-LABEL: madd4:
; 64:       # %bb.0: # %entry
; 64-NEXT:    sll $1, $5, 0
; 64-NEXT:    sll $2, $4, 0
; 64-NEXT:    mul $1, $2, $1
; 64-NEXT:    sll $2, $6, 0
; 64-NEXT:    jr $ra
; 64-NEXT:    addu $2, $2, $1
;
; 64R6-LABEL: madd4:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    sll $1, $5, 0
; 64R6-NEXT:    sll $2, $4, 0
; 64R6-NEXT:    mul $1, $2, $1
; 64R6-NEXT:    sll $2, $6, 0
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    addu $2, $2, $1
;
; 16-LABEL: madd4:
; 16:       # %bb.0: # %entry
; 16-NEXT:    mult $4, $5
; 16-NEXT:    mflo $2
; 16-NEXT:    addu $2, $6, $2
; 16-NEXT:    jrc $ra
entry:
  %mul = mul nsw i32 %a, %b
  %add = add nsw i32 %c, %mul

  ret i32 %add
}

define i64 @msub1(i32 %a, i32 %b, i32 %c) nounwind readnone {
; 32-LABEL: msub1:
; 32:       # %bb.0: # %entry
; 32-NEXT:    sra $1, $6, 31
; 32-NEXT:    mtlo $6
; 32-NEXT:    mthi $1
; 32-NEXT:    msub $5, $4
; 32-NEXT:    mfhi $2
; 32-NEXT:    jr $ra
; 32-NEXT:    mflo $3
;
; 32R6-LABEL: msub1:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    mul $1, $5, $4
; 32R6-NEXT:    sltu $2, $6, $1
; 32R6-NEXT:    muh $3, $5, $4
; 32R6-NEXT:    sra $4, $6, 31
; 32R6-NEXT:    subu $3, $4, $3
; 32R6-NEXT:    subu $2, $3, $2
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    subu $3, $6, $1
;
; DSP-LABEL: msub1:
; DSP:       # %bb.0: # %entry
; DSP-NEXT:    sra $1, $6, 31
; DSP-NEXT:    mtlo $6, $ac0
; DSP-NEXT:    mthi $1, $ac0
; DSP-NEXT:    msub $ac0, $5, $4
; DSP-NEXT:    mfhi $2, $ac0
; DSP-NEXT:    jr $ra
; DSP-NEXT:    mflo $3, $ac0
;
; 64-LABEL: msub1:
; 64:       # %bb.0: # %entry
; 64-NEXT:    sll $1, $4, 0
; 64-NEXT:    sll $2, $5, 0
; 64-NEXT:    dmult $2, $1
; 64-NEXT:    mflo $1
; 64-NEXT:    sll $2, $6, 0
; 64-NEXT:    jr $ra
; 64-NEXT:    dsubu $2, $2, $1
;
; 64R6-LABEL: msub1:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    sll $1, $4, 0
; 64R6-NEXT:    sll $2, $5, 0
; 64R6-NEXT:    dmul $1, $2, $1
; 64R6-NEXT:    sll $2, $6, 0
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    dsubu $2, $2, $1
;
; 16-LABEL: msub1:
; 16:       # %bb.0: # %entry
; 16-NEXT:    mult $5, $4
; 16-NEXT:    mflo $2
; 16-NEXT:    mfhi $4
; 16-NEXT:    subu $3, $6, $2
; 16-NEXT:    sltu $6, $2
; 16-NEXT:    move $2, $24
; 16-NEXT:    sra $5, $6, 31
; 16-NEXT:    subu $4, $5, $4
; 16-NEXT:    subu $2, $4, $2
; 16-NEXT:    jrc $ra
entry:
  %conv = sext i32 %c to i64
  %conv2 = sext i32 %a to i64
  %conv4 = sext i32 %b to i64
  %mul = mul nsw i64 %conv4, %conv2
  %sub = sub nsw i64 %conv, %mul
  ret i64 %sub
}

define i64 @msub2(i32 zeroext %a, i32 zeroext %b, i32 zeroext %c) nounwind readnone {
; 32-LABEL: msub2:
; 32:       # %bb.0: # %entry
; 32-NEXT:    addiu $1, $zero, 0
; 32-NEXT:    mtlo $6
; 32-NEXT:    mthi $1
; 32-NEXT:    msubu $5, $4
; 32-NEXT:    mfhi $2
; 32-NEXT:    jr $ra
; 32-NEXT:    mflo $3
;
; 32R6-LABEL: msub2:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    muhu $1, $5, $4
; 32R6-NEXT:    mul $3, $5, $4
; 32R6-NEXT:    sltu $2, $6, $3
; 32R6-NEXT:    addu $1, $1, $2
; 32R6-NEXT:    negu $2, $1
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    subu $3, $6, $3
;
; DSP-LABEL: msub2:
; DSP:       # %bb.0: # %entry
; DSP-NEXT:    addiu $1, $zero, 0
; DSP-NEXT:    mtlo $6, $ac0
; DSP-NEXT:    mthi $1, $ac0
; DSP-NEXT:    msubu $ac0, $5, $4
; DSP-NEXT:    mfhi $2, $ac0
; DSP-NEXT:    jr $ra
; DSP-NEXT:    mflo $3, $ac0
;
; 64-LABEL: msub2:
; 64:       # %bb.0: # %entry
; 64-NEXT:    dmult $5, $4
; 64-NEXT:    mflo $1
; 64-NEXT:    jr $ra
; 64-NEXT:    dsubu $2, $6, $1
;
; 64R6-LABEL: msub2:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    dmul $1, $5, $4
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    dsubu $2, $6, $1
;
; 16-LABEL: msub2:
; 16:       # %bb.0: # %entry
; 16-NEXT:    multu $5, $4
; 16-NEXT:    mflo $2
; 16-NEXT:    mfhi $3
; 16-NEXT:    sltu $6, $2
; 16-NEXT:    move $4, $24
; 16-NEXT:    addu $4, $3, $4
; 16-NEXT:    subu $3, $6, $2
; 16-NEXT:    neg $2, $4
; 16-NEXT:    jrc $ra
entry:
  %conv = zext i32 %c to i64
  %conv2 = zext i32 %a to i64
  %conv4 = zext i32 %b to i64
  %mul = mul nsw i64 %conv4, %conv2
  %sub = sub nsw i64 %conv, %mul
  ret i64 %sub
}

define i64 @msub3(i32 %a, i32 %b, i64 %c) nounwind readnone {
; 32-LABEL: msub3:
; 32:       # %bb.0: # %entry
; 32-NEXT:    mtlo $7
; 32-NEXT:    mthi $6
; 32-NEXT:    msub $5, $4
; 32-NEXT:    mfhi $2
; 32-NEXT:    jr $ra
; 32-NEXT:    mflo $3
;
; 32R6-LABEL: msub3:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    mul $1, $5, $4
; 32R6-NEXT:    sltu $2, $7, $1
; 32R6-NEXT:    muh $3, $5, $4
; 32R6-NEXT:    subu $3, $6, $3
; 32R6-NEXT:    subu $2, $3, $2
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    subu $3, $7, $1
;
; DSP-LABEL: msub3:
; DSP:       # %bb.0: # %entry
; DSP-NEXT:    mtlo $7, $ac0
; DSP-NEXT:    mthi $6, $ac0
; DSP-NEXT:    msub $ac0, $5, $4
; DSP-NEXT:    mfhi $2, $ac0
; DSP-NEXT:    jr $ra
; DSP-NEXT:    mflo $3, $ac0
;
; 64-LABEL: msub3:
; 64:       # %bb.0: # %entry
; 64-NEXT:    sll $1, $4, 0
; 64-NEXT:    sll $2, $5, 0
; 64-NEXT:    dmult $2, $1
; 64-NEXT:    mflo $1
; 64-NEXT:    jr $ra
; 64-NEXT:    dsubu $2, $6, $1
;
; 64R6-LABEL: msub3:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    sll $1, $4, 0
; 64R6-NEXT:    sll $2, $5, 0
; 64R6-NEXT:    dmul $1, $2, $1
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    dsubu $2, $6, $1
;
; 16-LABEL: msub3:
; 16:       # %bb.0: # %entry
; 16-NEXT:    mult $5, $4
; 16-NEXT:    mflo $2
; 16-NEXT:    mfhi $4
; 16-NEXT:    subu $3, $7, $2
; 16-NEXT:    sltu $7, $2
; 16-NEXT:    move $2, $24
; 16-NEXT:    subu $4, $6, $4
; 16-NEXT:    subu $2, $4, $2
; 16-NEXT:    jrc $ra
entry:
  %conv = sext i32 %a to i64
  %conv3 = sext i32 %b to i64
  %mul = mul nsw i64 %conv3, %conv
  %sub = sub nsw i64 %c, %mul
  ret i64 %sub
}

define i32 @msub4(i32 %a, i32 %b, i32 %c) {
; 32-LABEL: msub4:
; 32:       # %bb.0: # %entry
; 32-NEXT:    mul $1, $4, $5
; 32-NEXT:    jr $ra
; 32-NEXT:    subu $2, $6, $1
;
; 32R6-LABEL: msub4:
; 32R6:       # %bb.0: # %entry
; 32R6-NEXT:    mul $1, $4, $5
; 32R6-NEXT:    jr $ra
; 32R6-NEXT:    subu $2, $6, $1
;
; DSP-LABEL: msub4:
; DSP:       # %bb.0: # %entry
; DSP-NEXT:    mul $1, $4, $5
; DSP-NEXT:    jr $ra
; DSP-NEXT:    subu $2, $6, $1
;
; 64-LABEL: msub4:
; 64:       # %bb.0: # %entry
; 64-NEXT:    sll $1, $5, 0
; 64-NEXT:    sll $2, $4, 0
; 64-NEXT:    mul $1, $2, $1
; 64-NEXT:    sll $2, $6, 0
; 64-NEXT:    jr $ra
; 64-NEXT:    subu $2, $2, $1
;
; 64R6-LABEL: msub4:
; 64R6:       # %bb.0: # %entry
; 64R6-NEXT:    sll $1, $5, 0
; 64R6-NEXT:    sll $2, $4, 0
; 64R6-NEXT:    mul $1, $2, $1
; 64R6-NEXT:    sll $2, $6, 0
; 64R6-NEXT:    jr $ra
; 64R6-NEXT:    subu $2, $2, $1
;
; 16-LABEL: msub4:
; 16:       # %bb.0: # %entry
; 16-NEXT:    mult $4, $5
; 16-NEXT:    mflo $2
; 16-NEXT:    subu $2, $6, $2
; 16-NEXT:    jrc $ra
entry:
  %mul = mul nsw i32 %a, %b
  %sub = sub nsw i32 %c, %mul

  ret i32 %sub
}
