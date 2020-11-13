//===-- Implementation of isdigit------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "src/ctype/isdigit.h"
#include "src/__support/common.h"
#include "src/ctype/ctype_utils.h"

namespace __llvm_libc {

// TODO: Currently restricted to default locale.
// These should be extended using locale information.
int LLVM_LIBC_ENTRYPOINT(isdigit)(int c) { return internal::isdigit(c); }

} // namespace __llvm_libc
