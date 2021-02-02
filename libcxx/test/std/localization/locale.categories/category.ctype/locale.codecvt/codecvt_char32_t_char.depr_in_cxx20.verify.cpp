//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// <locale>

// codecvt<char32_t, char, mbstate_t>
//  deprecated in C++20

// UNSUPPORTED: c++03, c++11, c++14, c++17

#include <locale>

#include "../with_public_dtor.hpp"
#include "test_macros.h"

int main(int, char **)
{
    with_public_dtor<std::codecvt<char32_t, char, std::mbstate_t>> cvt("", 0); // expected-warning {{'codecvt<char32_t, char, __mbstate_t>' is deprecated}}
    (void)cvt;

    return 0;
}
