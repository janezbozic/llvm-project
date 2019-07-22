// RUN: llvm-mc -triple x86_64-unknown-unknown --show-encoding < %s  | FileCheck %s

// CHECK: vp2intersectd %ymm24, %ymm23, %k6
// CHECK: encoding: [0x62,0x92,0x47,0x20,0x68,0xf0]
          vp2intersectd %ymm24, %ymm23, %k6

// CHECK: vp2intersectd %xmm24, %xmm23, %k6
// CHECK: encoding: [0x62,0x92,0x47,0x00,0x68,0xf0]
          vp2intersectd %xmm24, %xmm23, %k6

// CHECK: vp2intersectd  268435456(%rbp,%r14,8), %ymm23, %k6
// CHECK: encoding: [0x62,0xb2,0x47,0x20,0x68,0xb4,0xf5,0x00,0x00,0x00,0x10]
          vp2intersectd  268435456(%rbp,%r14,8), %ymm23, %k6

// CHECK: vp2intersectd  291(%r8,%rax,4), %ymm23, %k6
// CHECK: encoding: [0x62,0xd2,0x47,0x20,0x68,0xb4,0x80,0x23,0x01,0x00,0x00]
          vp2intersectd  291(%r8,%rax,4), %ymm23, %k6

// CHECK: vp2intersectd  (%rip){1to8}, %ymm23, %k6
// CHECK: encoding: [0x62,0xf2,0x47,0x30,0x68,0x35,0x00,0x00,0x00,0x00]
          vp2intersectd  (%rip){1to8}, %ymm23, %k6

// CHECK: vp2intersectd  -1024(,%rbp,2), %ymm23, %k6
// CHECK: encoding: [0x62,0xf2,0x47,0x20,0x68,0x34,0x6d,0x00,0xfc,0xff,0xff]
          vp2intersectd  -1024(,%rbp,2), %ymm23, %k6

// CHECK: vp2intersectd  4064(%rcx), %ymm23, %k6
// CHECK: encoding: [0x62,0xf2,0x47,0x20,0x68,0x71,0x7f]
          vp2intersectd  4064(%rcx), %ymm23, %k6

// CHECK: vp2intersectd  -512(%rdx){1to8}, %ymm23, %k6
// CHECK: encoding: [0x62,0xf2,0x47,0x30,0x68,0x72,0x80]
          vp2intersectd  -512(%rdx){1to8}, %ymm23, %k6

// CHECK: vp2intersectd  268435456(%rbp,%r14,8), %xmm23, %k6
// CHECK: encoding: [0x62,0xb2,0x47,0x00,0x68,0xb4,0xf5,0x00,0x00,0x00,0x10]
          vp2intersectd  268435456(%rbp,%r14,8), %xmm23, %k6

// CHECK: vp2intersectd  291(%r8,%rax,4), %xmm23, %k6
// CHECK: encoding: [0x62,0xd2,0x47,0x00,0x68,0xb4,0x80,0x23,0x01,0x00,0x00]
          vp2intersectd  291(%r8,%rax,4), %xmm23, %k6

// CHECK: vp2intersectd  (%rip){1to4}, %xmm23, %k6
// CHECK: encoding: [0x62,0xf2,0x47,0x10,0x68,0x35,0x00,0x00,0x00,0x00]
          vp2intersectd  (%rip){1to4}, %xmm23, %k6

// CHECK: vp2intersectd  -512(,%rbp,2), %xmm23, %k6
// CHECK: encoding: [0x62,0xf2,0x47,0x00,0x68,0x34,0x6d,0x00,0xfe,0xff,0xff]
          vp2intersectd  -512(,%rbp,2), %xmm23, %k6

// CHECK: vp2intersectd  2032(%rcx), %xmm23, %k6
// CHECK: encoding: [0x62,0xf2,0x47,0x00,0x68,0x71,0x7f]
          vp2intersectd  2032(%rcx), %xmm23, %k6

// CHECK: vp2intersectd  -512(%rdx){1to4}, %xmm23, %k6
// CHECK: encoding: [0x62,0xf2,0x47,0x10,0x68,0x72,0x80]
          vp2intersectd  -512(%rdx){1to4}, %xmm23, %k6

