# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=bdver2 -timeline -timeline-max-iterations=3 -iterations=1500 < %s | FileCheck %s

# Perf stat reports an IPC of 1.97 for this block of code.

# The CMP instruction doesn't depend on the value of EAX.  It can set the flags
# without having to read the inputs.

cmp %eax, %eax
cmovae %ebx, %eax

# CHECK:      Iterations:        1500
# CHECK-NEXT: Instructions:      3000
# CHECK-NEXT: Total Cycles:      2253
# CHECK-NEXT: Total uOps:        3000

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    1.33
# CHECK-NEXT: IPC:               1.33
# CHECK-NEXT: Block RThroughput: 1.5

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     1.00                        cmpl	%eax, %eax
# CHECK-NEXT:  1      1     0.50                        cmovael	%ebx, %eax

# CHECK:      Resources:
# CHECK-NEXT: [0.0] - PdAGLU01
# CHECK-NEXT: [0.1] - PdAGLU01
# CHECK-NEXT: [1]   - PdBranch
# CHECK-NEXT: [2]   - PdCount
# CHECK-NEXT: [3]   - PdDiv
# CHECK-NEXT: [4]   - PdEX0
# CHECK-NEXT: [5]   - PdEX1
# CHECK-NEXT: [6]   - PdFPCVT
# CHECK-NEXT: [7.0] - PdFPFMA
# CHECK-NEXT: [7.1] - PdFPFMA
# CHECK-NEXT: [8.0] - PdFPMAL
# CHECK-NEXT: [8.1] - PdFPMAL
# CHECK-NEXT: [9]   - PdFPMMA
# CHECK-NEXT: [10]  - PdFPSTO
# CHECK-NEXT: [11]  - PdFPU0
# CHECK-NEXT: [12]  - PdFPU1
# CHECK-NEXT: [13]  - PdFPU2
# CHECK-NEXT: [14]  - PdFPU3
# CHECK-NEXT: [15]  - PdFPXBR
# CHECK-NEXT: [16.0] - PdLoad
# CHECK-NEXT: [16.1] - PdLoad
# CHECK-NEXT: [17]  - PdMul
# CHECK-NEXT: [18]  - PdStore

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0.0]  [0.1]  [1]    [2]    [3]    [4]    [5]    [6]    [7.0]  [7.1]  [8.0]  [8.1]  [9]    [10]   [11]   [12]   [13]   [14]   [15]   [16.0] [16.1] [17]   [18]
# CHECK-NEXT:  -      -      -      -      -     1.50   1.50    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0.0]  [0.1]  [1]    [2]    [3]    [4]    [5]    [6]    [7.0]  [7.1]  [8.0]  [8.1]  [9]    [10]   [11]   [12]   [13]   [14]   [15]   [16.0] [16.1] [17]   [18]   Instructions:
# CHECK-NEXT:  -      -      -      -      -     1.00   1.00    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     cmpl	%eax, %eax
# CHECK-NEXT:  -      -      -      -      -     0.50   0.50    -      -      -      -      -      -      -      -      -      -      -      -      -      -      -      -     cmovael	%ebx, %eax

# CHECK:      Timeline view:
# CHECK-NEXT: Index     01234567

# CHECK:      [0,0]     DeER . .   cmpl	%eax, %eax
# CHECK-NEXT: [0,1]     D==eER .   cmovael	%ebx, %eax
# CHECK-NEXT: [1,0]     DeE--R .   cmpl	%eax, %eax
# CHECK-NEXT: [1,1]     D===eER.   cmovael	%ebx, %eax
# CHECK-NEXT: [2,0]     .D=eE-R.   cmpl	%eax, %eax
# CHECK-NEXT: [2,1]     .D===eER   cmovael	%ebx, %eax

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     3     1.3    1.3    1.0       cmpl	%eax, %eax
# CHECK-NEXT: 1.     3     3.7    0.3    0.0       cmovael	%ebx, %eax
