; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -verify-machineinstrs < %s | FileCheck %s

define <vscale x 1 x i1> @vsplat_nxv1i1_0() {
; CHECK-LABEL: vsplat_nxv1i1_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf8,ta,mu
; CHECK-NEXT:    vmclr.m v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i1> undef, i1 0, i32 0
  %splat = shufflevector <vscale x 1 x i1> %head, <vscale x 1 x i1> undef, <vscale x 1 x i32> zeroinitializer
  ret <vscale x 1 x i1> %splat
}

define <vscale x 1 x i1> @vsplat_nxv1i1_1() {
; CHECK-LABEL: vsplat_nxv1i1_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf8,ta,mu
; CHECK-NEXT:    vmset.m v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i1> undef, i1 -1, i32 0
  %splat = shufflevector <vscale x 1 x i1> %head, <vscale x 1 x i1> undef, <vscale x 1 x i32> zeroinitializer
  ret <vscale x 1 x i1> %splat
}

define <vscale x 2 x i1> @vsplat_nxv2i1_0() {
; CHECK-LABEL: vsplat_nxv2i1_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf4,ta,mu
; CHECK-NEXT:    vmclr.m v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i1> undef, i1 0, i32 0
  %splat = shufflevector <vscale x 2 x i1> %head, <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x i1> %splat
}

define <vscale x 2 x i1> @vsplat_nxv2i1_1() {
; CHECK-LABEL: vsplat_nxv2i1_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf4,ta,mu
; CHECK-NEXT:    vmset.m v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i1> undef, i1 -1, i32 0
  %splat = shufflevector <vscale x 2 x i1> %head, <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x i1> %splat
}

define <vscale x 4 x i1> @vsplat_nxv4i1_0() {
; CHECK-LABEL: vsplat_nxv4i1_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf2,ta,mu
; CHECK-NEXT:    vmclr.m v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i1> undef, i1 0, i32 0
  %splat = shufflevector <vscale x 4 x i1> %head, <vscale x 4 x i1> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i1> %splat
}

define <vscale x 4 x i1> @vsplat_nxv4i1_1() {
; CHECK-LABEL: vsplat_nxv4i1_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf2,ta,mu
; CHECK-NEXT:    vmset.m v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i1> undef, i1 -1, i32 0
  %splat = shufflevector <vscale x 4 x i1> %head, <vscale x 4 x i1> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i1> %splat
}

define <vscale x 8 x i1> @vsplat_nxv8i1_0() {
; CHECK-LABEL: vsplat_nxv8i1_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m1,ta,mu
; CHECK-NEXT:    vmclr.m v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i1> undef, i1 0, i32 0
  %splat = shufflevector <vscale x 8 x i1> %head, <vscale x 8 x i1> undef, <vscale x 8 x i32> zeroinitializer
  ret <vscale x 8 x i1> %splat
}

define <vscale x 8 x i1> @vsplat_nxv8i1_1() {
; CHECK-LABEL: vsplat_nxv8i1_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m1,ta,mu
; CHECK-NEXT:    vmset.m v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i1> undef, i1 -1, i32 0
  %splat = shufflevector <vscale x 8 x i1> %head, <vscale x 8 x i1> undef, <vscale x 8 x i32> zeroinitializer
  ret <vscale x 8 x i1> %splat
}

define <vscale x 16 x i1> @vsplat_nxv16i1_0() {
; CHECK-LABEL: vsplat_nxv16i1_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m2,ta,mu
; CHECK-NEXT:    vmclr.m v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i1> undef, i1 0, i32 0
  %splat = shufflevector <vscale x 16 x i1> %head, <vscale x 16 x i1> undef, <vscale x 16 x i32> zeroinitializer
  ret <vscale x 16 x i1> %splat
}

define <vscale x 16 x i1> @vsplat_nxv16i1_1() {
; CHECK-LABEL: vsplat_nxv16i1_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,m2,ta,mu
; CHECK-NEXT:    vmset.m v0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i1> undef, i1 -1, i32 0
  %splat = shufflevector <vscale x 16 x i1> %head, <vscale x 16 x i1> undef, <vscale x 16 x i32> zeroinitializer
  ret <vscale x 16 x i1> %splat
}
