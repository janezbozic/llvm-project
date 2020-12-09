; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+f -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32F %s
; RUN: llc -mtriple=riscv32 -mattr=+f,+d -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32FD %s
; RUN: llc -mtriple=riscv64 -mattr=+f -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64F %s
; RUN: llc -mtriple=riscv64 -mattr=+f,+d -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64FD %s

; These functions perform extra work to ensure that `%a3` starts in a
; floating-point register, if the machine has them, and the result of
; the bitwise operation is then needed in a floating-point register.
; This should mean the optimisations will fire even if you're using the
; soft-float ABI on a machine with hardware floating-point support.

define float @bitcast_and(float %a1, float %a2) nounwind {
; RV32F-LABEL: bitcast_and:
; RV32F:       # %bb.0:
; RV32F-NEXT:    fmv.w.x ft0, a1
; RV32F-NEXT:    fmv.w.x ft1, a0
; RV32F-NEXT:    fadd.s ft0, ft1, ft0
; RV32F-NEXT:    fabs.s ft0, ft0
; RV32F-NEXT:    fadd.s ft0, ft1, ft0
; RV32F-NEXT:    fmv.x.w a0, ft0
; RV32F-NEXT:    ret
;
; RV32FD-LABEL: bitcast_and:
; RV32FD:       # %bb.0:
; RV32FD-NEXT:    fmv.w.x ft0, a1
; RV32FD-NEXT:    fmv.w.x ft1, a0
; RV32FD-NEXT:    fadd.s ft0, ft1, ft0
; RV32FD-NEXT:    fabs.s ft0, ft0
; RV32FD-NEXT:    fadd.s ft0, ft1, ft0
; RV32FD-NEXT:    fmv.x.w a0, ft0
; RV32FD-NEXT:    ret
;
; RV64F-LABEL: bitcast_and:
; RV64F:       # %bb.0:
; RV64F-NEXT:    fmv.w.x ft0, a1
; RV64F-NEXT:    fmv.w.x ft1, a0
; RV64F-NEXT:    fadd.s ft0, ft1, ft0
; RV64F-NEXT:    fabs.s ft0, ft0
; RV64F-NEXT:    fadd.s ft0, ft1, ft0
; RV64F-NEXT:    fmv.x.w a0, ft0
; RV64F-NEXT:    ret
;
; RV64FD-LABEL: bitcast_and:
; RV64FD:       # %bb.0:
; RV64FD-NEXT:    fmv.w.x ft0, a1
; RV64FD-NEXT:    fmv.w.x ft1, a0
; RV64FD-NEXT:    fadd.s ft0, ft1, ft0
; RV64FD-NEXT:    fabs.s ft0, ft0
; RV64FD-NEXT:    fadd.s ft0, ft1, ft0
; RV64FD-NEXT:    fmv.x.w a0, ft0
; RV64FD-NEXT:    ret
  %a3 = fadd float %a1, %a2
  %bc1 = bitcast float %a3 to i32
  %and = and i32 %bc1, 2147483647
  %bc2 = bitcast i32 %and to float
  %a4 = fadd float %a1, %bc2
  ret float %a4
}

