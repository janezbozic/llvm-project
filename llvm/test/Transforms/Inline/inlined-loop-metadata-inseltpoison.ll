; This test checks that the !llvm.loop metadata has been updated after inlining
; so that the start and end locations refer to the inlined DILocations.

; RUN: opt -inline -always-inline %s -S 2>&1 | FileCheck %s
; CHECK: br i1 %{{.*}}, label %middle.block.i, label %vector.body.i, !dbg !{{[0-9]+}}, !llvm.loop [[VECTOR:![0-9]+]]
; CHECK: br i1 %{{.*}}, label %for.cond.cleanup.loopexit.i, label %for.body.i, !dbg !{{[0-9]+}}, !llvm.loop [[SCALAR:![0-9]+]]
; CHECK-DAG: [[VECTOR]] = distinct !{[[VECTOR]], [[START:![0-9]+]], [[END:![0-9]+]], [[IS_VECTORIZED:![0-9]+]]}
; CHECK-DAG: [[SCALAR]] = distinct !{[[SCALAR]], [[START]], [[END]], [[NO_UNROLL:![0-9]+]], [[IS_VECTORIZED]]}
; CHECK-DAG: [[IS_VECTORIZED]] = !{!"llvm.loop.isvectorized", i32 1}
; CHECK-DAG: [[NO_UNROLL]] = !{!"llvm.loop.unroll.runtime.disable"}

; This IR can be generated by running:
;   clang -emit-llvm -S -gmlt -O2 inlined.cpp -o - -mllvm -opt-bisect-limit=53 |\
;   opt -loop-vectorize
;
; Where inlined.cpp contains:
; extern int *Array;
; static int bar(unsigned x)
; {
;   int Ret = 0;
;   for (unsigned i = 0; i < x; ++i)
;   {
;     Ret += Array[i] * i;
;   }
;   return Ret;
; }
;
; int foo(unsigned x)
; {
;   int Bar = bar(x);
;   return Bar;
; }

@"?Array@@3PEAHEA" = external dso_local local_unnamed_addr global i32*, align 8

define dso_local i32 @"?foo@@YAHI@Z"(i32 %x) local_unnamed_addr !dbg !8 {
entry:
  %call = call fastcc i32 @"?bar@@YAHI@Z"(i32 %x), !dbg !10
  ret i32 %call, !dbg !11
}

define internal fastcc i32 @"?bar@@YAHI@Z"(i32 %x) unnamed_addr !dbg !12 {
entry:
  %cmp7 = icmp eq i32 %x, 0, !dbg !13
  br i1 %cmp7, label %for.cond.cleanup, label %for.body.lr.ph, !dbg !13

for.body.lr.ph:                                   ; preds = %entry
  %0 = load i32*, i32** @"?Array@@3PEAHEA", align 8, !dbg !14, !tbaa !15
  %wide.trip.count = zext i32 %x to i64, !dbg !14
  %min.iters.check = icmp ult i64 %wide.trip.count, 8, !dbg !13
  br i1 %min.iters.check, label %scalar.ph, label %vector.ph, !dbg !13

vector.ph:                                        ; preds = %for.body.lr.ph
  %n.mod.vf = urem i64 %wide.trip.count, 8, !dbg !13
  %n.vec = sub i64 %wide.trip.count, %n.mod.vf, !dbg !13
  br label %vector.body, !dbg !13

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ], !dbg !13
  %vec.ind = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, %vector.ph ], [ %vec.ind.next, %vector.body ]
  %vec.phi = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %17, %vector.body ]
  %vec.phi2 = phi <4 x i32> [ zeroinitializer, %vector.ph ], [ %18, %vector.body ]
  %vec.ind4 = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, %vector.ph ], [ %vec.ind.next7, %vector.body ], !dbg !19
  %step.add = add <4 x i64> %vec.ind, <i64 4, i64 4, i64 4, i64 4>
  %1 = add i64 %index, 0, !dbg !13
  %2 = add i64 %index, 1, !dbg !13
  %3 = add i64 %index, 2, !dbg !13
  %4 = add i64 %index, 3, !dbg !13
  %5 = add i64 %index, 4, !dbg !13
  %6 = add i64 %index, 5, !dbg !13
  %7 = add i64 %index, 6, !dbg !13
  %8 = add i64 %index, 7, !dbg !13
  %9 = getelementptr inbounds i32, i32* %0, i64 %1, !dbg !19
  %10 = getelementptr inbounds i32, i32* %0, i64 %5, !dbg !19
  %11 = getelementptr inbounds i32, i32* %9, i32 0, !dbg !19
  %12 = bitcast i32* %11 to <4 x i32>*, !dbg !19
  %wide.load = load <4 x i32>, <4 x i32>* %12, align 4, !dbg !19, !tbaa !20
  %13 = getelementptr inbounds i32, i32* %9, i32 4, !dbg !19
  %14 = bitcast i32* %13 to <4 x i32>*, !dbg !19
  %wide.load3 = load <4 x i32>, <4 x i32>* %14, align 4, !dbg !19, !tbaa !20
  %step.add5 = add <4 x i32> %vec.ind4, <i32 4, i32 4, i32 4, i32 4>, !dbg !19
  %15 = mul <4 x i32> %wide.load, %vec.ind4, !dbg !19
  %16 = mul <4 x i32> %wide.load3, %step.add5, !dbg !19
  %17 = add <4 x i32> %15, %vec.phi, !dbg !19
  %18 = add <4 x i32> %16, %vec.phi2, !dbg !19
  %index.next = add i64 %index, 8, !dbg !13
  %vec.ind.next = add <4 x i64> %step.add, <i64 4, i64 4, i64 4, i64 4>
  %vec.ind.next7 = add <4 x i32> %step.add5, <i32 4, i32 4, i32 4, i32 4>, !dbg !19
  %19 = icmp eq i64 %index.next, %n.vec, !dbg !13
  br i1 %19, label %middle.block, label %vector.body, !dbg !13, !llvm.loop !22

