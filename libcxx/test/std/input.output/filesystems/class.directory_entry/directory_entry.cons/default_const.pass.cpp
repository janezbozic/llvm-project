//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// UNSUPPORTED: c++98, c++03
// XFAIL: apple-clang-7, clang-3.7, clang-3.8

// <filesystem>

// class directory_entry

//          directory_entry() noexcept = default;

#include "filesystem_include.hpp"
#include <type_traits>
#include <cassert>

#include "test_macros.h"

int main(int, char**) {
  using namespace fs;
  // Default
  {
    static_assert(std::is_nothrow_default_constructible<directory_entry>::value,
                  "directory_entry must have a nothrow default constructor");
    const directory_entry e;
    assert(e.path() == path());
  }

  return 0;
}
