; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -vectorizer-maximize-bandwidth -mtriple=powerpc64le-- -S \
; RUN:   -targetlibinfo -loop-simplify -loop-rotate -loop-vectorize \
; RUN:   -instcombine -simplifycfg -simplifycfg-require-and-preserve-domtree=1 -force-vector-interleave=1 < %s | FileCheck %s
define dso_local double @test(float* %Arr) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <2 x double> [ zeroinitializer, [[ENTRY]] ], [ [[TMP5:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = sext i32 [[INDEX]] to i64
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds float, float* [[ARR:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast float* [[TMP1]] to <2 x float>*
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <2 x float>, <2 x float>* [[TMP2]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = fpext <2 x float> [[WIDE_LOAD]] to <2 x double>
; CHECK-NEXT:    [[TMP4:%.*]] = call fast <2 x double> @__sind2_massv(<2 x double> [[TMP3]])
; CHECK-NEXT:    [[TMP5]] = fadd fast <2 x double> [[VEC_PHI]], [[TMP4]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 2
; CHECK-NEXT:    [[TMP6:%.*]] = icmp eq i32 [[INDEX_NEXT]], 128
; CHECK-NEXT:    br i1 [[TMP6]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop !0
; CHECK:       middle.block:
; CHECK-NEXT:    [[RDX_SHUF:%.*]] = shufflevector <2 x double> [[TMP5]], <2 x double> undef, <2 x i32> <i32 1, i32 undef>
; CHECK-NEXT:    [[BIN_RDX:%.*]] = fadd fast <2 x double> [[TMP5]], [[RDX_SHUF]]
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x double> [[BIN_RDX]], i32 0
; CHECK-NEXT:    ret double [[TMP7]]
;
entry:
  br label %for.cond

for.cond:
  %Sum.0 = phi double [ 0.000000e+00, %entry ], [ %add, %for.inc ]
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, 128
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:
  br label %for.end

for.body:
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds float, float* %Arr, i64 %idxprom
  %0 = load float, float* %arrayidx, align 4
  %conv = fpext float %0 to double
  %1 = call fast double @llvm.sin.f64(double %conv) #1
  %add = fadd fast double %Sum.0, %1
  br label %for.inc

for.inc:
  %inc = add nsw i32 %i.0, 1
  br label %for.cond

for.end:
  ret double %Sum.0
}

declare double @llvm.sin.f64(double) #0
declare <2 x double> @__sind2_massv(<2 x double>) #0
attributes #0 = { nounwind readnone speculatable willreturn }
attributes #1 = { "vector-function-abi-variant"="_ZGV_LLVM_N2v_llvm.sin.f64(__sind2_massv)" }