define double @bitcast_double_and(double %a1, double %a2) nounwind {
; RV32F-LABEL: bitcast_double_and:
; RV32F:       # %bb.0:
; RV32F-NEXT:    addi sp, sp, -16
; RV32F-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32F-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32F-NEXT:    sw s1, 4(sp) # 4-byte Folded Spill
; RV32F-NEXT:    mv s0, a1
; RV32F-NEXT:    mv s1, a0
; RV32F-NEXT:    call __adddf3@plt
; RV32F-NEXT:    mv a2, a0
; RV32F-NEXT:    lui a0, 524288
; RV32F-NEXT:    addi a0, a0, -1
; RV32F-NEXT:    and a3, a1, a0
; RV32F-NEXT:    mv a0, s1
; RV32F-NEXT:    mv a1, s0
; RV32F-NEXT:    call __adddf3@plt
; RV32F-NEXT:    lw s1, 4(sp) # 4-byte Folded Reload
; RV32F-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32F-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32F-NEXT:    addi sp, sp, 16
; RV32F-NEXT:    ret
;
; RV32FD-LABEL: bitcast_double_and:
; RV32FD:       # %bb.0:
; RV32FD-NEXT:    addi sp, sp, -16
; RV32FD-NEXT:    sw a2, 8(sp)
; RV32FD-NEXT:    sw a3, 12(sp)
; RV32FD-NEXT:    fld ft0, 8(sp)
; RV32FD-NEXT:    sw a0, 8(sp)
; RV32FD-NEXT:    sw a1, 12(sp)
; RV32FD-NEXT:    fld ft1, 8(sp)
; RV32FD-NEXT:    fadd.d ft0, ft1, ft0
; RV32FD-NEXT:    fabs.d ft0, ft0
; RV32FD-NEXT:    fadd.d ft0, ft1, ft0
; RV32FD-NEXT:    fsd ft0, 8(sp)
; RV32FD-NEXT:    lw a0, 8(sp)
; RV32FD-NEXT:    lw a1, 12(sp)
; RV32FD-NEXT:    addi sp, sp, 16
; RV32FD-NEXT:    ret
;
; RV64F-LABEL: bitcast_double_and:
; RV64F:       # %bb.0:
; RV64F-NEXT:    addi sp, sp, -16
; RV64F-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64F-NEXT:    sd s0, 0(sp) # 8-byte Folded Spill
; RV64F-NEXT:    mv s0, a0
; RV64F-NEXT:    call __adddf3@plt
; RV64F-NEXT:    addi a1, zero, -1
; RV64F-NEXT:    slli a1, a1, 63
; RV64F-NEXT:    addi a1, a1, -1
; RV64F-NEXT:    and a1, a0, a1
; RV64F-NEXT:    mv a0, s0
; RV64F-NEXT:    call __adddf3@plt
; RV64F-NEXT:    ld s0, 0(sp) # 8-byte Folded Reload
; RV64F-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64F-NEXT:    addi sp, sp, 16
; RV64F-NEXT:    ret
;
; RV64FD-LABEL: bitcast_double_and:
; RV64FD:       # %bb.0:
; RV64FD-NEXT:    fmv.d.x ft0, a1
; RV64FD-NEXT:    fmv.d.x ft1, a0
; RV64FD-NEXT:    fadd.d ft0, ft1, ft0
; RV64FD-NEXT:    fabs.d ft0, ft0
; RV64FD-NEXT:    fadd.d ft0, ft1, ft0
; RV64FD-NEXT:    fmv.x.d a0, ft0
; RV64FD-NEXT:    ret
  %a3 = fadd double %a1, %a2
  %bc1 = bitcast double %a3 to i64
  %and = and i64 %bc1, 9223372036854775807
  %bc2 = bitcast i64 %and to double
  %a4 = fadd double %a1, %bc2
  ret double %a4
}