middle.block:                                     ; preds = %vector.body
  %bin.rdx = add <4 x i32> %18, %17, !dbg !19
  %rdx.shuf = shufflevector <4 x i32> %bin.rdx, <4 x i32> poison, <4 x i32> <i32 2, i32 3, i32 undef, i32 undef>, !dbg !19
  %bin.rdx8 = add <4 x i32> %bin.rdx, %rdx.shuf, !dbg !19
  %rdx.shuf9 = shufflevector <4 x i32> %bin.rdx8, <4 x i32> poison, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>, !dbg !19
  %bin.rdx10 = add <4 x i32> %bin.rdx8, %rdx.shuf9, !dbg !19
  %20 = extractelement <4 x i32> %bin.rdx10, i32 0, !dbg !19
  %cmp.n = icmp eq i64 %wide.trip.count, %n.vec, !dbg !13
  br i1 %cmp.n, label %for.cond.cleanup.loopexit, label %scalar.ph, !dbg !13

scalar.ph:                                        ; preds = %middle.block, %for.body.lr.ph
  %bc.resume.val = phi i64 [ %n.vec, %middle.block ], [ 0, %for.body.lr.ph ]
  %bc.merge.rdx = phi i32 [ 0, %for.body.lr.ph ], [ %20, %middle.block ]
  br label %for.body, !dbg !13

for.cond.cleanup.loopexit:                        ; preds = %middle.block, %for.body
  %add.lcssa = phi i32 [ %add, %for.body ], [ %20, %middle.block ], !dbg !19
  br label %for.cond.cleanup, !dbg !25

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  %Ret.0.lcssa = phi i32 [ 0, %entry ], [ %add.lcssa, %for.cond.cleanup.loopexit ], !dbg !14
  ret i32 %Ret.0.lcssa, !dbg !25

for.body:                                         ; preds = %for.body, %scalar.ph
  %indvars.iv = phi i64 [ %bc.resume.val, %scalar.ph ], [ %indvars.iv.next, %for.body ]
  %Ret.08 = phi i32 [ %bc.merge.rdx, %scalar.ph ], [ %add, %for.body ]
  %arrayidx = getelementptr inbounds i32, i32* %0, i64 %indvars.iv, !dbg !19
  %21 = load i32, i32* %arrayidx, align 4, !dbg !19, !tbaa !20
  %22 = trunc i64 %indvars.iv to i32, !dbg !19
  %mul = mul i32 %21, %22, !dbg !19
  %add = add i32 %mul, %Ret.08, !dbg !19
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !13
  %exitcond = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !13
  br i1 %exitcond, label %for.cond.cleanup.loopexit, label %for.body, !dbg !13, !llvm.loop !26
}

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !1, producer: "clang version 9.0.0 (https://github.com/llvm/llvm-project.git b1e28d9b6a16380ccf1456fe0695f639364407a9)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "inlined.cpp", directory: "")
!2 = !{}
!3 = !{i32 2, !"CodeView", i32 1}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 2}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{!"clang version 9.0.0 (https://github.com/llvm/llvm-project.git b1e28d9b6a16380ccf1456fe0695f639364407a9)"}
!8 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 13, type: !9, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !2)
!10 = !DILocation(line: 15, scope: !8)
!11 = !DILocation(line: 16, scope: !8)
!12 = distinct !DISubprogram(name: "bar", scope: !1, file: !1, line: 3, type: !9, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !2)
!13 = !DILocation(line: 6, scope: !12)
!14 = !DILocation(line: 0, scope: !12)
!15 = !{!16, !16, i64 0}
!16 = !{!"any pointer", !17, i64 0}
!17 = !{!"omnipotent char", !18, i64 0}
!18 = !{!"Simple C++ TBAA"}
!19 = !DILocation(line: 8, scope: !12)
!20 = !{!21, !21, i64 0}
!21 = !{!"int", !17, i64 0}
!22 = distinct !{!22, !13, !23, !24}
!23 = !DILocation(line: 9, scope: !12)
!24 = !{!"llvm.loop.isvectorized", i32 1}
!25 = !DILocation(line: 10, scope: !12)
!26 = distinct !{!26, !13, !23, !27, !24}
!27 = !{!"llvm.loop.unroll.runtime.disable"}
