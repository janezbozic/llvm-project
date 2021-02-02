//===- LTO.h ----------------------------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLD_MACHO_LTO_H
#define LLD_MACHO_LTO_H

#include "llvm/ADT/SmallString.h"
#include <memory>
#include <vector>

namespace llvm {
namespace lto {
class LTO;
} // namespace lto
} // namespace llvm

namespace lld {
namespace macho {

class BitcodeFile;
class ObjFile;

class BitcodeCompiler {
public:
  BitcodeCompiler();

  void add(BitcodeFile &f);
  std::vector<ObjFile *> compile();

private:
  std::unique_ptr<llvm::lto::LTO> ltoObj;
  std::vector<llvm::SmallString<0>> buf;
};

} // namespace macho
} // namespace lld

#endif
