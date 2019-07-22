// RUN: llvm-mc -triple=aarch64 -show-encoding -mattr=+sve2 < %s \
// RUN:        | FileCheck %s --check-prefixes=CHECK-ENCODING,CHECK-INST
// RUN: not llvm-mc -triple=aarch64 -show-encoding < %s 2>&1 \
// RUN:        | FileCheck %s --check-prefix=CHECK-ERROR
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve2 < %s \
// RUN:        | llvm-objdump -d -mattr=+sve2 - | FileCheck %s --check-prefix=CHECK-INST
// RUN: llvm-mc -triple=aarch64 -filetype=obj -mattr=+sve2 < %s \
// RUN:        | llvm-objdump -d - | FileCheck %s --check-prefix=CHECK-UNKNOWN


sabalb z0.h, z1.b, z31.b
// CHECK-INST: sabalb	z0.h, z1.b, z31.b
// CHECK-ENCODING: [0x20,0xc0,0x5f,0x45]
// CHECK-ERROR: instruction requires: sve2
// CHECK-UNKNOWN: 20 c0 5f 45 <unknown>

sabalb z0.s, z1.h, z31.h
// CHECK-INST: sabalb	z0.s, z1.h, z31.h
// CHECK-ENCODING: [0x20,0xc0,0x9f,0x45]
// CHECK-ERROR: instruction requires: sve2
// CHECK-UNKNOWN: 20 c0 9f 45 <unknown>

sabalb z0.d, z1.s, z31.s
// CHECK-INST: sabalb	z0.d, z1.s, z31.s
// CHECK-ENCODING: [0x20,0xc0,0xdf,0x45]
// CHECK-ERROR: instruction requires: sve2
// CHECK-UNKNOWN: 20 c0 df 45 <unknown>


// --------------------------------------------------------------------------//
// Test compatibility with MOVPRFX instruction.

movprfx z21, z28
// CHECK-INST: movprfx	z21, z28
// CHECK-ENCODING: [0x95,0xbf,0x20,0x04]
// CHECK-ERROR: instruction requires: sve
// CHECK-UNKNOWN: 95 bf 20 04 <unknown>

sabalb z21.d, z1.s, z31.s
// CHECK-INST: sabalb	z21.d, z1.s, z31.s
// CHECK-ENCODING: [0x35,0xc0,0xdf,0x45]
// CHECK-ERROR: instruction requires: sve2
// CHECK-UNKNOWN: 35 c0 df 45 <unknown>
