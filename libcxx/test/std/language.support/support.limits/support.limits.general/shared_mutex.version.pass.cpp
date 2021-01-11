//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// WARNING: This test was generated by generate_feature_test_macro_components.py
// and should not be edited manually.
//
// clang-format off

// UNSUPPORTED: libcpp-has-no-threads

// <shared_mutex>

// Test the feature test macros defined by <shared_mutex>

/*  Constant                        Value
    __cpp_lib_shared_mutex          201505L [C++17]
    __cpp_lib_shared_timed_mutex    201402L [C++14]
*/

#include <shared_mutex>
#include "test_macros.h"

#if TEST_STD_VER < 14

# ifdef __cpp_lib_shared_mutex
#   error "__cpp_lib_shared_mutex should not be defined before c++17"
# endif

# ifdef __cpp_lib_shared_timed_mutex
#   error "__cpp_lib_shared_timed_mutex should not be defined before c++14"
# endif

#elif TEST_STD_VER == 14

# ifdef __cpp_lib_shared_mutex
#   error "__cpp_lib_shared_mutex should not be defined before c++17"
# endif

# if !defined(_LIBCPP_HAS_NO_THREADS)
#   ifndef __cpp_lib_shared_timed_mutex
#     error "__cpp_lib_shared_timed_mutex should be defined in c++14"
#   endif
#   if __cpp_lib_shared_timed_mutex != 201402L
#     error "__cpp_lib_shared_timed_mutex should have the value 201402L in c++14"
#   endif
# else
#   ifdef __cpp_lib_shared_timed_mutex
#     error "__cpp_lib_shared_timed_mutex should not be defined when !defined(_LIBCPP_HAS_NO_THREADS) is not defined!"
#   endif
# endif

#elif TEST_STD_VER == 17

# if !defined(_LIBCPP_HAS_NO_THREADS)
#   ifndef __cpp_lib_shared_mutex
#     error "__cpp_lib_shared_mutex should be defined in c++17"
#   endif
#   if __cpp_lib_shared_mutex != 201505L
#     error "__cpp_lib_shared_mutex should have the value 201505L in c++17"
#   endif
# else
#   ifdef __cpp_lib_shared_mutex
#     error "__cpp_lib_shared_mutex should not be defined when !defined(_LIBCPP_HAS_NO_THREADS) is not defined!"
#   endif
# endif

# if !defined(_LIBCPP_HAS_NO_THREADS)
#   ifndef __cpp_lib_shared_timed_mutex
#     error "__cpp_lib_shared_timed_mutex should be defined in c++17"
#   endif
#   if __cpp_lib_shared_timed_mutex != 201402L
#     error "__cpp_lib_shared_timed_mutex should have the value 201402L in c++17"
#   endif
# else
#   ifdef __cpp_lib_shared_timed_mutex
#     error "__cpp_lib_shared_timed_mutex should not be defined when !defined(_LIBCPP_HAS_NO_THREADS) is not defined!"
#   endif
# endif

#elif TEST_STD_VER == 20

# if !defined(_LIBCPP_HAS_NO_THREADS)
#   ifndef __cpp_lib_shared_mutex
#     error "__cpp_lib_shared_mutex should be defined in c++20"
#   endif
#   if __cpp_lib_shared_mutex != 201505L
#     error "__cpp_lib_shared_mutex should have the value 201505L in c++20"
#   endif
# else
#   ifdef __cpp_lib_shared_mutex
#     error "__cpp_lib_shared_mutex should not be defined when !defined(_LIBCPP_HAS_NO_THREADS) is not defined!"
#   endif
# endif

# if !defined(_LIBCPP_HAS_NO_THREADS)
#   ifndef __cpp_lib_shared_timed_mutex
#     error "__cpp_lib_shared_timed_mutex should be defined in c++20"
#   endif
#   if __cpp_lib_shared_timed_mutex != 201402L
#     error "__cpp_lib_shared_timed_mutex should have the value 201402L in c++20"
#   endif
# else
#   ifdef __cpp_lib_shared_timed_mutex
#     error "__cpp_lib_shared_timed_mutex should not be defined when !defined(_LIBCPP_HAS_NO_THREADS) is not defined!"
#   endif
# endif

#elif TEST_STD_VER > 20

# if !defined(_LIBCPP_HAS_NO_THREADS)
#   ifndef __cpp_lib_shared_mutex
#     error "__cpp_lib_shared_mutex should be defined in c++2b"
#   endif
#   if __cpp_lib_shared_mutex != 201505L
#     error "__cpp_lib_shared_mutex should have the value 201505L in c++2b"
#   endif
# else
#   ifdef __cpp_lib_shared_mutex
#     error "__cpp_lib_shared_mutex should not be defined when !defined(_LIBCPP_HAS_NO_THREADS) is not defined!"
#   endif
# endif

# if !defined(_LIBCPP_HAS_NO_THREADS)
#   ifndef __cpp_lib_shared_timed_mutex
#     error "__cpp_lib_shared_timed_mutex should be defined in c++2b"
#   endif
#   if __cpp_lib_shared_timed_mutex != 201402L
#     error "__cpp_lib_shared_timed_mutex should have the value 201402L in c++2b"
#   endif
# else
#   ifdef __cpp_lib_shared_timed_mutex
#     error "__cpp_lib_shared_timed_mutex should not be defined when !defined(_LIBCPP_HAS_NO_THREADS) is not defined!"
#   endif
# endif

#endif // TEST_STD_VER > 20

int main(int, char**) { return 0; }
