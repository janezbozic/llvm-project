; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr < %s | \
; RUN:   FileCheck %s --check-prefix=LE-PAIRED
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu \
; RUN:   -mcpu=pwr10 -ppc-asm-full-reg-names \
; RUN:   -ppc-vsr-nums-as-vr < %s | FileCheck %s --check-prefix=BE-PAIRED

@f = common local_unnamed_addr global <512 x i1> zeroinitializer, align 16
@g = common local_unnamed_addr global <256 x i1> zeroinitializer, align 16

define void @testLdSt(i64 %SrcIdx, i64 %DstIdx) {
; LE-PAIRED-LABEL: testLdSt:
; LE-PAIRED:       # %bb.0: # %entry
; LE-PAIRED-NEXT:    plxv vs1, f@PCREL+96(0), 1
; LE-PAIRED-NEXT:    plxv vs0, f@PCREL+112(0), 1
; LE-PAIRED-NEXT:    plxv vs3, f@PCREL+64(0), 1
; LE-PAIRED-NEXT:    plxv vs2, f@PCREL+80(0), 1
; LE-PAIRED-NEXT:    pstxv vs0, f@PCREL+176(0), 1
; LE-PAIRED-NEXT:    pstxv vs1, f@PCREL+160(0), 1
; LE-PAIRED-NEXT:    pstxv vs2, f@PCREL+144(0), 1
; LE-PAIRED-NEXT:    pstxv vs3, f@PCREL+128(0), 1
; LE-PAIRED-NEXT:    blr
;
; BE-PAIRED-LABEL: testLdSt:
; BE-PAIRED:       # %bb.0: # %entry
; BE-PAIRED-NEXT:    addis r3, r2, .LC0@toc@ha
; BE-PAIRED-NEXT:    ld r3, .LC0@toc@l(r3)
; BE-PAIRED-NEXT:    lxv vs1, 80(r3)
; BE-PAIRED-NEXT:    lxv vs0, 64(r3)
; BE-PAIRED-NEXT:    lxv vs3, 112(r3)
; BE-PAIRED-NEXT:    lxv vs2, 96(r3)
; BE-PAIRED-NEXT:    stxv vs1, 144(r3)
; BE-PAIRED-NEXT:    stxv vs0, 128(r3)
; BE-PAIRED-NEXT:    stxv vs3, 176(r3)
; BE-PAIRED-NEXT:    stxv vs2, 160(r3)
; BE-PAIRED-NEXT:    blr
entry:
  %arrayidx = getelementptr inbounds <512 x i1>, <512 x i1>* @f, i64 1
  %0 = load <512 x i1>, <512 x i1>* %arrayidx, align 64
  %arrayidx1 = getelementptr inbounds <512 x i1>, <512 x i1>* @f, i64 2
  store <512 x i1> %0, <512 x i1>* %arrayidx1, align 64
  ret void
}

define void @testXLdSt(i64 %SrcIdx, i64 %DstIdx) {
; LE-PAIRED-LABEL: testXLdSt:
; LE-PAIRED:       # %bb.0: # %entry
; LE-PAIRED-NEXT:    sldi r3, r3, 6
; LE-PAIRED-NEXT:    paddi r5, 0, f@PCREL, 1
; LE-PAIRED-NEXT:    add r6, r5, r3
; LE-PAIRED-NEXT:    lxv vs1, 32(r6)
; LE-PAIRED-NEXT:    lxv vs0, 48(r6)
; LE-PAIRED-NEXT:    lxvx vs3, r5, r3
; LE-PAIRED-NEXT:    lxv vs2, 16(r6)
; LE-PAIRED-NEXT:    sldi r3, r4, 6
; LE-PAIRED-NEXT:    stxvx vs3, r5, r3
; LE-PAIRED-NEXT:    add r3, r5, r3
; LE-PAIRED-NEXT:    stxv vs0, 48(r3)
; LE-PAIRED-NEXT:    stxv vs1, 32(r3)
; LE-PAIRED-NEXT:    stxv vs2, 16(r3)
; LE-PAIRED-NEXT:    blr
;
; BE-PAIRED-LABEL: testXLdSt:
; BE-PAIRED:       # %bb.0: # %entry
; BE-PAIRED-NEXT:    addis r5, r2, .LC0@toc@ha
; BE-PAIRED-NEXT:    sldi r3, r3, 6
; BE-PAIRED-NEXT:    ld r5, .LC0@toc@l(r5)
; BE-PAIRED-NEXT:    add r6, r5, r3
; BE-PAIRED-NEXT:    lxvx vs0, r5, r3
; BE-PAIRED-NEXT:    sldi r3, r4, 6
; BE-PAIRED-NEXT:    lxv vs1, 16(r6)
; BE-PAIRED-NEXT:    lxv vs3, 48(r6)
; BE-PAIRED-NEXT:    lxv vs2, 32(r6)
; BE-PAIRED-NEXT:    stxvx vs0, r5, r3
; BE-PAIRED-NEXT:    add r3, r5, r3
; BE-PAIRED-NEXT:    stxv vs1, 16(r3)
; BE-PAIRED-NEXT:    stxv vs3, 48(r3)
; BE-PAIRED-NEXT:    stxv vs2, 32(r3)
; BE-PAIRED-NEXT:    blr
entry:
  %arrayidx = getelementptr inbounds <512 x i1>, <512 x i1>* @f, i64 %SrcIdx
  %0 = load <512 x i1>, <512 x i1>* %arrayidx, align 64
  %arrayidx1 = getelementptr inbounds <512 x i1>, <512 x i1>* @f, i64 %DstIdx
  store <512 x i1> %0, <512 x i1>* %arrayidx1, align 64
  ret void
}