define float @bitcast_xor(float %a1, float %a2) nounwind {
; RV32F-LABEL: bitcast_xor:
; RV32F:       # %bb.0:
; RV32F-NEXT:    fmv.w.x ft0, a1
; RV32F-NEXT:    fmv.w.x ft1, a0
; RV32F-NEXT:    fmul.s ft0, ft1, ft0
; RV32F-NEXT:    fneg.s ft0, ft0
; RV32F-NEXT:    fmul.s ft0, ft1, ft0
; RV32F-NEXT:    fmv.x.w a0, ft0
; RV32F-NEXT:    ret
;
; RV32FD-LABEL: bitcast_xor:
; RV32FD:       # %bb.0:
; RV32FD-NEXT:    fmv.w.x ft0, a1
; RV32FD-NEXT:    fmv.w.x ft1, a0
; RV32FD-NEXT:    fmul.s ft0, ft1, ft0
; RV32FD-NEXT:    fneg.s ft0, ft0
; RV32FD-NEXT:    fmul.s ft0, ft1, ft0
; RV32FD-NEXT:    fmv.x.w a0, ft0
; RV32FD-NEXT:    ret
;
; RV64F-LABEL: bitcast_xor:
; RV64F:       # %bb.0:
; RV64F-NEXT:    fmv.w.x ft0, a1
; RV64F-NEXT:    fmv.w.x ft1, a0
; RV64F-NEXT:    fmul.s ft0, ft1, ft0
; RV64F-NEXT:    fneg.s ft0, ft0
; RV64F-NEXT:    fmul.s ft0, ft1, ft0
; RV64F-NEXT:    fmv.x.w a0, ft0
; RV64F-NEXT:    ret
;
; RV64FD-LABEL: bitcast_xor:
; RV64FD:       # %bb.0:
; RV64FD-NEXT:    fmv.w.x ft0, a1
; RV64FD-NEXT:    fmv.w.x ft1, a0
; RV64FD-NEXT:    fmul.s ft0, ft1, ft0
; RV64FD-NEXT:    fneg.s ft0, ft0
; RV64FD-NEXT:    fmul.s ft0, ft1, ft0
; RV64FD-NEXT:    fmv.x.w a0, ft0
; RV64FD-NEXT:    ret
  %a3 = fmul float %a1, %a2
  %bc1 = bitcast float %a3 to i32
  %and = xor i32 %bc1, 2147483648
  %bc2 = bitcast i32 %and to float
  %a4 = fmul float %a1, %bc2
  ret float %a4
}

define double @bitcast_double_xor(double %a1, double %a2) nounwind {
; RV32F-LABEL: bitcast_double_xor:
; RV32F:       # %bb.0:
; RV32F-NEXT:    addi sp, sp, -16
; RV32F-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32F-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32F-NEXT:    sw s1, 4(sp) # 4-byte Folded Spill
; RV32F-NEXT:    mv s0, a1
; RV32F-NEXT:    mv s1, a0
; RV32F-NEXT:    call __muldf3@plt
; RV32F-NEXT:    mv a2, a0
; RV32F-NEXT:    lui a0, 524288
; RV32F-NEXT:    xor a3, a1, a0
; RV32F-NEXT:    mv a0, s1
; RV32F-NEXT:    mv a1, s0
; RV32F-NEXT:    call __muldf3@plt
; RV32F-NEXT:    lw s1, 4(sp) # 4-byte Folded Reload
; RV32F-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32F-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32F-NEXT:    addi sp, sp, 16
; RV32F-NEXT:    ret
;
; RV32FD-LABEL: bitcast_double_xor:
; RV32FD:       # %bb.0:
; RV32FD-NEXT:    addi sp, sp, -16
; RV32FD-NEXT:    sw a2, 8(sp)
; RV32FD-NEXT:    sw a3, 12(sp)
; RV32FD-NEXT:    fld ft0, 8(sp)
; RV32FD-NEXT:    sw a0, 8(sp)
; RV32FD-NEXT:    sw a1, 12(sp)
; RV32FD-NEXT:    fld ft1, 8(sp)
; RV32FD-NEXT:    fmul.d ft0, ft1, ft0
; RV32FD-NEXT:    fneg.d ft0, ft0
; RV32FD-NEXT:    fmul.d ft0, ft1, ft0
; RV32FD-NEXT:    fsd ft0, 8(sp)
; RV32FD-NEXT:    lw a0, 8(sp)
; RV32FD-NEXT:    lw a1, 12(sp)
; RV32FD-NEXT:    addi sp, sp, 16
; RV32FD-NEXT:    ret
;
; RV64F-LABEL: bitcast_double_xor:
; RV64F:       # %bb.0:
; RV64F-NEXT:    addi sp, sp, -16
; RV64F-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64F-NEXT:    sd s0, 0(sp) # 8-byte Folded Spill
; RV64F-NEXT:    mv s0, a0
; RV64F-NEXT:    call __muldf3@plt
; RV64F-NEXT:    addi a1, zero, -1
; RV64F-NEXT:    slli a1, a1, 63
; RV64F-NEXT:    xor a1, a0, a1
; RV64F-NEXT:    mv a0, s0
; RV64F-NEXT:    call __muldf3@plt
; RV64F-NEXT:    ld s0, 0(sp) # 8-byte Folded Reload
; RV64F-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64F-NEXT:    addi sp, sp, 16
; RV64F-NEXT:    ret
;
; RV64FD-LABEL: bitcast_double_xor:
; RV64FD:       # %bb.0:
; RV64FD-NEXT:    fmv.d.x ft0, a1
; RV64FD-NEXT:    fmv.d.x ft1, a0
; RV64FD-NEXT:    fmul.d ft0, ft1, ft0
; RV64FD-NEXT:    fneg.d ft0, ft0
; RV64FD-NEXT:    fmul.d ft0, ft1, ft0
; RV64FD-NEXT:    fmv.x.d a0, ft0
; RV64FD-NEXT:    ret
  %a3 = fmul double %a1, %a2
  %bc1 = bitcast double %a3 to i64
  %and = xor i64 %bc1, 9223372036854775808
  %bc2 = bitcast i64 %and to double
  %a4 = fmul double %a1, %bc2
  ret double %a4
}