// CHECK: vp2intersectq %ymm24, %ymm23, %k6
// CHECK: encoding: [0x62,0x92,0xc7,0x20,0x68,0xf0]
          vp2intersectq %ymm24, %ymm23, %k6

// CHECK: vp2intersectq %xmm24, %xmm23, %k6
// CHECK: encoding: [0x62,0x92,0xc7,0x00,0x68,0xf0]
          vp2intersectq %xmm24, %xmm23, %k6

// CHECK: vp2intersectq  268435456(%rbp,%r14,8), %ymm23, %k6
// CHECK: encoding: [0x62,0xb2,0xc7,0x20,0x68,0xb4,0xf5,0x00,0x00,0x00,0x10]
          vp2intersectq  268435456(%rbp,%r14,8), %ymm23, %k6

// CHECK: vp2intersectq  291(%r8,%rax,4), %ymm23, %k6
// CHECK: encoding: [0x62,0xd2,0xc7,0x20,0x68,0xb4,0x80,0x23,0x01,0x00,0x00]
          vp2intersectq  291(%r8,%rax,4), %ymm23, %k6

// CHECK: vp2intersectq  (%rip){1to4}, %ymm23, %k6
// CHECK: encoding: [0x62,0xf2,0xc7,0x30,0x68,0x35,0x00,0x00,0x00,0x00]
          vp2intersectq  (%rip){1to4}, %ymm23, %k6

// CHECK: vp2intersectq  -1024(,%rbp,2), %ymm23, %k6
// CHECK: encoding: [0x62,0xf2,0xc7,0x20,0x68,0x34,0x6d,0x00,0xfc,0xff,0xff]
          vp2intersectq  -1024(,%rbp,2), %ymm23, %k6

// CHECK: vp2intersectq  4064(%rcx), %ymm23, %k6
// CHECK: encoding: [0x62,0xf2,0xc7,0x20,0x68,0x71,0x7f]
          vp2intersectq  4064(%rcx), %ymm23, %k6

// CHECK: vp2intersectq  -1024(%rdx){1to4}, %ymm23, %k6
// CHECK: encoding: [0x62,0xf2,0xc7,0x30,0x68,0x72,0x80]
          vp2intersectq  -1024(%rdx){1to4}, %ymm23, %k6

// CHECK: vp2intersectq  268435456(%rbp,%r14,8), %xmm23, %k6
// CHECK: encoding: [0x62,0xb2,0xc7,0x00,0x68,0xb4,0xf5,0x00,0x00,0x00,0x10]
          vp2intersectq  268435456(%rbp,%r14,8), %xmm23, %k6

// CHECK: vp2intersectq  291(%r8,%rax,4), %xmm23, %k6
// CHECK: encoding: [0x62,0xd2,0xc7,0x00,0x68,0xb4,0x80,0x23,0x01,0x00,0x00]
          vp2intersectq  291(%r8,%rax,4), %xmm23, %k6

// CHECK: vp2intersectq  (%rip){1to2}, %xmm23, %k6
// CHECK: encoding: [0x62,0xf2,0xc7,0x10,0x68,0x35,0x00,0x00,0x00,0x00]
          vp2intersectq  (%rip){1to2}, %xmm23, %k6

// CHECK: vp2intersectq  -512(,%rbp,2), %xmm23, %k6
// CHECK: encoding: [0x62,0xf2,0xc7,0x00,0x68,0x34,0x6d,0x00,0xfe,0xff,0xff]
          vp2intersectq  -512(,%rbp,2), %xmm23, %k6

// CHECK: vp2intersectq  2032(%rcx), %xmm23, %k6
// CHECK: encoding: [0x62,0xf2,0xc7,0x00,0x68,0x71,0x7f]
          vp2intersectq  2032(%rcx), %xmm23, %k6

// CHECK: vp2intersectq  -1024(%rdx){1to2}, %xmm23, %k6
// CHECK: encoding: [0x62,0xf2,0xc7,0x10,0x68,0x72,0x80]
          vp2intersectq  -1024(%rdx){1to2}, %xmm23, %k6