define void @testUnalignedLdSt() {
; LE-PAIRED-LABEL: testUnalignedLdSt:
; LE-PAIRED:       # %bb.0: # %entry
; LE-PAIRED-NEXT:    plxv vs1, f@PCREL+43(0), 1
; LE-PAIRED-NEXT:    plxv vs0, f@PCREL+59(0), 1
; LE-PAIRED-NEXT:    plxv vs3, f@PCREL+11(0), 1
; LE-PAIRED-NEXT:    plxv vs2, f@PCREL+27(0), 1
; LE-PAIRED-NEXT:    pstxv vs0, f@PCREL+67(0), 1
; LE-PAIRED-NEXT:    pstxv vs1, f@PCREL+51(0), 1
; LE-PAIRED-NEXT:    pstxv vs2, f@PCREL+35(0), 1
; LE-PAIRED-NEXT:    pstxv vs3, f@PCREL+19(0), 1
; LE-PAIRED-NEXT:    blr
;
; BE-PAIRED-LABEL: testUnalignedLdSt:
; BE-PAIRED:       # %bb.0: # %entry
; BE-PAIRED-NEXT:    addis r3, r2, .LC0@toc@ha
; BE-PAIRED-NEXT:    li r4, 11
; BE-PAIRED-NEXT:    ld r3, .LC0@toc@l(r3)
; BE-PAIRED-NEXT:    lxvx vs0, r3, r4
; BE-PAIRED-NEXT:    li r4, 27
; BE-PAIRED-NEXT:    lxvx vs1, r3, r4
; BE-PAIRED-NEXT:    li r4, 43
; BE-PAIRED-NEXT:    lxvx vs2, r3, r4
; BE-PAIRED-NEXT:    li r4, 59
; BE-PAIRED-NEXT:    lxvx vs3, r3, r4
; BE-PAIRED-NEXT:    li r4, 35
; BE-PAIRED-NEXT:    stxvx vs1, r3, r4
; BE-PAIRED-NEXT:    li r4, 19
; BE-PAIRED-NEXT:    stxvx vs0, r3, r4
; BE-PAIRED-NEXT:    li r4, 67
; BE-PAIRED-NEXT:    stxvx vs3, r3, r4
; BE-PAIRED-NEXT:    li r4, 51
; BE-PAIRED-NEXT:    stxvx vs2, r3, r4
; BE-PAIRED-NEXT:    blr
entry:
  %0 = bitcast <512 x i1>* @f to i8*
  %add.ptr = getelementptr inbounds i8, i8* %0, i64 11
  %add.ptr1 = getelementptr inbounds i8, i8* %0, i64 19
  %1 = bitcast i8* %add.ptr to <512 x i1>*
  %2 = bitcast i8* %add.ptr1 to <512 x i1>*
  %3 = load <512 x i1>, <512 x i1>* %1, align 64
  store <512 x i1> %3, <512 x i1>* %2, align 64
  ret void
}

define void @testLdStPair(i64 %SrcIdx, i64 %DstIdx) {
; LE-PAIRED-LABEL: testLdStPair:
; LE-PAIRED:       # %bb.0: # %entry
; LE-PAIRED-NEXT:    plxv vs1, g@PCREL+32(0), 1
; LE-PAIRED-NEXT:    plxv vs0, g@PCREL+48(0), 1
; LE-PAIRED-NEXT:    pstxv vs1, g@PCREL+64(0), 1
; LE-PAIRED-NEXT:    pstxv vs0, g@PCREL+80(0), 1
; LE-PAIRED-NEXT:    blr
;
; BE-PAIRED-LABEL: testLdStPair:
; BE-PAIRED:       # %bb.0: # %entry
; BE-PAIRED-NEXT:    addis r3, r2, .LC1@toc@ha
; BE-PAIRED-NEXT:    ld r3, .LC1@toc@l(r3)
; BE-PAIRED-NEXT:    lxv vs1, 48(r3)
; BE-PAIRED-NEXT:    lxv vs0, 32(r3)
; BE-PAIRED-NEXT:    stxv vs1, 80(r3)
; BE-PAIRED-NEXT:    stxv vs0, 64(r3)
; BE-PAIRED-NEXT:    blr
entry:
  %arrayidx = getelementptr inbounds <256 x i1>, <256 x i1>* @g, i64 1
  %0 = load <256 x i1>, <256 x i1>* %arrayidx, align 64
  %arrayidx1 = getelementptr inbounds <256 x i1>, <256 x i1>* @g, i64 2
  store <256 x i1> %0, <256 x i1>* %arrayidx1, align 64
  ret void
}

