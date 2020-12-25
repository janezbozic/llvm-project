//===-- AMDGPUInstrInfo.h - AMDGPU Instruction Information ------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
/// \file
/// Contains the definition of a TargetInstrInfo class that is common
/// to all AMD GPUs.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_AMDGPU_AMDGPUINSTRINFO_H
#define LLVM_LIB_TARGET_AMDGPU_AMDGPUINSTRINFO_H

#include "Utils/AMDGPUBaseInfo.h"

namespace llvm {

class GCNSubtarget;
class MachineFunction;
class MachineInstr;
class MachineInstrBuilder;
class MachineMemOperand;

class AMDGPUInstrInfo {
public:
  explicit AMDGPUInstrInfo(const GCNSubtarget &st);

  static bool isUniformMMO(const MachineMemOperand *MMO);
};

namespace AMDGPU {

struct RsrcIntrinsic {
  unsigned Intr;
  uint8_t RsrcArg;
  bool IsImage;
};
const RsrcIntrinsic *lookupRsrcIntrinsic(unsigned Intr);

struct D16ImageDimIntrinsic {
  unsigned Intr;
  unsigned D16HelperIntr;
};
const D16ImageDimIntrinsic *lookupD16ImageDimIntrinsic(unsigned Intr);

struct ImageDimIntrinsicInfo {
  unsigned Intr;
  unsigned BaseOpcode;
  MIMGDim Dim;

  uint8_t NumGradients;
  uint8_t NumDmask;
  uint8_t NumData;
  uint8_t NumVAddrs;
  uint8_t NumArgs;

  uint8_t DMaskIndex;
  uint8_t VAddrStart;
  uint8_t GradientStart;
  uint8_t CoordStart;
  uint8_t LodIndex;
  uint8_t MipIndex;
  uint8_t VAddrEnd;
  uint8_t RsrcIndex;
  uint8_t SampIndex;
  uint8_t UnormIndex;
  uint8_t TexFailCtrlIndex;
  uint8_t CachePolicyIndex;

  uint8_t GradientTyArg;
  uint8_t CoordTyArg;
};
const ImageDimIntrinsicInfo *getImageDimIntrinsicInfo(unsigned Intr);

const ImageDimIntrinsicInfo *getImageDimInstrinsicByBaseOpcode(unsigned BaseOpcode,
                                                               unsigned Dim);

} // end AMDGPU namespace
} // End llvm namespace

#endif
