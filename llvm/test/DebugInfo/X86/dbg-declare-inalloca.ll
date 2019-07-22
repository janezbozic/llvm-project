; RUN: llc -O0 < %s | FileCheck %s --check-prefix=CHECK --check-prefix=DEBUG
; RUN: llc < %s | FileCheck %s
; RUN: llc -filetype=obj -O0 < %s | llvm-readobj --codeview - | FileCheck %s --check-prefix=OBJ

; IR generated by the following source:
; struct NonTrivial {
;   NonTrivial();// : x(42) {}
;   ~NonTrivial();// {}
;   int x;
; };
; extern "C" void g(int);// {}
; extern "C" void h(int);// {}
; extern "C" void f(NonTrivial a, int b, int unused, int c) {
;   if (b) {
;     g(c);
;   } else {
;     h(a.x);
;   }
;   (void)unused;
; }
; //int main() {
; //  NonTrivial x;
; //  f(x, 1, 2, 3);
; //}
;
; Remove C++ comments to have a complete, debuggable program.

; We don't need (or want) DBG_VALUE instructions to describe the location of
; inalloca arguments. We want frame indices in the side table, especially at
; -O0, because they are reliable across the entire function and don't require
; any propagation or analysis.

; CHECK: _f:                                     # @f
; CHECK: Lfunc_begin0:
; CHECK-NOT: DEBUG_VALUE
; CHECK: [[start:Ltmp[0-9]+]]:
; CHECK-NOT: DEBUG_VALUE
; CHECK:         cmpl
; CHECK:         calll   _g
; CHECK:         calll   _h
; CHECK:         jmp "??1NonTrivial@@QAE@XZ"
; CHECK: [[end:Ltmp[0-9]+]]:
; CHECK: Lfunc_end0:

; FIXME: Optimized debug info should preserve this.
; DEBUG:         .short  4414                    # Record kind: S_LOCAL
; DEBUG:         .asciz  "a"
; DEBUG:         .cv_def_range    [[start]] [[end]]

; CHECK:         .short  4414                    # Record kind: S_LOCAL
; CHECK:         .asciz  "b"
; CHECK:         .cv_def_range    [[start]] [[end]]

; CHECK:         .short  4414                    # Record kind: S_LOCAL
; CHECK:         .asciz  "c"
; CHECK:         .cv_def_range    [[start]] [[end]]

; OBJ-LABEL: {{.*}}Proc{{.*}}Sym {
; OBJ:   Kind: S_GPROC32_ID (0x1147)
; OBJ:   DisplayName: f
; OBJ: }
; OBJ: FrameProcSym {
; OBJ:   Kind: S_FRAMEPROC (0x1012)
; OBJ:   TotalFrameBytes: 0x8
; OBJ:   LocalFramePtrReg: VFRAME (0x7536)
; OBJ:   ParamFramePtrReg: VFRAME (0x7536)
; OBJ: }
; OBJ: LocalSym {
; OBJ:   Kind: S_LOCAL (0x113E)
; OBJ:   Type: NonTrivial (0x{{.*}})
; OBJ:   Flags [ (0x1)
; OBJ:     IsParameter (0x1)
; OBJ:   ]
; OBJ:   VarName: a
; OBJ: }
; OBJ: DefRangeFramePointerRelSym {
; OBJ:   Offset: 4
; OBJ: }
; OBJ: LocalSym {
; OBJ:   Type: int (0x74)
; OBJ:   Flags [ (0x1)
; OBJ:     IsParameter (0x1)
; OBJ:   ]
; OBJ:   VarName: b
; OBJ: }
; OBJ: DefRangeFramePointerRelSym {
; OBJ:   Offset: 8
; OBJ: }
; FIXME: Retain unused.
; OBJ: LocalSym {
; OBJ:   Type: int (0x74)
; OBJ:   Flags [ (0x1)
; OBJ:     IsParameter (0x1)
; OBJ:   ]
; OBJ:   VarName: c
; OBJ: }
; OBJ: DefRangeFramePointerRelSym {
; OBJ:   Offset: 16
; OBJ: }
; OBJ-LABEL: ProcEnd {
; OBJ: }


; ModuleID = 't.cpp'
source_filename = "t.cpp"
target datalayout = "e-m:x-p:32:32-i64:64-f80:32-n8:16:32-a:0:32-S32"
target triple = "i386-pc-windows-msvc19.10.24728"

%struct.NonTrivial = type { i32 }

; Function Attrs: nounwind
define void @f(<{ %struct.NonTrivial, i32, i32, i32 }>* inalloca) local_unnamed_addr #0 !dbg !7 {
entry:
  %a = getelementptr inbounds <{ %struct.NonTrivial, i32, i32, i32 }>, <{ %struct.NonTrivial, i32, i32, i32 }>* %0, i32 0, i32 0
  %b = getelementptr inbounds <{ %struct.NonTrivial, i32, i32, i32 }>, <{ %struct.NonTrivial, i32, i32, i32 }>* %0, i32 0, i32 1
  call void @llvm.dbg.declare(metadata i32* %b, metadata !22, metadata !24), !dbg !26
  call void @llvm.dbg.declare(metadata %struct.NonTrivial* %a, metadata !23, metadata !24), !dbg !27
  %1 = load i32, i32* %b, align 4, !dbg !28, !tbaa !30
  %tobool = icmp eq i32 %1, 0, !dbg !28
  br i1 %tobool, label %if.else, label %if.then, !dbg !34

