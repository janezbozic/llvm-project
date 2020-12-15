; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=ve -exception-model=sjlj < %s | FileCheck %s
; RUN: llc -mtriple=ve -exception-model=sjlj -relocation-model=pic < %s | \
; RUN:     FileCheck --check-prefix=PIC %s

@SomeGlobal = external dso_local global i8

define dso_local i32 @foo(i32 %arg) local_unnamed_addr personality i8* bitcast (i32 (...)* @__gxx_personality_sj0 to i8*) {
; CHECK-LABEL: foo:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    st %s9, (, %s11)
; CHECK-NEXT:    st %s10, 8(, %s11)
; CHECK-NEXT:    or %s9, 0, %s11
; CHECK-NEXT:    lea %s11, -352(, %s11)
; CHECK-NEXT:    brge.l %s11, %s8, .LBB0_8
; CHECK-NEXT:  # %bb.7: # %entry
; CHECK-NEXT:    ld %s61, 24(, %s14)
; CHECK-NEXT:    or %s62, 0, %s0
; CHECK-NEXT:    lea %s63, 315
; CHECK-NEXT:    shm.l %s63, (%s61)
; CHECK-NEXT:    shm.l %s8, 8(%s61)
; CHECK-NEXT:    shm.l %s11, 16(%s61)
; CHECK-NEXT:    monc
; CHECK-NEXT:    or %s0, 0, %s62
; CHECK-NEXT:  .LBB0_8: # %entry
; CHECK-NEXT:    st %s18, 48(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s19, 56(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s20, 64(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s21, 72(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s22, 80(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s23, 88(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s24, 96(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s25, 104(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s26, 112(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s27, 120(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s28, 128(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s29, 136(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s30, 144(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s31, 152(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s32, 160(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    st %s33, 168(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    lea %s0, __gxx_personality_sj0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, __gxx_personality_sj0@hi(, %s0)
; CHECK-NEXT:    st %s0, -56(, %s9)
; CHECK-NEXT:    lea %s0, GCC_except_table0@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, GCC_except_table0@hi(, %s0)
; CHECK-NEXT:    st %s0, -48(, %s9)
; CHECK-NEXT:    st %s9, -40(, %s9)
; CHECK-NEXT:    st %s11, -24(, %s9)
; CHECK-NEXT:    lea %s0, .LBB0_3@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, .LBB0_3@hi(, %s0)
; CHECK-NEXT:    st %s0, -32(, %s9)
; CHECK-NEXT:    or %s0, 1, (0)1
; CHECK-NEXT:    st %s0, -96(, %s9)
; CHECK-NEXT:    lea %s0, _Unwind_SjLj_Register@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, _Unwind_SjLj_Register@hi(, %s0)
; CHECK-NEXT:    lea %s0, -104(, %s9)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:  .Ltmp0:
; CHECK-NEXT:    lea %s0, errorbar@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, errorbar@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:  .Ltmp1:
; CHECK-NEXT:  # %bb.1: # %exit
; CHECK-NEXT:    lea %s0, _Unwind_SjLj_Unregister@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, _Unwind_SjLj_Unregister@hi(, %s0)
; CHECK-NEXT:    lea %s0, -104(, %s9)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:  .LBB0_2: # %exit
; CHECK-NEXT:    ld %s33, 168(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s32, 160(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s31, 152(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s30, 144(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s29, 136(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s28, 128(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s27, 120(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s26, 112(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s25, 104(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s24, 96(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s23, 88(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s22, 80(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s21, 72(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s20, 64(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s19, 56(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    ld %s18, 48(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK-NEXT:    ld %s10, 8(, %s11)
; CHECK-NEXT:    ld %s9, (, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
; CHECK-NEXT:  .LBB0_3:
; CHECK-NEXT:    ldl.zx %s0, -96(, %s9)
; CHECK-NEXT:    brgt.l 1, %s0, .LBB0_4
; CHECK-NEXT:  # %bb.5:
; CHECK-NEXT:    lea %s0, abort@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, abort@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s0)
; CHECK-NEXT:  .LBB0_4:
; CHECK-NEXT:    lea %s1, .LJTI0_0@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, .LJTI0_0@hi(, %s1)
; CHECK-NEXT:    sll %s0, %s0, 3
; CHECK-NEXT:    ld %s0, (%s0, %s1)
; CHECK-NEXT:    b.l.t (, %s0)
; CHECK-NEXT:  .LBB0_6: # %handle
; CHECK-NEXT:  .Ltmp2:
; CHECK-NEXT:    ld %s0, -88(, %s9)
; CHECK-NEXT:    ld %s0, -80(, %s9)
; CHECK-NEXT:    lea %s0, _Unwind_SjLj_Unregister@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, _Unwind_SjLj_Unregister@hi(, %s0)
; CHECK-NEXT:    lea %s0, -104(, %s9)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s0, 1, (0)1
; CHECK-NEXT:    br.l.t .LBB0_2
;
; PIC-LABEL: foo:
; PIC:       # %bb.0: # %entry
; PIC-NEXT:    st %s9, (, %s11)
; PIC-NEXT:    st %s10, 8(, %s11)
; PIC-NEXT:    st %s15, 24(, %s11)
; PIC-NEXT:    st %s16, 32(, %s11)
; PIC-NEXT:    or %s9, 0, %s11
; PIC-NEXT:    lea %s11, -352(, %s11)
; PIC-NEXT:    brge.l %s11, %s8, .LBB0_8
; PIC-NEXT:  # %bb.7: # %entry
; PIC-NEXT:    ld %s61, 24(, %s14)
; PIC-NEXT:    or %s62, 0, %s0
; PIC-NEXT:    lea %s63, 315
; PIC-NEXT:    shm.l %s63, (%s61)
; PIC-NEXT:    shm.l %s8, 8(%s61)
; PIC-NEXT:    shm.l %s11, 16(%s61)
; PIC-NEXT:    monc
; PIC-NEXT:    or %s0, 0, %s62
; PIC-NEXT:  .LBB0_8: # %entry
; PIC-NEXT:    st %s18, 48(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s19, 56(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s20, 64(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s21, 72(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s22, 80(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s23, 88(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s24, 96(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s25, 104(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s26, 112(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s27, 120(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s28, 128(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s29, 136(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s30, 144(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s31, 152(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s32, 160(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    st %s33, 168(, %s9) # 8-byte Folded Spill
; PIC-NEXT:    lea %s15, _GLOBAL_OFFSET_TABLE_@pc_lo(-24)
; PIC-NEXT:    and %s15, %s15, (32)0
; PIC-NEXT:    sic %s16
; PIC-NEXT:    lea.sl %s15, _GLOBAL_OFFSET_TABLE_@pc_hi(%s16, %s15)
; PIC-NEXT:    lea %s0, __gxx_personality_sj0@got_lo
; PIC-NEXT:    and %s0, %s0, (32)0
; PIC-NEXT:    lea.sl %s0, __gxx_personality_sj0@got_hi(, %s0)
; PIC-NEXT:    ld %s0, (%s0, %s15)
; PIC-NEXT:    st %s0, -56(, %s9)
; PIC-NEXT:    lea %s0, GCC_except_table0@gotoff_lo
; PIC-NEXT:    and %s0, %s0, (32)0
; PIC-NEXT:    lea.sl %s0, GCC_except_table0@gotoff_hi(%s0, %s15)
; PIC-NEXT:    st %s0, -48(, %s9)
; PIC-NEXT:    st %s9, -40(, %s9)
; PIC-NEXT:    st %s11, -24(, %s9)
; PIC-NEXT:    lea %s0, .LBB0_3@gotoff_lo
; PIC-NEXT:    and %s0, %s0, (32)0
; PIC-NEXT:    lea.sl %s0, .LBB0_3@gotoff_hi(%s0, %s15)
; PIC-NEXT:    st %s0, -32(, %s9)
; PIC-NEXT:    or %s0, 1, (0)1
; PIC-NEXT:    st %s0, -96(, %s9)
; PIC-NEXT:    lea %s12, _Unwind_SjLj_Register@plt_lo(-24)
; PIC-NEXT:    and %s12, %s12, (32)0
; PIC-NEXT:    sic %s16
; PIC-NEXT:    lea.sl %s12, _Unwind_SjLj_Register@plt_hi(%s16, %s12)
; PIC-NEXT:    lea %s0, -104(, %s9)
; PIC-NEXT:    bsic %s10, (, %s12)
; PIC-NEXT:  .Ltmp0:
; PIC-NEXT:    lea %s12, errorbar@plt_lo(-24)
; PIC-NEXT:    and %s12, %s12, (32)0
; PIC-NEXT:    sic %s16
; PIC-NEXT:    lea.sl %s12, errorbar@plt_hi(%s16, %s12)
; PIC-NEXT:    bsic %s10, (, %s12)
; PIC-NEXT:  .Ltmp1:
; PIC-NEXT:  # %bb.1: # %exit
; PIC-NEXT:    lea %s12, _Unwind_SjLj_Unregister@plt_lo(-24)
; PIC-NEXT:    and %s12, %s12, (32)0
; PIC-NEXT:    sic %s16
; PIC-NEXT:    lea.sl %s12, _Unwind_SjLj_Unregister@plt_hi(%s16, %s12)
; PIC-NEXT:    lea %s0, -104(, %s9)
; PIC-NEXT:    bsic %s10, (, %s12)
; PIC-NEXT:    or %s0, 0, (0)1
; PIC-NEXT:  .LBB0_2: # %exit
; PIC-NEXT:    ld %s33, 168(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s32, 160(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s31, 152(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s30, 144(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s29, 136(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s28, 128(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s27, 120(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s26, 112(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s25, 104(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s24, 96(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s23, 88(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s22, 80(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s21, 72(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s20, 64(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s19, 56(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    ld %s18, 48(, %s9) # 8-byte Folded Reload
; PIC-NEXT:    or %s11, 0, %s9
; PIC-NEXT:    ld %s16, 32(, %s11)
; PIC-NEXT:    ld %s15, 24(, %s11)
; PIC-NEXT:    ld %s10, 8(, %s11)
; PIC-NEXT:    ld %s9, (, %s11)
; PIC-NEXT:    b.l.t (, %s10)
; PIC-NEXT:  .LBB0_3:
; PIC-NEXT:    ldl.zx %s0, -96(, %s9)
; PIC-NEXT:    lea %s15, _GLOBAL_OFFSET_TABLE_@pc_lo(-24)
; PIC-NEXT:    and %s15, %s15, (32)0
; PIC-NEXT:    sic %s16
; PIC-NEXT:    lea.sl %s15, _GLOBAL_OFFSET_TABLE_@pc_hi(%s16, %s15)
; PIC-NEXT:    brgt.l 1, %s0, .LBB0_4
; PIC-NEXT:  # %bb.5:
; PIC-NEXT:    lea %s0, abort@plt_lo(-24)
; PIC-NEXT:    and %s0, %s0, (32)0
; PIC-NEXT:    sic %s16
; PIC-NEXT:    lea.sl %s0, abort@plt_hi(%s16, %s0)
; PIC-NEXT:    bsic %s10, (, %s0)
; PIC-NEXT:  .LBB0_4:
; PIC-NEXT:    lea %s1, .LJTI0_0@gotoff_lo
; PIC-NEXT:    and %s1, %s1, (32)0
; PIC-NEXT:    lea.sl %s1, .LJTI0_0@gotoff_hi(%s1, %s15)
; PIC-NEXT:    sll %s0, %s0, 2
; PIC-NEXT:    ldl.zx %s0, (%s0, %s1)
; PIC-NEXT:    lea %s1, foo@gotoff_lo
; PIC-NEXT:    and %s1, %s1, (32)0
; PIC-NEXT:    lea.sl %s1, foo@gotoff_hi(%s1, %s15)
; PIC-NEXT:    adds.l %s0, %s0, %s1
; PIC-NEXT:    b.l.t (, %s0)
; PIC-NEXT:  .LBB0_6: # %handle
; PIC-NEXT:  .Ltmp2:
; PIC-NEXT:    ld %s0, -88(, %s9)
; PIC-NEXT:    ld %s0, -80(, %s9)
; PIC-NEXT:    lea %s12, _Unwind_SjLj_Unregister@plt_lo(-24)
; PIC-NEXT:    and %s12, %s12, (32)0
; PIC-NEXT:    sic %s16
; PIC-NEXT:    lea.sl %s12, _Unwind_SjLj_Unregister@plt_hi(%s16, %s12)
; PIC-NEXT:    lea %s0, -104(, %s9)
; PIC-NEXT:    bsic %s10, (, %s12)
; PIC-NEXT:    or %s0, 1, (0)1
; PIC-NEXT:    br.l.t .LBB0_2
; PIC-NEXT:  .Lfunc_end0:
; PIC-NEXT:    .size	foo, .Lfunc_end0-foo
; PIC-NEXT:    .section	.rodata,"a",@progbits
; PIC-NEXT:    .p2align	2
; PIC-NEXT:  .LJTI0_0:
; PIC-NEXT:    .4byte	.LBB0_6-foo
; PIC-NEXT:    .section	.gcc_except_table,"a",@progbits
; PIC-NEXT:    .p2align	2
; PIC-NEXT:  GCC_except_table0:
; PIC-NEXT:  .Lexception0:
; PIC-NEXT:    .byte	255 # @LPStart Encoding = omit
; PIC-NEXT:    .byte	0 # @TType Encoding = absptr
; PIC-NEXT:    .uleb128 .Lttbase0-.Lttbaseref0
; PIC-NEXT:  .Lttbaseref0:
; PIC-NEXT:    .byte	3 # Call site Encoding = udata4
; PIC-NEXT:    .uleb128 .Lcst_end0-.Lcst_begin0
; PIC-NEXT:  .Lcst_begin0:
; PIC-NEXT:    .byte	0 # >> Call Site 0 <<
; PIC-NEXT:        #   On exception at call site 0
; PIC-NEXT:    .byte	1 #   Action: 1
; PIC-NEXT:  .Lcst_end0:
; PIC-NEXT:    .byte	1 # >> Action Record 1 <<
; PIC-NEXT:        #   Catch TypeInfo 1
; PIC-NEXT:    .byte	0 #   No further actions
; PIC-NEXT:    .p2align	2
; PIC-NEXT:        # >> Catch TypeInfos <<
; PIC-NEXT:    .8byte	SomeGlobal                      # TypeInfo 1
; PIC-NEXT:  .Lttbase0:
; PIC-NEXT:    .p2align	2
; PIC-NEXT:        # -- End function
entry:
  invoke void @errorbar() to label %exit unwind label %handle

handle:
  %error = landingpad { i8*, i32 } catch i8* @SomeGlobal
  ret i32 1

exit:
  ret i32 0
}

declare dso_local void @errorbar() local_unnamed_addr

declare dso_local i32 @__gxx_personality_sj0(...)
