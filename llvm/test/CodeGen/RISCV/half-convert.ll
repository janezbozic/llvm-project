; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-zfh -verify-machineinstrs \
; RUN:   -target-abi ilp32f < %s | FileCheck -check-prefix=RV32IZFH %s
; RUN: llc -mtriple=riscv32 -mattr=+d,+experimental-zfh -verify-machineinstrs \
; RUN:   -target-abi ilp32d < %s | FileCheck -check-prefix=RV32IDZFH %s
; RUN: llc -mtriple=riscv64 -mattr=+experimental-zfh -verify-machineinstrs \
; RUN:   -target-abi lp64f < %s | FileCheck -check-prefix=RV64IZFH %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+experimental-zfh -verify-machineinstrs \
; RUN:   -target-abi lp64d < %s | FileCheck -check-prefix=RV64IDZFH %s

define i16 @fcvt_si_h(half %a) nounwind {
; RV32IZFH-LABEL: fcvt_si_h:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fcvt.w.h a0, fa0, rtz
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_si_h:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    fcvt.w.h a0, fa0, rtz
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_si_h:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.l.h a0, fa0, rtz
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_si_h:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fcvt.l.h a0, fa0, rtz
; RV64IDZFH-NEXT:    ret
  %1 = fptosi half %a to i16
  ret i16 %1
}

define i16 @fcvt_ui_h(half %a) nounwind {
; RV32IZFH-LABEL: fcvt_ui_h:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fcvt.wu.h a0, fa0, rtz
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_ui_h:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    fcvt.wu.h a0, fa0, rtz
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_ui_h:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.lu.h a0, fa0, rtz
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_ui_h:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fcvt.lu.h a0, fa0, rtz
; RV64IDZFH-NEXT:    ret
  %1 = fptoui half %a to i16
  ret i16 %1
}

define i32 @fcvt_w_h(half %a) nounwind {
; RV32IZFH-LABEL: fcvt_w_h:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fcvt.w.h a0, fa0, rtz
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_w_h:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    fcvt.w.h a0, fa0, rtz
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_w_h:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.l.h a0, fa0, rtz
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_w_h:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fcvt.l.h a0, fa0, rtz
; RV64IDZFH-NEXT:    ret
  %1 = fptosi half %a to i32
  ret i32 %1
}

define i32 @fcvt_wu_h(half %a) nounwind {
; RV32IZFH-LABEL: fcvt_wu_h:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fcvt.wu.h a0, fa0, rtz
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_wu_h:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    fcvt.wu.h a0, fa0, rtz
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_wu_h:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.lu.h a0, fa0, rtz
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_wu_h:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fcvt.lu.h a0, fa0, rtz
; RV64IDZFH-NEXT:    ret
  %1 = fptoui half %a to i32
  ret i32 %1
}

define i64 @fcvt_l_h(half %a) nounwind {
; RV32IZFH-LABEL: fcvt_l_h:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    call __fixhfdi@plt
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_l_h:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    addi sp, sp, -16
; RV32IDZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IDZFH-NEXT:    call __fixhfdi@plt
; RV32IDZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IDZFH-NEXT:    addi sp, sp, 16
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_l_h:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.l.h a0, fa0, rtz
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_l_h:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fcvt.l.h a0, fa0, rtz
; RV64IDZFH-NEXT:    ret
  %1 = fptosi half %a to i64
  ret i64 %1
}

define i64 @fcvt_lu_h(half %a) nounwind {
; RV32IZFH-LABEL: fcvt_lu_h:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    call __fixunshfdi@plt
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_lu_h:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    addi sp, sp, -16
; RV32IDZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IDZFH-NEXT:    call __fixunshfdi@plt
; RV32IDZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IDZFH-NEXT:    addi sp, sp, 16
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_lu_h:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.lu.h a0, fa0, rtz
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_lu_h:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fcvt.lu.h a0, fa0, rtz
; RV64IDZFH-NEXT:    ret
  %1 = fptoui half %a to i64
  ret i64 %1
}

