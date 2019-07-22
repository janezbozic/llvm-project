# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=btver2 -timeline -timeline-max-iterations=1 -bottleneck-analysis < %s | FileCheck %s

add %eax, %ebx
add %ebx, %ecx
add %ecx, %edx
add %edx, %eax

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      400
# CHECK-NEXT: Total Cycles:      403
# CHECK-NEXT: Total uOps:        400

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.99
# CHECK-NEXT: IPC:               0.99
# CHECK-NEXT: Block RThroughput: 2.0

# CHECK:      Cycles with backend pressure increase [ 94.04% ]
# CHECK-NEXT: Throughput Bottlenecks:
# CHECK-NEXT:   Resource Pressure       [ 0.00% ]
# CHECK-NEXT:   Data Dependencies:      [ 94.04% ]
# CHECK-NEXT:   - Register Dependencies [ 94.04% ]
# CHECK-NEXT:   - Memory Dependencies   [ 0.00% ]

# CHECK:      Critical sequence based on the simulation:

# CHECK:                    Instruction                                 Dependency Information
# CHECK-NEXT:  +----< 3.    addl	%edx, %eax
# CHECK-NEXT:  |
# CHECK-NEXT:  |    < loop carried >
# CHECK-NEXT:  |
# CHECK-NEXT:  +----> 0.    addl	%eax, %ebx                        ## REGISTER dependency:  %eax
# CHECK-NEXT:  +----> 1.    addl	%ebx, %ecx                        ## REGISTER dependency:  %ebx
# CHECK-NEXT:  +----> 2.    addl	%ecx, %edx                        ## REGISTER dependency:  %ecx
# CHECK-NEXT:  +----> 3.    addl	%edx, %eax                        ## REGISTER dependency:  %edx
# CHECK-NEXT:  |
# CHECK-NEXT:  |    < loop carried >
# CHECK-NEXT:  |
# CHECK-NEXT:  +----> 0.    addl	%eax, %ebx                        ## REGISTER dependency:  %eax

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.50                        addl	%eax, %ebx
# CHECK-NEXT:  1      1     0.50                        addl	%ebx, %ecx
# CHECK-NEXT:  1      1     0.50                        addl	%ecx, %edx
# CHECK-NEXT:  1      1     0.50                        addl	%edx, %eax

# CHECK:      Resources:
# CHECK-NEXT: [0]   - JALU0
# CHECK-NEXT: [1]   - JALU1
# CHECK-NEXT: [2]   - JDiv
# CHECK-NEXT: [3]   - JFPA
# CHECK-NEXT: [4]   - JFPM
# CHECK-NEXT: [5]   - JFPU0
# CHECK-NEXT: [6]   - JFPU1
# CHECK-NEXT: [7]   - JLAGU
# CHECK-NEXT: [8]   - JMul
# CHECK-NEXT: [9]   - JSAGU
# CHECK-NEXT: [10]  - JSTC
# CHECK-NEXT: [11]  - JVALU0
# CHECK-NEXT: [12]  - JVALU1
# CHECK-NEXT: [13]  - JVIMUL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]
# CHECK-NEXT: 2.00   2.00    -      -      -      -      -      -      -      -      -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   Instructions:
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -      -      -      -      -      -      -     addl	%eax, %ebx
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -      -      -     addl	%ebx, %ecx
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -      -      -      -      -      -      -     addl	%ecx, %edx
# CHECK-NEXT: 1.00    -      -      -      -      -      -      -      -      -      -      -      -      -     addl	%edx, %eax

# CHECK:      Timeline view:
# CHECK-NEXT: Index     0123456

# CHECK:      [0,0]     DeER ..   addl	%eax, %ebx
# CHECK-NEXT: [0,1]     D=eER..   addl	%ebx, %ecx
# CHECK-NEXT: [0,2]     .D=eER.   addl	%ecx, %edx
# CHECK-NEXT: [0,3]     .D==eER   addl	%edx, %eax

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       addl	%eax, %ebx
# CHECK-NEXT: 1.     1     2.0    0.0    0.0       addl	%ebx, %ecx
# CHECK-NEXT: 2.     1     2.0    0.0    0.0       addl	%ecx, %edx
# CHECK-NEXT: 3.     1     3.0    0.0    0.0       addl	%edx, %eax