if.then:                                          ; preds = %entry
  %c = getelementptr inbounds <{ %struct.NonTrivial, i32, i32, i32 }>, <{ %struct.NonTrivial, i32, i32, i32 }>* %0, i32 0, i32 3
  call void @llvm.dbg.declare(metadata i32* %c, metadata !20, metadata !24), !dbg !25
  %2 = load i32, i32* %c, align 4, !dbg !35, !tbaa !30
  tail call void @g(i32 %2) #4, !dbg !37
  br label %if.end, !dbg !38

if.else:                                          ; preds = %entry
  %x = getelementptr inbounds <{ %struct.NonTrivial, i32, i32, i32 }>, <{ %struct.NonTrivial, i32, i32, i32 }>* %0, i32 0, i32 0, i32 0, !dbg !39
  %3 = load i32, i32* %x, align 4, !dbg !39, !tbaa !41
  tail call void @h(i32 %3) #4, !dbg !43
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  tail call x86_thiscallcc void @"\01??1NonTrivial@@QAE@XZ"(%struct.NonTrivial* nonnull %a) #4, !dbg !44
  ret void, !dbg !44
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @g(i32) local_unnamed_addr

declare void @h(i32) local_unnamed_addr

; Function Attrs: nounwind
declare x86_thiscallcc void @"\01??1NonTrivial@@QAE@XZ"(%struct.NonTrivial*) unnamed_addr #3

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone speculatable }
attributes #3 = { nounwind }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !1, producer: "clang version 5.0.0 ", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "t.cpp", directory: "C:\5Csrc\5Cllvm-project\5Cbuild", checksumkind: CSK_MD5, checksum: "e41e3fda2a91b52e121ed6c29a209eae")
!2 = !{}
!3 = !{i32 1, !"NumRegisterParameters", i32 0}
!4 = !{i32 2, !"CodeView", i32 1}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{!"clang version 5.0.0 "}
!7 = distinct !DISubprogram(name: "f", scope: !1, file: !1, line: 8, type: !8, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !19)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !13, !13, !13}
!10 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "NonTrivial", file: !1, line: 1, size: 32, elements: !11, identifier: ".?AUNonTrivial@@")
!11 = !{!12, !14, !18}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !10, file: !1, line: 4, baseType: !13, size: 32)
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DISubprogram(name: "NonTrivial", scope: !10, file: !1, line: 2, type: !15, isLocal: false, isDefinition: false, scopeLine: 2, flags: DIFlagPrototyped, isOptimized: true)
!15 = !DISubroutineType(cc: DW_CC_BORLAND_thiscall, types: !16)
!16 = !{null, !17}
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 32, flags: DIFlagArtificial | DIFlagObjectPointer)
!18 = !DISubprogram(name: "~NonTrivial", scope: !10, file: !1, line: 3, type: !15, isLocal: false, isDefinition: false, scopeLine: 3, flags: DIFlagPrototyped, isOptimized: true)
!19 = !{!20, !21, !22, !23}
!20 = !DILocalVariable(name: "c", arg: 4, scope: !7, file: !1, line: 8, type: !13)
!21 = !DILocalVariable(name: "unused", arg: 3, scope: !7, file: !1, line: 8, type: !13)
!22 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 8, type: !13)
!23 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 8, type: !10)
!24 = !DIExpression()
!25 = !DILocation(line: 8, column: 56, scope: !7)
!26 = !DILocation(line: 8, column: 37, scope: !7)
!27 = !DILocation(line: 8, column: 30, scope: !7)
!28 = !DILocation(line: 9, column: 7, scope: !29)
!29 = distinct !DILexicalBlock(scope: !7, file: !1, line: 9, column: 7)
!30 = !{!31, !31, i64 0}
!31 = !{!"int", !32, i64 0}
!32 = !{!"omnipotent char", !33, i64 0}
!33 = !{!"Simple C++ TBAA"}
!34 = !DILocation(line: 9, column: 7, scope: !7)
!35 = !DILocation(line: 10, column: 7, scope: !36)
!36 = distinct !DILexicalBlock(scope: !29, file: !1, line: 9, column: 10)
!37 = !DILocation(line: 10, column: 5, scope: !36)
!38 = !DILocation(line: 11, column: 3, scope: !36)
!39 = !DILocation(line: 12, column: 9, scope: !40)
!40 = distinct !DILexicalBlock(scope: !29, file: !1, line: 11, column: 10)
!41 = !{!42, !31, i64 0}
!42 = !{!"?AUNonTrivial@@", !31, i64 0}
!43 = !DILocation(line: 12, column: 5, scope: !40)
!44 = !DILocation(line: 15, column: 1, scope: !7)
