; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc -O0 -mtriple=mipsel-linux-gnu -global-isel -relocation-model=pic -stop-after=irtranslator -verify-machineinstrs %s -o - | FileCheck %s -check-prefixes=MIPS32_PIC

declare i32 @f(i32 %a, i32 %b);

define internal i32 @f_with_local_linkage(i32 %x, i32 %y) {
  ; MIPS32_PIC-LABEL: name: f_with_local_linkage
  ; MIPS32_PIC: bb.1.entry:
  ; MIPS32_PIC:   liveins: $a0, $a1
  ; MIPS32_PIC:   [[COPY:%[0-9]+]]:_(s32) = COPY $a0
  ; MIPS32_PIC:   [[COPY1:%[0-9]+]]:_(s32) = COPY $a1
  ; MIPS32_PIC:   [[ADD:%[0-9]+]]:_(s32) = G_ADD [[COPY1]], [[COPY]]
  ; MIPS32_PIC:   $v0 = COPY [[ADD]](s32)
  ; MIPS32_PIC:   RetRA implicit $v0
entry:
  %add = add i32 %y, %x
  ret i32 %add
}

define i32 @call_global(i32 %a, i32 %b) {
  ; MIPS32_PIC-LABEL: name: call_global
  ; MIPS32_PIC: bb.1.entry:
  ; MIPS32_PIC:   liveins: $a0, $a1, $t9, $v0
  ; MIPS32_PIC:   [[ADDu:%[0-9]+]]:gpr32 = ADDu $v0, $t9
  ; MIPS32_PIC:   [[COPY:%[0-9]+]]:_(s32) = COPY $a0
  ; MIPS32_PIC:   [[COPY1:%[0-9]+]]:_(s32) = COPY $a1
  ; MIPS32_PIC:   ADJCALLSTACKDOWN 16, 0, implicit-def $sp, implicit $sp
  ; MIPS32_PIC:   [[GV:%[0-9]+]]:gpr32(p0) = G_GLOBAL_VALUE target-flags(mips-got-call) @f
  ; MIPS32_PIC:   $a0 = COPY [[COPY]](s32)
  ; MIPS32_PIC:   $a1 = COPY [[COPY1]](s32)
  ; MIPS32_PIC:   $gp = COPY [[ADDu]]
  ; MIPS32_PIC:   JALRPseudo [[GV]](p0), csr_o32, implicit-def $ra, implicit-def $sp, implicit $a0, implicit $a1, implicit-def $gp, implicit-def $v0
  ; MIPS32_PIC:   [[COPY2:%[0-9]+]]:_(s32) = COPY $v0
  ; MIPS32_PIC:   ADJCALLSTACKUP 16, 0, implicit-def $sp, implicit $sp
  ; MIPS32_PIC:   $v0 = COPY [[COPY2]](s32)
  ; MIPS32_PIC:   RetRA implicit $v0
entry:
  %call = call i32 @f(i32 %a, i32 %b)
  ret i32 %call
}

define i32 @call_global_with_local_linkage(i32 %a, i32 %b) {
  ; MIPS32_PIC-LABEL: name: call_global_with_local_linkage
  ; MIPS32_PIC: bb.1.entry:
  ; MIPS32_PIC:   liveins: $a0, $a1, $t9, $v0
  ; MIPS32_PIC:   [[ADDu:%[0-9]+]]:gpr32 = ADDu $v0, $t9
  ; MIPS32_PIC:   [[COPY:%[0-9]+]]:_(s32) = COPY $a0
  ; MIPS32_PIC:   [[COPY1:%[0-9]+]]:_(s32) = COPY $a1
  ; MIPS32_PIC:   ADJCALLSTACKDOWN 16, 0, implicit-def $sp, implicit $sp
  ; MIPS32_PIC:   [[GV:%[0-9]+]]:gpr32(p0) = G_GLOBAL_VALUE @f_with_local_linkage
  ; MIPS32_PIC:   $a0 = COPY [[COPY]](s32)
  ; MIPS32_PIC:   $a1 = COPY [[COPY1]](s32)
  ; MIPS32_PIC:   $gp = COPY [[ADDu]]
  ; MIPS32_PIC:   JALRPseudo [[GV]](p0), csr_o32, implicit-def $ra, implicit-def $sp, implicit $a0, implicit $a1, implicit-def $gp, implicit-def $v0
  ; MIPS32_PIC:   [[COPY2:%[0-9]+]]:_(s32) = COPY $v0
  ; MIPS32_PIC:   ADJCALLSTACKUP 16, 0, implicit-def $sp, implicit $sp
  ; MIPS32_PIC:   $v0 = COPY [[COPY2]](s32)
  ; MIPS32_PIC:   RetRA implicit $v0
entry:
  %call = call i32 @f_with_local_linkage(i32 %a, i32 %b)
  ret i32 %call
}
