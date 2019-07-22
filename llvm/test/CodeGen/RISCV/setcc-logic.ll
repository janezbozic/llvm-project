; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64I

define i1 @and_icmp_eq(i32 %a, i32 %b, i32 %c, i32 %d) nounwind {
; RV32I-LABEL: and_icmp_eq:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xor a2, a2, a3
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: and_icmp_eq:
; RV64I:       # %bb.0:
; RV64I-NEXT:    xor a2, a2, a3
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    or a0, a0, a2
; RV64I-NEXT:    slli a0, a0, 32
; RV64I-NEXT:    srli a0, a0, 32
; RV64I-NEXT:    seqz a0, a0
; RV64I-NEXT:    ret
  %cmp1 = icmp eq i32 %a, %b
  %cmp2 = icmp eq i32 %c, %d
  %and = and i1 %cmp1, %cmp2
  ret i1 %and
}

define i1 @or_icmp_ne(i32 %a, i32 %b, i32 %c, i32 %d) nounwind {
; RV32I-LABEL: or_icmp_ne:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xor a2, a2, a3
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: or_icmp_ne:
; RV64I:       # %bb.0:
; RV64I-NEXT:    xor a2, a2, a3
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    or a0, a0, a2
; RV64I-NEXT:    slli a0, a0, 32
; RV64I-NEXT:    srli a0, a0, 32
; RV64I-NEXT:    snez a0, a0
; RV64I-NEXT:    ret
  %cmp1 = icmp ne i32 %a, %b
  %cmp2 = icmp ne i32 %c, %d
  %or = or i1 %cmp1, %cmp2
  ret i1 %or
}

define i1 @or_icmps_const_1bit_diff(i64 %x) nounwind {
; RV32I-LABEL: or_icmps_const_1bit_diff:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a2, a0, -13
; RV32I-NEXT:    sltu a0, a2, a0
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    addi a0, a0, -1
; RV32I-NEXT:    andi a1, a2, -5
; RV32I-NEXT:    or a0, a1, a0
; RV32I-NEXT:    seqz a0, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: or_icmps_const_1bit_diff:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a0, a0, -13
; RV64I-NEXT:    andi a0, a0, -5
; RV64I-NEXT:    seqz a0, a0
; RV64I-NEXT:    ret
  %a = icmp eq i64 %x, 17
  %b = icmp eq i64 %x, 13
  %r = or i1 %a, %b
  ret i1 %r
}

define i1 @and_icmps_const_1bit_diff(i32 %x) nounwind {
; RV32I-LABEL: and_icmps_const_1bit_diff:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a0, a0, -44
; RV32I-NEXT:    andi a0, a0, -17
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: and_icmps_const_1bit_diff:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a0, a0, -44
; RV64I-NEXT:    addi a1, zero, 1
; RV64I-NEXT:    slli a1, a1, 32
; RV64I-NEXT:    addi a1, a1, -17
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    snez a0, a0
; RV64I-NEXT:    ret
  %a = icmp ne i32 %x, 44
  %b = icmp ne i32 %x, 60
  %r = and i1 %a, %b
  ret i1 %r
}

define i1 @and_icmps_const_not1bit_diff(i32 %x) nounwind {
; RV32I-LABEL: and_icmps_const_not1bit_diff:
; RV32I:       # %bb.0:
; RV32I-NEXT:    xori a1, a0, 92
; RV32I-NEXT:    snez a1, a1
; RV32I-NEXT:    xori a0, a0, 44
; RV32I-NEXT:    snez a0, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: and_icmps_const_not1bit_diff:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slli a0, a0, 32
; RV64I-NEXT:    srli a0, a0, 32
; RV64I-NEXT:    xori a1, a0, 92
; RV64I-NEXT:    snez a1, a1
; RV64I-NEXT:    xori a0, a0, 44
; RV64I-NEXT:    snez a0, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    ret
  %a = icmp ne i32 %x, 44
  %b = icmp ne i32 %x, 92
  %r = and i1 %a, %b
  ret i1 %r
}
