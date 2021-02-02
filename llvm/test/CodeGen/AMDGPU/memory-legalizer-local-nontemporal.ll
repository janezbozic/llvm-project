; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-amd- -mcpu=gfx600 -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX6 %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx700 -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX7 %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1010 -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX10-WGP %s
; RUN: llc -mtriple=amdgcn-amd-amdhsa -mcpu=gfx1010 -mattr=+cumode -verify-machineinstrs < %s | FileCheck --check-prefixes=GFX10-CU %s
; RUN: llc -mtriple=amdgcn-amd-amdpal -mcpu=gfx700 -amdgcn-skip-cache-invalidations -verify-machineinstrs < %s | FileCheck --check-prefixes=SKIP-CACHE-INV %s

define amdgpu_kernel void @local_nontemporal_load_0(
; GFX6-LABEL: local_nontemporal_load_0:
; GFX6:       ; %bb.0: ; %entry
; GFX6-NEXT:    s_load_dword s4, s[0:1], 0x9
; GFX6-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0xb
; GFX6-NEXT:    s_mov_b32 m0, -1
; GFX6-NEXT:    s_mov_b32 s3, 0xf000
; GFX6-NEXT:    s_mov_b32 s2, -1
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s4
; GFX6-NEXT:    ds_read_b32 v0, v0
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: local_nontemporal_load_0:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX7-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x2
; GFX7-NEXT:    s_mov_b32 m0, -1
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v0, s2
; GFX7-NEXT:    ds_read_b32 v2, v0
; GFX7-NEXT:    v_mov_b32_e32 v0, s0
; GFX7-NEXT:    v_mov_b32_e32 v1, s1
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    flat_store_dword v[0:1], v2
; GFX7-NEXT:    s_endpgm
;
; GFX10-WGP-LABEL: local_nontemporal_load_0:
; GFX10-WGP:       ; %bb.0: ; %entry
; GFX10-WGP-NEXT:    s_clause 0x1
; GFX10-WGP-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX10-WGP-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x8
; GFX10-WGP-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-WGP-NEXT:    v_mov_b32_e32 v0, s2
; GFX10-WGP-NEXT:    ds_read_b32 v0, v0
; GFX10-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-WGP-NEXT:    global_store_dword v1, v0, s[0:1]
; GFX10-WGP-NEXT:    s_endpgm
;
; GFX10-CU-LABEL: local_nontemporal_load_0:
; GFX10-CU:       ; %bb.0: ; %entry
; GFX10-CU-NEXT:    s_clause 0x1
; GFX10-CU-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX10-CU-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x8
; GFX10-CU-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CU-NEXT:    v_mov_b32_e32 v0, s2
; GFX10-CU-NEXT:    ds_read_b32 v0, v0
; GFX10-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CU-NEXT:    global_store_dword v1, v0, s[0:1]
; GFX10-CU-NEXT:    s_endpgm
;
; SKIP-CACHE-INV-LABEL: local_nontemporal_load_0:
; SKIP-CACHE-INV:       ; %bb.0: ; %entry
; SKIP-CACHE-INV-NEXT:    s_load_dword s4, s[0:1], 0x9
; SKIP-CACHE-INV-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0xb
; SKIP-CACHE-INV-NEXT:    s_mov_b32 m0, -1
; SKIP-CACHE-INV-NEXT:    s_mov_b32 s3, 0xf000
; SKIP-CACHE-INV-NEXT:    s_mov_b32 s2, -1
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    v_mov_b32_e32 v0, s4
; SKIP-CACHE-INV-NEXT:    ds_read_b32 v0, v0
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SKIP-CACHE-INV-NEXT:    s_endpgm
    i32 addrspace(3)* %in, i32 addrspace(1)* %out) {
entry:
  %val = load i32, i32 addrspace(3)* %in, align 4, !nontemporal !0
  store i32 %val, i32 addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @local_nontemporal_load_1(
; GFX6-LABEL: local_nontemporal_load_1:
; GFX6:       ; %bb.0: ; %entry
; GFX6-NEXT:    s_load_dword s4, s[0:1], 0x9
; GFX6-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0xb
; GFX6-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX6-NEXT:    s_mov_b32 m0, -1
; GFX6-NEXT:    s_mov_b32 s3, 0xf000
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    v_add_i32_e32 v0, vcc, s4, v0
; GFX6-NEXT:    ds_read_b32 v0, v0
; GFX6-NEXT:    s_mov_b32 s2, -1
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: local_nontemporal_load_1:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX7-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x2
; GFX7-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX7-NEXT:    s_mov_b32 m0, -1
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_add_i32_e32 v0, vcc, s2, v0
; GFX7-NEXT:    ds_read_b32 v2, v0
; GFX7-NEXT:    v_mov_b32_e32 v0, s0
; GFX7-NEXT:    v_mov_b32_e32 v1, s1
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    flat_store_dword v[0:1], v2
; GFX7-NEXT:    s_endpgm
;
; GFX10-WGP-LABEL: local_nontemporal_load_1:
; GFX10-WGP:       ; %bb.0: ; %entry
; GFX10-WGP-NEXT:    s_clause 0x1
; GFX10-WGP-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX10-WGP-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x8
; GFX10-WGP-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-WGP-NEXT:    v_lshl_add_u32 v0, v0, 2, s2
; GFX10-WGP-NEXT:    ds_read_b32 v0, v0
; GFX10-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-WGP-NEXT:    global_store_dword v1, v0, s[0:1]
; GFX10-WGP-NEXT:    s_endpgm
;
; GFX10-CU-LABEL: local_nontemporal_load_1:
; GFX10-CU:       ; %bb.0: ; %entry
; GFX10-CU-NEXT:    s_clause 0x1
; GFX10-CU-NEXT:    s_load_dword s2, s[4:5], 0x0
; GFX10-CU-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x8
; GFX10-CU-NEXT:    v_mov_b32_e32 v1, 0
; GFX10-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CU-NEXT:    v_lshl_add_u32 v0, v0, 2, s2
; GFX10-CU-NEXT:    ds_read_b32 v0, v0
; GFX10-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CU-NEXT:    global_store_dword v1, v0, s[0:1]
; GFX10-CU-NEXT:    s_endpgm
;
; SKIP-CACHE-INV-LABEL: local_nontemporal_load_1:
; SKIP-CACHE-INV:       ; %bb.0: ; %entry
; SKIP-CACHE-INV-NEXT:    s_load_dword s4, s[0:1], 0x9
; SKIP-CACHE-INV-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0xb
; SKIP-CACHE-INV-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SKIP-CACHE-INV-NEXT:    s_mov_b32 m0, -1
; SKIP-CACHE-INV-NEXT:    s_mov_b32 s3, 0xf000
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    v_add_i32_e32 v0, vcc, s4, v0
; SKIP-CACHE-INV-NEXT:    ds_read_b32 v0, v0
; SKIP-CACHE-INV-NEXT:    s_mov_b32 s2, -1
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SKIP-CACHE-INV-NEXT:    s_endpgm
    i32 addrspace(3)* %in, i32 addrspace(1)* %out) {
entry:
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %val.gep = getelementptr inbounds i32, i32 addrspace(3)* %in, i32 %tid
  %val = load i32, i32 addrspace(3)* %val.gep, align 4, !nontemporal !0
  store i32 %val, i32 addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @local_nontemporal_store_0(
; GFX6-LABEL: local_nontemporal_store_0:
; GFX6:       ; %bb.0: ; %entry
; GFX6-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x9
; GFX6-NEXT:    s_load_dword s0, s[0:1], 0xb
; GFX6-NEXT:    s_mov_b32 m0, -1
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_load_dword s1, s[2:3], 0x0
; GFX6-NEXT:    v_mov_b32_e32 v0, s0
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v1, s1
; GFX6-NEXT:    ds_write_b32 v0, v1
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: local_nontemporal_store_0:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX7-NEXT:    s_load_dword s2, s[4:5], 0x2
; GFX7-NEXT:    s_mov_b32 m0, -1
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX7-NEXT:    v_mov_b32_e32 v0, s2
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v1, s0
; GFX7-NEXT:    ds_write_b32 v0, v1
; GFX7-NEXT:    s_endpgm
;
; GFX10-WGP-LABEL: local_nontemporal_store_0:
; GFX10-WGP:       ; %bb.0: ; %entry
; GFX10-WGP-NEXT:    s_clause 0x1
; GFX10-WGP-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX10-WGP-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX10-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-WGP-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX10-WGP-NEXT:    v_mov_b32_e32 v0, s2
; GFX10-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-WGP-NEXT:    v_mov_b32_e32 v1, s0
; GFX10-WGP-NEXT:    ds_write_b32 v0, v1
; GFX10-WGP-NEXT:    s_endpgm
;
; GFX10-CU-LABEL: local_nontemporal_store_0:
; GFX10-CU:       ; %bb.0: ; %entry
; GFX10-CU-NEXT:    s_clause 0x1
; GFX10-CU-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX10-CU-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX10-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CU-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX10-CU-NEXT:    v_mov_b32_e32 v0, s2
; GFX10-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CU-NEXT:    v_mov_b32_e32 v1, s0
; GFX10-CU-NEXT:    ds_write_b32 v0, v1
; GFX10-CU-NEXT:    s_endpgm
;
; SKIP-CACHE-INV-LABEL: local_nontemporal_store_0:
; SKIP-CACHE-INV:       ; %bb.0: ; %entry
; SKIP-CACHE-INV-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x9
; SKIP-CACHE-INV-NEXT:    s_load_dword s0, s[0:1], 0xb
; SKIP-CACHE-INV-NEXT:    s_mov_b32 m0, -1
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    s_load_dword s1, s[2:3], 0x0
; SKIP-CACHE-INV-NEXT:    v_mov_b32_e32 v0, s0
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    v_mov_b32_e32 v1, s1
; SKIP-CACHE-INV-NEXT:    ds_write_b32 v0, v1
; SKIP-CACHE-INV-NEXT:    s_endpgm
    i32 addrspace(1)* %in, i32 addrspace(3)* %out) {
entry:
  %val = load i32, i32 addrspace(1)* %in, align 4
  store i32 %val, i32 addrspace(3)* %out, !nontemporal !0
  ret void
}

define amdgpu_kernel void @local_nontemporal_store_1(
; GFX6-LABEL: local_nontemporal_store_1:
; GFX6:       ; %bb.0: ; %entry
; GFX6-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x9
; GFX6-NEXT:    s_load_dword s0, s[0:1], 0xb
; GFX6-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX6-NEXT:    s_mov_b32 m0, -1
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_load_dword s1, s[2:3], 0x0
; GFX6-NEXT:    v_add_i32_e32 v0, vcc, s0, v0
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v1, s1
; GFX6-NEXT:    ds_write_b32 v0, v1
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: local_nontemporal_store_1:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX7-NEXT:    s_load_dword s2, s[4:5], 0x2
; GFX7-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX7-NEXT:    s_mov_b32 m0, -1
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX7-NEXT:    v_add_i32_e32 v0, vcc, s2, v0
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v1, s0
; GFX7-NEXT:    ds_write_b32 v0, v1
; GFX7-NEXT:    s_endpgm
;
; GFX10-WGP-LABEL: local_nontemporal_store_1:
; GFX10-WGP:       ; %bb.0: ; %entry
; GFX10-WGP-NEXT:    s_clause 0x1
; GFX10-WGP-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX10-WGP-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX10-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-WGP-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX10-WGP-NEXT:    v_lshl_add_u32 v0, v0, 2, s2
; GFX10-WGP-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-WGP-NEXT:    v_mov_b32_e32 v1, s0
; GFX10-WGP-NEXT:    ds_write_b32 v0, v1
; GFX10-WGP-NEXT:    s_endpgm
;
; GFX10-CU-LABEL: local_nontemporal_store_1:
; GFX10-CU:       ; %bb.0: ; %entry
; GFX10-CU-NEXT:    s_clause 0x1
; GFX10-CU-NEXT:    s_load_dwordx2 s[0:1], s[4:5], 0x0
; GFX10-CU-NEXT:    s_load_dword s2, s[4:5], 0x8
; GFX10-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CU-NEXT:    s_load_dword s0, s[0:1], 0x0
; GFX10-CU-NEXT:    v_lshl_add_u32 v0, v0, 2, s2
; GFX10-CU-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-CU-NEXT:    v_mov_b32_e32 v1, s0
; GFX10-CU-NEXT:    ds_write_b32 v0, v1
; GFX10-CU-NEXT:    s_endpgm
;
; SKIP-CACHE-INV-LABEL: local_nontemporal_store_1:
; SKIP-CACHE-INV:       ; %bb.0: ; %entry
; SKIP-CACHE-INV-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x9
; SKIP-CACHE-INV-NEXT:    s_load_dword s0, s[0:1], 0xb
; SKIP-CACHE-INV-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SKIP-CACHE-INV-NEXT:    s_mov_b32 m0, -1
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    s_load_dword s1, s[2:3], 0x0
; SKIP-CACHE-INV-NEXT:    v_add_i32_e32 v0, vcc, s0, v0
; SKIP-CACHE-INV-NEXT:    s_waitcnt lgkmcnt(0)
; SKIP-CACHE-INV-NEXT:    v_mov_b32_e32 v1, s1
; SKIP-CACHE-INV-NEXT:    ds_write_b32 v0, v1
; SKIP-CACHE-INV-NEXT:    s_endpgm
    i32 addrspace(1)* %in, i32 addrspace(3)* %out) {
entry:
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %val = load i32, i32 addrspace(1)* %in, align 4
  %out.gep = getelementptr inbounds i32, i32 addrspace(3)* %out, i32 %tid
  store i32 %val, i32 addrspace(3)* %out.gep, !nontemporal !0
  ret void
}

!0 = !{i32 1}
declare i32 @llvm.amdgcn.workitem.id.x()