define half @fcvt_h_si(i16 %a) nounwind {
; RV32IZFH-LABEL: fcvt_h_si:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    slli a0, a0, 16
; RV32IZFH-NEXT:    srai a0, a0, 16
; RV32IZFH-NEXT:    fcvt.h.w fa0, a0
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_h_si:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    slli a0, a0, 16
; RV32IDZFH-NEXT:    srai a0, a0, 16
; RV32IDZFH-NEXT:    fcvt.h.w fa0, a0
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_h_si:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    slli a0, a0, 48
; RV64IZFH-NEXT:    srai a0, a0, 48
; RV64IZFH-NEXT:    fcvt.h.l fa0, a0
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_h_si:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    slli a0, a0, 48
; RV64IDZFH-NEXT:    srai a0, a0, 48
; RV64IDZFH-NEXT:    fcvt.h.l fa0, a0
; RV64IDZFH-NEXT:    ret
  %1 = sitofp i16 %a to half
  ret half %1
}

define half @fcvt_h_ui(i16 %a) nounwind {
; RV32IZFH-LABEL: fcvt_h_ui:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    lui a1, 16
; RV32IZFH-NEXT:    addi a1, a1, -1
; RV32IZFH-NEXT:    and a0, a0, a1
; RV32IZFH-NEXT:    fcvt.h.wu fa0, a0
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_h_ui:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    lui a1, 16
; RV32IDZFH-NEXT:    addi a1, a1, -1
; RV32IDZFH-NEXT:    and a0, a0, a1
; RV32IDZFH-NEXT:    fcvt.h.wu fa0, a0
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_h_ui:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    lui a1, 16
; RV64IZFH-NEXT:    addiw a1, a1, -1
; RV64IZFH-NEXT:    and a0, a0, a1
; RV64IZFH-NEXT:    fcvt.h.lu fa0, a0
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_h_ui:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    lui a1, 16
; RV64IDZFH-NEXT:    addiw a1, a1, -1
; RV64IDZFH-NEXT:    and a0, a0, a1
; RV64IDZFH-NEXT:    fcvt.h.lu fa0, a0
; RV64IDZFH-NEXT:    ret
  %1 = uitofp i16 %a to half
  ret half %1
}

define half @fcvt_h_w(i32 %a) nounwind {
; RV32IZFH-LABEL: fcvt_h_w:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fcvt.h.w fa0, a0
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_h_w:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    fcvt.h.w fa0, a0
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_h_w:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.h.w fa0, a0
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_h_w:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fcvt.h.w fa0, a0
; RV64IDZFH-NEXT:    ret
  %1 = sitofp i32 %a to half
  ret half %1
}

define half @fcvt_h_wu(i32 %a) nounwind {
; RV32IZFH-LABEL: fcvt_h_wu:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fcvt.h.wu fa0, a0
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_h_wu:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    fcvt.h.wu fa0, a0
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_h_wu:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.h.wu fa0, a0
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_h_wu:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fcvt.h.wu fa0, a0
; RV64IDZFH-NEXT:    ret
  %1 = uitofp i32 %a to half
  ret half %1
}

define half @fcvt_h_l(i64 %a) nounwind {
; RV32IZFH-LABEL: fcvt_h_l:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    call __floatdihf@plt
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_h_l:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    addi sp, sp, -16
; RV32IDZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IDZFH-NEXT:    call __floatdihf@plt
; RV32IDZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IDZFH-NEXT:    addi sp, sp, 16
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_h_l:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.h.l fa0, a0
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_h_l:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fcvt.h.l fa0, a0
; RV64IDZFH-NEXT:    ret
  %1 = sitofp i64 %a to half
  ret half %1
}

