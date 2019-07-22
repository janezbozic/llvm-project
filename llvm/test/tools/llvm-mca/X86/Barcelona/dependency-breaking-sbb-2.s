# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -timeline -timeline-max-iterations=3 -iterations=1500 < %s | FileCheck %s

# The SBB does not depend on the value of register EAX. That means, it doesn't
# have to wait for the IMUL to write-back on EAX. However, it still depends on
# the ADD for EFLAGS.

imul %edx, %eax
add %edx, %edx
sbb %eax, %eax

# CHECK:      Iterations:        1500
# CHECK-NEXT: Instructions:      4500
# CHECK-NEXT: Total Cycles:      7503
# CHECK-NEXT: Total uOps:        6000

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    0.80
# CHECK-NEXT: IPC:               0.60
# CHECK-NEXT: Block RThroughput: 1.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      3     1.00                        imull	%edx, %eax
# CHECK-NEXT:  1      1     0.33                        addl	%edx, %edx
# CHECK-NEXT:  2      2     0.67                        sbbl	%eax, %eax

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SBDivider
# CHECK-NEXT: [1]   - SBFPDivider
# CHECK-NEXT: [2]   - SBPort0
# CHECK-NEXT: [3]   - SBPort1
# CHECK-NEXT: [4]   - SBPort4
# CHECK-NEXT: [5]   - SBPort5
# CHECK-NEXT: [6.0] - SBPort23
# CHECK-NEXT: [6.1] - SBPort23

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]
# CHECK-NEXT:  -      -     1.33   1.33    -     1.33    -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]  Instructions:
# CHECK-NEXT:  -      -      -     1.00    -      -      -      -     imull	%edx, %eax
# CHECK-NEXT:  -      -     0.33   0.33    -     0.34    -      -     addl	%edx, %edx
# CHECK-NEXT:  -      -     1.00    -      -     1.00    -      -     sbbl	%eax, %eax

# CHECK:      Timeline view:
# CHECK-NEXT:                     01234567
# CHECK-NEXT: Index     0123456789

# CHECK:      [0,0]     DeeeER    .    . .   imull	%edx, %eax
# CHECK-NEXT: [0,1]     DeE--R    .    . .   addl	%edx, %edx
# CHECK-NEXT: [0,2]     D===eeER  .    . .   sbbl	%eax, %eax
# CHECK-NEXT: [1,0]     .D====eeeER    . .   imull	%edx, %eax
# CHECK-NEXT: [1,1]     .DeE------R    . .   addl	%edx, %edx
# CHECK-NEXT: [1,2]     .D=======eeER  . .   sbbl	%eax, %eax
# CHECK-NEXT: [2,0]     . D========eeeER .   imull	%edx, %eax
# CHECK-NEXT: [2,1]     . DeE----------R .   addl	%edx, %edx
# CHECK-NEXT: [2,2]     . D===========eeER   sbbl	%eax, %eax

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     3     5.0    0.3    0.0       imull	%edx, %eax
# CHECK-NEXT: 1.     3     1.0    0.3    6.0       addl	%edx, %edx
# CHECK-NEXT: 2.     3     8.0    0.0    0.0       sbbl	%eax, %eax
