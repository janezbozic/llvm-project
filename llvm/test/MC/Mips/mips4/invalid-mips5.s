# Instructions that are invalid
#
# RUN: not llvm-mc %s -triple=mips64-unknown-linux -show-encoding -mcpu=mips4 \
# RUN:     2>%t1
# RUN: FileCheck %s < %t1

	.set noat
        add.ps    $f25,$f27,$f13      # CHECK: :[[@LINE]]:{{[0-9]+}}: error: instruction requires a CPU feature not currently enabled
        luxc1     $f19,$s6($s5)       # CHECK: :[[@LINE]]:{{[0-9]+}}: error: instruction requires a CPU feature not currently enabled
        suxc1     $f12,$k1($t1)       # CHECK: :[[@LINE]]:{{[0-9]+}}: error: instruction requires a CPU feature not currently enabled
        cvt.ps.s  $f3,$f18,$f19       # CHECK: :[[@LINE]]:{{[0-9]+}}: error: instruction requires a CPU feature not currently enabled
        cvt.s.pl  $f30,$f1            # CHECK: :[[@LINE]]:{{[0-9]+}}: error: instruction requires a CPU feature not currently enabled
        cvt.s.pu  $f14,$f25           # CHECK: :[[@LINE]]:{{[0-9]+}}: error: instruction requires a CPU feature not currently enabled
        mul.ps    $f14,$f0,$f16       # CHECK: :[[@LINE]]:{{[0-9]+}}: error: instruction requires a CPU feature not currently enabled
        pll.ps    $f25,$f9,$f30       # CHECK: :[[@LINE]]:{{[0-9]+}}: error: instruction requires a CPU feature not currently enabled
        plu.ps    $f1,$f26,$f29       # CHECK: :[[@LINE]]:{{[0-9]+}}: error: instruction requires a CPU feature not currently enabled
        pul.ps    $f9,$f30,$f26     # CHECK: :[[@LINE]]:{{[0-9]+}}: error: instruction requires a CPU feature not currently enabled
        puu.ps    $f24,$f9,$f2      # CHECK: :[[@LINE]]:{{[0-9]+}}: error: instruction requires a CPU feature not currently enabled
        sub.ps    $f5,$f14,$f26       # CHECK: :[[@LINE]]:{{[0-9]+}}: error: instruction requires a CPU feature not currently enabled