define float @bitcast_or(float %a1, float %a2) nounwind {
; RV32F-LABEL: bitcast_or:
; RV32F:       # %bb.0:
; RV32F-NEXT:    fmv.w.x ft0, a1
; RV32F-NEXT:    fmv.w.x ft1, a0
; RV32F-NEXT:    fmul.s ft0, ft1, ft0
; RV32F-NEXT:    fabs.s ft0, ft0
; RV32F-NEXT:    fneg.s ft0, ft0
; RV32F-NEXT:    fmul.s ft0, ft1, ft0
; RV32F-NEXT:    fmv.x.w a0, ft0
; RV32F-NEXT:    ret
;
; RV32FD-LABEL: bitcast_or:
; RV32FD:       # %bb.0:
; RV32FD-NEXT:    fmv.w.x ft0, a1
; RV32FD-NEXT:    fmv.w.x ft1, a0
; RV32FD-NEXT:    fmul.s ft0, ft1, ft0
; RV32FD-NEXT:    fabs.s ft0, ft0
; RV32FD-NEXT:    fneg.s ft0, ft0
; RV32FD-NEXT:    fmul.s ft0, ft1, ft0
; RV32FD-NEXT:    fmv.x.w a0, ft0
; RV32FD-NEXT:    ret
;
; RV64F-LABEL: bitcast_or:
; RV64F:       # %bb.0:
; RV64F-NEXT:    fmv.w.x ft0, a1
; RV64F-NEXT:    fmv.w.x ft1, a0
; RV64F-NEXT:    fmul.s ft0, ft1, ft0
; RV64F-NEXT:    fabs.s ft0, ft0
; RV64F-NEXT:    fneg.s ft0, ft0
; RV64F-NEXT:    fmul.s ft0, ft1, ft0
; RV64F-NEXT:    fmv.x.w a0, ft0
; RV64F-NEXT:    ret
;
; RV64FD-LABEL: bitcast_or:
; RV64FD:       # %bb.0:
; RV64FD-NEXT:    fmv.w.x ft0, a1
; RV64FD-NEXT:    fmv.w.x ft1, a0
; RV64FD-NEXT:    fmul.s ft0, ft1, ft0
; RV64FD-NEXT:    fabs.s ft0, ft0
; RV64FD-NEXT:    fneg.s ft0, ft0
; RV64FD-NEXT:    fmul.s ft0, ft1, ft0
; RV64FD-NEXT:    fmv.x.w a0, ft0
; RV64FD-NEXT:    ret
  %a3 = fmul float %a1, %a2
  %bc1 = bitcast float %a3 to i32
  %and = or i32 %bc1, 2147483648
  %bc2 = bitcast i32 %and to float
  %a4 = fmul float %a1, %bc2
  ret float %a4
}

