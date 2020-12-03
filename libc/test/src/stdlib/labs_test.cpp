//===-- Unittests for labs ------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/stdlib/labs.h"
#include "utils/UnitTest/Test.h"

TEST(LabsTest, Zero) { EXPECT_EQ(__llvm_libc::labs(0l), 0l); }

TEST(LabsTest, Positive) { EXPECT_EQ(__llvm_libc::labs(1l), 1l); }

TEST(LabsTest, Negative) { EXPECT_EQ(__llvm_libc::labs(-1l), 1l); }