define void @testXLdStPair(i64 %SrcIdx, i64 %DstIdx) {
; LE-PAIRED-LABEL: testXLdStPair:
; LE-PAIRED:       # %bb.0: # %entry
; LE-PAIRED-NEXT:    sldi r3, r3, 5
; LE-PAIRED-NEXT:    paddi r5, 0, g@PCREL, 1
; LE-PAIRED-NEXT:    add r6, r5, r3
; LE-PAIRED-NEXT:    lxvx vs1, r5, r3
; LE-PAIRED-NEXT:    sldi r3, r4, 5
; LE-PAIRED-NEXT:    lxv vs0, 16(r6)
; LE-PAIRED-NEXT:    add r4, r5, r3
; LE-PAIRED-NEXT:    stxvx vs1, r5, r3
; LE-PAIRED-NEXT:    stxv vs0, 16(r4)
; LE-PAIRED-NEXT:    blr
;
; BE-PAIRED-LABEL: testXLdStPair:
; BE-PAIRED:       # %bb.0: # %entry
; BE-PAIRED-NEXT:    addis r5, r2, .LC1@toc@ha
; BE-PAIRED-NEXT:    sldi r3, r3, 5
; BE-PAIRED-NEXT:    ld r5, .LC1@toc@l(r5)
; BE-PAIRED-NEXT:    add r6, r5, r3
; BE-PAIRED-NEXT:    lxvx vs0, r5, r3
; BE-PAIRED-NEXT:    sldi r3, r4, 5
; BE-PAIRED-NEXT:    lxv vs1, 16(r6)
; BE-PAIRED-NEXT:    add r4, r5, r3
; BE-PAIRED-NEXT:    stxvx vs0, r5, r3
; BE-PAIRED-NEXT:    stxv vs1, 16(r4)
; BE-PAIRED-NEXT:    blr
entry:
  %arrayidx = getelementptr inbounds <256 x i1>, <256 x i1>* @g, i64 %SrcIdx
  %0 = load <256 x i1>, <256 x i1>* %arrayidx, align 64
  %arrayidx1 = getelementptr inbounds <256 x i1>, <256 x i1>* @g, i64 %DstIdx
  store <256 x i1> %0, <256 x i1>* %arrayidx1, align 64
  ret void
}

define void @testUnalignedLdStPair() {
; LE-PAIRED-LABEL: testUnalignedLdStPair:
; LE-PAIRED:       # %bb.0: # %entry
; LE-PAIRED-NEXT:    plxv vs1, g@PCREL+11(0), 1
; LE-PAIRED-NEXT:    plxv vs0, g@PCREL+27(0), 1
; LE-PAIRED-NEXT:    pstxv vs1, g@PCREL+19(0), 1
; LE-PAIRED-NEXT:    pstxv vs0, g@PCREL+35(0), 1
; LE-PAIRED-NEXT:    blr
;
; BE-PAIRED-LABEL: testUnalignedLdStPair:
; BE-PAIRED:       # %bb.0: # %entry
; BE-PAIRED-NEXT:    addis r3, r2, .LC1@toc@ha
; BE-PAIRED-NEXT:    li r4, 11
; BE-PAIRED-NEXT:    ld r3, .LC1@toc@l(r3)
; BE-PAIRED-NEXT:    lxvx vs0, r3, r4
; BE-PAIRED-NEXT:    li r4, 27
; BE-PAIRED-NEXT:    lxvx vs1, r3, r4
; BE-PAIRED-NEXT:    li r4, 35
; BE-PAIRED-NEXT:    stxvx vs1, r3, r4
; BE-PAIRED-NEXT:    li r4, 19
; BE-PAIRED-NEXT:    stxvx vs0, r3, r4
; BE-PAIRED-NEXT:    blr
entry:
  %0 = bitcast <256 x i1>* @g to i8*
  %add.ptr = getelementptr inbounds i8, i8* %0, i64 11
  %add.ptr1 = getelementptr inbounds i8, i8* %0, i64 19
  %1 = bitcast i8* %add.ptr to <256 x i1>*
  %2 = bitcast i8* %add.ptr1 to <256 x i1>*
  %3 = load <256 x i1>, <256 x i1>* %1, align 64
  store <256 x i1> %3, <256 x i1>* %2, align 64
  ret void
}