define double @bitcast_double_or(double %a1, double %a2) nounwind {
; RV32F-LABEL: bitcast_double_or:
; RV32F:       # %bb.0:
; RV32F-NEXT:    addi sp, sp, -16
; RV32F-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32F-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32F-NEXT:    sw s1, 4(sp) # 4-byte Folded Spill
; RV32F-NEXT:    mv s0, a1
; RV32F-NEXT:    mv s1, a0
; RV32F-NEXT:    call __muldf3@plt
; RV32F-NEXT:    mv a2, a0
; RV32F-NEXT:    lui a0, 524288
; RV32F-NEXT:    or a3, a1, a0
; RV32F-NEXT:    mv a0, s1
; RV32F-NEXT:    mv a1, s0
; RV32F-NEXT:    call __muldf3@plt
; RV32F-NEXT:    lw s1, 4(sp) # 4-byte Folded Reload
; RV32F-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32F-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32F-NEXT:    addi sp, sp, 16
; RV32F-NEXT:    ret
;
; RV32FD-LABEL: bitcast_double_or:
; RV32FD:       # %bb.0:
; RV32FD-NEXT:    addi sp, sp, -16
; RV32FD-NEXT:    sw a2, 8(sp)
; RV32FD-NEXT:    sw a3, 12(sp)
; RV32FD-NEXT:    fld ft0, 8(sp)
; RV32FD-NEXT:    sw a0, 8(sp)
; RV32FD-NEXT:    sw a1, 12(sp)
; RV32FD-NEXT:    fld ft1, 8(sp)
; RV32FD-NEXT:    fmul.d ft0, ft1, ft0
; RV32FD-NEXT:    fabs.d ft0, ft0
; RV32FD-NEXT:    fneg.d ft0, ft0
; RV32FD-NEXT:    fmul.d ft0, ft1, ft0
; RV32FD-NEXT:    fsd ft0, 8(sp)
; RV32FD-NEXT:    lw a0, 8(sp)
; RV32FD-NEXT:    lw a1, 12(sp)
; RV32FD-NEXT:    addi sp, sp, 16
; RV32FD-NEXT:    ret
;
; RV64F-LABEL: bitcast_double_or:
; RV64F:       # %bb.0:
; RV64F-NEXT:    addi sp, sp, -16
; RV64F-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64F-NEXT:    sd s0, 0(sp) # 8-byte Folded Spill
; RV64F-NEXT:    mv s0, a0
; RV64F-NEXT:    call __muldf3@plt
; RV64F-NEXT:    addi a1, zero, -1
; RV64F-NEXT:    slli a1, a1, 63
; RV64F-NEXT:    or a1, a0, a1
; RV64F-NEXT:    mv a0, s0
; RV64F-NEXT:    call __muldf3@plt
; RV64F-NEXT:    ld s0, 0(sp) # 8-byte Folded Reload
; RV64F-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64F-NEXT:    addi sp, sp, 16
; RV64F-NEXT:    ret
;
; RV64FD-LABEL: bitcast_double_or:
; RV64FD:       # %bb.0:
; RV64FD-NEXT:    fmv.d.x ft0, a1
; RV64FD-NEXT:    fmv.d.x ft1, a0
; RV64FD-NEXT:    fmul.d ft0, ft1, ft0
; RV64FD-NEXT:    fabs.d ft0, ft0
; RV64FD-NEXT:    fneg.d ft0, ft0
; RV64FD-NEXT:    fmul.d ft0, ft1, ft0
; RV64FD-NEXT:    fmv.x.d a0, ft0
; RV64FD-NEXT:    ret
  %a3 = fmul double %a1, %a2
  %bc1 = bitcast double %a3 to i64
  %and = or i64 %bc1, 9223372036854775808
  %bc2 = bitcast i64 %and to double
  %a4 = fmul double %a1, %bc2
  ret double %a4
}
