// RUN: %clang_cc1 -w -triple x86_64-pc-win32 -emit-llvm -o - %s | FileCheck %s

// To be ABI compatible with code generated by MSVC, there shouldn't be any
// sign/zero extensions on types smaller than 64bit.

// CHECK-LABEL: define dso_local void @f1(i8 %a)
void f1(char a) {}

// CHECK-LABEL: define dso_local void @f2(i8 %a)
void f2(unsigned char a) {}

// CHECK-LABEL: define dso_local void @f3(i16 %a)
void f3(short a) {}

// CHECK-LABEL: define dso_local void @f4(i16 %a)
void f4(unsigned short a) {}

// For ABI compatibility with ICC, _Complex should be passed/returned
// as if it were a struct with two elements.

// CHECK-LABEL: define dso_local void @f5(i64 %a.coerce)
void f5(_Complex float a) {}

// CHECK-LABEL: define dso_local void @f6({ double, double }* %a)
void f6(_Complex double a) {}

// CHECK-LABEL: define dso_local i64 @f7()
_Complex float f7() { return 1.0; }

// CHECK-LABEL: define dso_local void @f8({ double, double }* noalias sret({ double, double }) align 8 %agg.result)
_Complex double f8() { return 1.0; }
