//===---------- target_impl.cu - NVPTX OpenMP GPU options ------- CUDA -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Definitions of target specific functions
//
//===----------------------------------------------------------------------===//

#include "target_impl.h"
#include "common/debug.h"

#define __OMP_SPIN 1000
#define UNSET 0
#define SET 1

EXTERN void __kmpc_impl_init_lock(omp_lock_t *lock) {
  omp_unset_lock(lock);
}

EXTERN void __kmpc_impl_destroy_lock(omp_lock_t *lock) {
  omp_unset_lock(lock);
}

EXTERN void __kmpc_impl_set_lock(omp_lock_t *lock) {
  // int atomicCAS(int* address, int compare, int val);
  // (old == compare ? val : old)

  // TODO: not sure spinning is a good idea here..
  while (atomicCAS(lock, UNSET, SET) != UNSET) {
    clock_t start = clock();
    clock_t now;
    for (;;) {
      now = clock();
      clock_t cycles = now > start ? now - start : now + (0xffffffff - start);
      if (cycles >= __OMP_SPIN * GetBlockIdInKernel()) {
        break;
      }
    }
  } // wait for 0 to be the read value
}

EXTERN void __kmpc_impl_unset_lock(omp_lock_t *lock) {
  (void)atomicExch(lock, UNSET);
}

EXTERN int __kmpc_impl_test_lock(omp_lock_t *lock) {
  // int atomicCAS(int* address, int compare, int val);
  // (old == compare ? val : old)
  return atomicAdd(lock, 0);
}
