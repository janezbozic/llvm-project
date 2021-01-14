; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32I-FPELIM %s
; RUN: llc -mtriple=riscv32 -verify-machineinstrs -frame-pointer=all < %s \
; RUN:   | FileCheck -check-prefix=RV32I-WITHFP %s

; As well as calling convention details, we check that ra and fp are
; consistently stored to fp-4 and fp-8.

; Any tests that would have identical output for some combination of the ilp32*
; ABIs belong in calling-conv-*-common.ll. This file contains tests that will
; have different output across those ABIs. i.e. where some arguments would be
; passed according to the floating point ABI.

define i32 @callee_float_in_regs(i32 %a, float %b) nounwind {
; RV32I-FPELIM-LABEL: callee_float_in_regs:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    addi sp, sp, -16
; RV32I-FPELIM-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-FPELIM-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-FPELIM-NEXT:    mv s0, a0
; RV32I-FPELIM-NEXT:    mv a0, a1
; RV32I-FPELIM-NEXT:    call __fixsfsi@plt
; RV32I-FPELIM-NEXT:    add a0, s0, a0
; RV32I-FPELIM-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-FPELIM-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-FPELIM-NEXT:    addi sp, sp, 16
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: callee_float_in_regs:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    addi sp, sp, -16
; RV32I-WITHFP-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    sw s1, 4(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    addi s0, sp, 16
; RV32I-WITHFP-NEXT:    mv s1, a0
; RV32I-WITHFP-NEXT:    mv a0, a1
; RV32I-WITHFP-NEXT:    call __fixsfsi@plt
; RV32I-WITHFP-NEXT:    add a0, s1, a0
; RV32I-WITHFP-NEXT:    lw s1, 4(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    addi sp, sp, 16
; RV32I-WITHFP-NEXT:    ret
  %b_fptosi = fptosi float %b to i32
  %1 = add i32 %a, %b_fptosi
  ret i32 %1
}

define i32 @caller_float_in_regs() nounwind {
; RV32I-FPELIM-LABEL: caller_float_in_regs:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    addi sp, sp, -16
; RV32I-FPELIM-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-FPELIM-NEXT:    addi a0, zero, 1
; RV32I-FPELIM-NEXT:    lui a1, 262144
; RV32I-FPELIM-NEXT:    call callee_float_in_regs@plt
; RV32I-FPELIM-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-FPELIM-NEXT:    addi sp, sp, 16
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: caller_float_in_regs:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    addi sp, sp, -16
; RV32I-WITHFP-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    addi s0, sp, 16
; RV32I-WITHFP-NEXT:    addi a0, zero, 1
; RV32I-WITHFP-NEXT:    lui a1, 262144
; RV32I-WITHFP-NEXT:    call callee_float_in_regs@plt
; RV32I-WITHFP-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    addi sp, sp, 16
; RV32I-WITHFP-NEXT:    ret
  %1 = call i32 @callee_float_in_regs(i32 1, float 2.0)
  ret i32 %1
}

define i32 @callee_float_on_stack(i64 %a, i64 %b, i64 %c, i64 %d, float %e) nounwind {
; RV32I-FPELIM-LABEL: callee_float_on_stack:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    lw a0, 0(sp)
; RV32I-FPELIM-NEXT:    add a0, a6, a0
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: callee_float_on_stack:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    addi sp, sp, -16
; RV32I-WITHFP-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    addi s0, sp, 16
; RV32I-WITHFP-NEXT:    lw a0, 0(s0)
; RV32I-WITHFP-NEXT:    add a0, a6, a0
; RV32I-WITHFP-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    addi sp, sp, 16
; RV32I-WITHFP-NEXT:    ret
  %1 = trunc i64 %d to i32
  %2 = bitcast float %e to i32
  %3 = add i32 %1, %2
  ret i32 %3
}

define i32 @caller_float_on_stack() nounwind {
; RV32I-FPELIM-LABEL: caller_float_on_stack:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    addi sp, sp, -16
; RV32I-FPELIM-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-FPELIM-NEXT:    lui a1, 264704
; RV32I-FPELIM-NEXT:    addi a0, zero, 1
; RV32I-FPELIM-NEXT:    addi a2, zero, 2
; RV32I-FPELIM-NEXT:    addi a4, zero, 3
; RV32I-FPELIM-NEXT:    addi a6, zero, 4
; RV32I-FPELIM-NEXT:    sw a1, 0(sp)
; RV32I-FPELIM-NEXT:    mv a1, zero
; RV32I-FPELIM-NEXT:    mv a3, zero
; RV32I-FPELIM-NEXT:    mv a5, zero
; RV32I-FPELIM-NEXT:    mv a7, zero
; RV32I-FPELIM-NEXT:    call callee_float_on_stack@plt
; RV32I-FPELIM-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-FPELIM-NEXT:    addi sp, sp, 16
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: caller_float_on_stack:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    addi sp, sp, -16
; RV32I-WITHFP-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    addi s0, sp, 16
; RV32I-WITHFP-NEXT:    lui a1, 264704
; RV32I-WITHFP-NEXT:    addi a0, zero, 1
; RV32I-WITHFP-NEXT:    addi a2, zero, 2
; RV32I-WITHFP-NEXT:    addi a4, zero, 3
; RV32I-WITHFP-NEXT:    addi a6, zero, 4
; RV32I-WITHFP-NEXT:    sw a1, 0(sp)
; RV32I-WITHFP-NEXT:    mv a1, zero
; RV32I-WITHFP-NEXT:    mv a3, zero
; RV32I-WITHFP-NEXT:    mv a5, zero
; RV32I-WITHFP-NEXT:    mv a7, zero
; RV32I-WITHFP-NEXT:    call callee_float_on_stack@plt
; RV32I-WITHFP-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    addi sp, sp, 16
; RV32I-WITHFP-NEXT:    ret
  %1 = call i32 @callee_float_on_stack(i64 1, i64 2, i64 3, i64 4, float 5.0)
  ret i32 %1
}

define float @callee_tiny_scalar_ret() nounwind {
; RV32I-FPELIM-LABEL: callee_tiny_scalar_ret:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    lui a0, 260096
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: callee_tiny_scalar_ret:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    addi sp, sp, -16
; RV32I-WITHFP-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    addi s0, sp, 16
; RV32I-WITHFP-NEXT:    lui a0, 260096
; RV32I-WITHFP-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    addi sp, sp, 16
; RV32I-WITHFP-NEXT:    ret
  ret float 1.0
}

define i32 @caller_tiny_scalar_ret() nounwind {
; RV32I-FPELIM-LABEL: caller_tiny_scalar_ret:
; RV32I-FPELIM:       # %bb.0:
; RV32I-FPELIM-NEXT:    addi sp, sp, -16
; RV32I-FPELIM-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-FPELIM-NEXT:    call callee_tiny_scalar_ret@plt
; RV32I-FPELIM-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-FPELIM-NEXT:    addi sp, sp, 16
; RV32I-FPELIM-NEXT:    ret
;
; RV32I-WITHFP-LABEL: caller_tiny_scalar_ret:
; RV32I-WITHFP:       # %bb.0:
; RV32I-WITHFP-NEXT:    addi sp, sp, -16
; RV32I-WITHFP-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-WITHFP-NEXT:    addi s0, sp, 16
; RV32I-WITHFP-NEXT:    call callee_tiny_scalar_ret@plt
; RV32I-WITHFP-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-WITHFP-NEXT:    addi sp, sp, 16
; RV32I-WITHFP-NEXT:    ret
  %1 = call float @callee_tiny_scalar_ret()
  %2 = bitcast float %1 to i32
  ret i32 %2
}
