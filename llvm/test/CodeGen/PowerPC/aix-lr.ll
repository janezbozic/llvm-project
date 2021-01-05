; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple powerpc-ibm-aix-xcoff < %s | \
; RUN: FileCheck --check-prefix=32BIT %s

; RUN: llc -verify-machineinstrs -mtriple powerpc64-ibm-aix-xcoff < %s | \
; RUN: FileCheck --check-prefix=64BIT %s

define void @bar() {
; 32BIT-LABEL: bar:
; 32BIT:       # %bb.0: # %entry
; 32BIT-NEXT:    mflr 0
; 32BIT-NEXT:    stw 0, 8(1)
; 32BIT-NEXT:    stwu 1, -64(1)
; 32BIT-NEXT:    bl .foo[PR]
; 32BIT-NEXT:    nop
; 32BIT-NEXT:    addi 1, 1, 64
; 32BIT-NEXT:    lwz 0, 8(1)
; 32BIT-NEXT:    mtlr 0
; 32BIT-NEXT:    blr
;
; 64BIT-LABEL: bar:
; 64BIT:       # %bb.0: # %entry
; 64BIT-NEXT:    mflr 0
; 64BIT-NEXT:    std 0, 16(1)
; 64BIT-NEXT:    stdu 1, -112(1)
; 64BIT-NEXT:    bl .foo[PR]
; 64BIT-NEXT:    nop
; 64BIT-NEXT:    addi 1, 1, 112
; 64BIT-NEXT:    ld 0, 16(1)
; 64BIT-NEXT:    mtlr 0
; 64BIT-NEXT:    blr
entry:



  call void bitcast (void (...)* @foo to void ()*)()
  ret void
}

declare void @foo(...)
