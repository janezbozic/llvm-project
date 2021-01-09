//===-- Implementation of fetestexcept function ---------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/fenv/fetestexcept.h"
#include "src/__support/common.h"
#include "utils/FPUtil/FEnv.h"

namespace __llvm_libc {

LLVM_LIBC_FUNCTION(int, fetestexcept, (int e)) { return fputil::testExcept(e); }

} // namespace __llvm_libc
