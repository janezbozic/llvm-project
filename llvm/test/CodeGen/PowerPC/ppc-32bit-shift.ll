; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc \
; RUN:     -mcpu=pwr9 < %s | FileCheck %s --check-prefix=32BIT

; RUN: llc -verify-machineinstrs -mtriple=powerpc64 \
; RUN:     -mcpu=pwr9 < %s | FileCheck %s --check-prefix=64BIT

define dso_local void @foo(i32 %inta, i64* %long_intb) {
; 32BIT-LABEL: foo:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    srawi 5, 3, 31
; 32BIT-NEXT:    rotlwi 6, 3, 8
; 32BIT-NEXT:    slwi 3, 3, 8
; 32BIT-NEXT:    rlwimi 6, 5, 8, 0, 23
; 32BIT-NEXT:    stw 3, 4(4)
; 32BIT-NEXT:    stw 6, 0(4)
; 32BIT-NEXT:    blr
;
; 64BIT-LABEL: foo:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    extswsli 3, 3, 8
; 64BIT-NEXT:    std 3, 0(4)
; 64BIT-NEXT:    blr
  entry:
    %conv = sext i32 %inta to i64
    %shl = shl nsw i64 %conv, 8
    store i64 %shl, i64* %long_intb, align 8
    ret void
}