define half @fcvt_h_lu(i64 %a) nounwind {
; RV32IZFH-LABEL: fcvt_h_lu:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    call __floatundihf@plt
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_h_lu:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    addi sp, sp, -16
; RV32IDZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IDZFH-NEXT:    call __floatundihf@plt
; RV32IDZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IDZFH-NEXT:    addi sp, sp, 16
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_h_lu:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.h.lu fa0, a0
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_h_lu:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fcvt.h.lu fa0, a0
; RV64IDZFH-NEXT:    ret
  %1 = uitofp i64 %a to half
  ret half %1
}

define half @fcvt_h_s(float %a) nounwind {
; RV32IZFH-LABEL: fcvt_h_s:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_h_s:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    fcvt.h.s fa0, fa0
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_h_s:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.h.s fa0, fa0
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_h_s:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fcvt.h.s fa0, fa0
; RV64IDZFH-NEXT:    ret
  %1 = fptrunc float %a to half
  ret half %1
}

define float @fcvt_s_h(half %a) nounwind {
; RV32IZFH-LABEL: fcvt_s_h:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_s_h:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_s_h:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_s_h:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fcvt.s.h fa0, fa0
; RV64IDZFH-NEXT:    ret
  %1 = fpext half %a to float
  ret float %1
}

define half @fcvt_h_d(double %a) nounwind {
; RV32IZFH-LABEL: fcvt_h_d:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    call __truncdfhf2@plt
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_h_d:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    fcvt.h.d fa0, fa0
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_h_d:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -16
; RV64IZFH-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    call __truncdfhf2@plt
; RV64IZFH-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 16
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_h_d:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fcvt.h.d fa0, fa0
; RV64IDZFH-NEXT:    ret
  %1 = fptrunc double %a to half
  ret half %1
}

define double @fcvt_d_h(half %a) nounwind {
; RV32IZFH-LABEL: fcvt_d_h:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    addi sp, sp, -16
; RV32IZFH-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV32IZFH-NEXT:    call __extendsfdf2@plt
; RV32IZFH-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFH-NEXT:    addi sp, sp, 16
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: fcvt_d_h:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    fcvt.d.h fa0, fa0
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: fcvt_d_h:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    addi sp, sp, -16
; RV64IZFH-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IZFH-NEXT:    fcvt.s.h fa0, fa0
; RV64IZFH-NEXT:    call __extendsfdf2@plt
; RV64IZFH-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IZFH-NEXT:    addi sp, sp, 16
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: fcvt_d_h:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fcvt.d.h fa0, fa0
; RV64IDZFH-NEXT:    ret
  %1 = fpext half %a to double
  ret double %1
}

define half @bitcast_h_i16(i16 %a) nounwind {
; RV32IZFH-LABEL: bitcast_h_i16:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fmv.h.x fa0, a0
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: bitcast_h_i16:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    fmv.h.x fa0, a0
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: bitcast_h_i16:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fmv.h.x fa0, a0
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: bitcast_h_i16:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fmv.h.x fa0, a0
; RV64IDZFH-NEXT:    ret
  %1 = bitcast i16 %a to half
  ret half %1
}

define i16 @bitcast_i16_h(half %a) nounwind {
; RV32IZFH-LABEL: bitcast_i16_h:
; RV32IZFH:       # %bb.0:
; RV32IZFH-NEXT:    fmv.x.h a0, fa0
; RV32IZFH-NEXT:    ret
;
; RV32IDZFH-LABEL: bitcast_i16_h:
; RV32IDZFH:       # %bb.0:
; RV32IDZFH-NEXT:    fmv.x.h a0, fa0
; RV32IDZFH-NEXT:    ret
;
; RV64IZFH-LABEL: bitcast_i16_h:
; RV64IZFH:       # %bb.0:
; RV64IZFH-NEXT:    fmv.x.h a0, fa0
; RV64IZFH-NEXT:    ret
;
; RV64IDZFH-LABEL: bitcast_i16_h:
; RV64IDZFH:       # %bb.0:
; RV64IDZFH-NEXT:    fmv.x.h a0, fa0
; RV64IDZFH-NEXT:    ret
  %1 = bitcast half %a to i16
  ret i16 %1
}
