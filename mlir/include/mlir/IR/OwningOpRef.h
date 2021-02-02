//===- OwningOpRef.h - MLIR OwningOpRef -------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file provides a base class for owning op refs.
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_IR_OWNINGOPREF_H
#define MLIR_IR_OWNINGOPREF_H

#include <utility>

namespace mlir {

/// This class acts as an owning reference to an op, and will automatically
/// destroy the held op on destruction if the held op is valid.
///
/// Note that OpBuilder and related functionality should be highly preferred
/// instead, and this should only be used in situations where existing solutions
/// are not viable.
template <typename OpTy>
class OwningOpRef {
public:
  /// The underlying operation type stored in this reference.
  using OperationT = OpTy;

  OwningOpRef(std::nullptr_t = nullptr) {}
  OwningOpRef(OpTy op) : op(op) {}
  OwningOpRef(OwningOpRef &&other) : op(other.release()) {}
  ~OwningOpRef() {
    if (op)
      op->erase();
  }

  /// Assign from another op reference.
  OwningOpRef &operator=(OwningOpRef &&other) {
    if (op)
      op->erase();
    op = other.release();
    return *this;
  }

  /// Allow accessing the internal op.
  OpTy get() const { return op; }
  OpTy operator*() const { return op; }
  OpTy *operator->() { return &op; }
  explicit operator bool() const { return op; }

  /// Release the referenced op.
  OpTy release() {
    OpTy released;
    std::swap(released, op);
    return released;
  }

private:
  OpTy op;
};

} // end namespace mlir

#endif // MLIR_IR_OWNINGOPREF_H
