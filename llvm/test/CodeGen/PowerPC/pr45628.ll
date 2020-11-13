; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mcpu=pwr9 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu -verify-machineinstrs < %s | FileCheck  %s \
; RUN:   -check-prefix=P9-VSX
; RUN: llc -mcpu=pwr9 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu -verify-machineinstrs -mattr=-vsx < %s | FileCheck  %s \
; RUN:   -check-prefix=P9-NOVSX
; RUN: llc -mcpu=pwr8 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu -verify-machineinstrs < %s | FileCheck  %s \
; RUN:   -check-prefix=P8-VSX
; RUN: llc -mcpu=pwr8 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr \
; RUN:   -mtriple=powerpc64le-unknown-linux-gnu -verify-machineinstrs -mattr=-vsx < %s | FileCheck  %s \
; RUN:   -check-prefix=P8-NOVSX

define <1 x i128> @rotl_64(<1 x i128> %num) {
; P9-VSX-LABEL: rotl_64:
; P9-VSX:       # %bb.0: # %entry
; P9-VSX-NEXT:    xxswapd v2, v2
; P9-VSX-NEXT:    blr
;
; P9-NOVSX-LABEL: rotl_64:
; P9-NOVSX:       # %bb.0: # %entry
; P9-NOVSX-NEXT:    vsldoi v2, v2, v2, 8
; P9-NOVSX-NEXT:    blr
;
; P8-VSX-LABEL: rotl_64:
; P8-VSX:       # %bb.0: # %entry
; P8-VSX-NEXT:    xxswapd v2, v2
; P8-VSX-NEXT:    blr
;
; P8-NOVSX-LABEL: rotl_64:
; P8-NOVSX:       # %bb.0: # %entry
; P8-NOVSX-NEXT:    vsldoi v2, v2, v2, 8
; P8-NOVSX-NEXT:    blr
entry:
  %shl = shl <1 x i128> %num, <i128 64>
  %shr = lshr <1 x i128> %num, <i128 64>
  %or = or <1 x i128> %shl, %shr
  ret <1 x i128> %or
}

define <1 x i128> @rotl_32(<1 x i128> %num) {
; P9-VSX-LABEL: rotl_32:
; P9-VSX:       # %bb.0: # %entry
; P9-VSX-NEXT:    xxsldwi v2, v2, v2, 3
; P9-VSX-NEXT:    blr
;
; P9-NOVSX-LABEL: rotl_32:
; P9-NOVSX:       # %bb.0: # %entry
; P9-NOVSX-NEXT:    vsldoi v2, v2, v2, 12
; P9-NOVSX-NEXT:    blr
;
; P8-VSX-LABEL: rotl_32:
; P8-VSX:       # %bb.0: # %entry
; P8-VSX-NEXT:    xxsldwi v2, v2, v2, 3
; P8-VSX-NEXT:    blr
;
; P8-NOVSX-LABEL: rotl_32:
; P8-NOVSX:       # %bb.0: # %entry
; P8-NOVSX-NEXT:    vsldoi v2, v2, v2, 12
; P8-NOVSX-NEXT:    blr
entry:
  %shl = shl <1 x i128> %num, <i128 32>
  %shr = lshr <1 x i128> %num, <i128 96>
  %or = or <1 x i128> %shl, %shr
  ret <1 x i128> %or
}

define <1 x i128> @rotl_96(<1 x i128> %num) {
; P9-VSX-LABEL: rotl_96:
; P9-VSX:       # %bb.0: # %entry
; P9-VSX-NEXT:    xxsldwi v2, v2, v2, 1
; P9-VSX-NEXT:    blr
;
; P9-NOVSX-LABEL: rotl_96:
; P9-NOVSX:       # %bb.0: # %entry
; P9-NOVSX-NEXT:    vsldoi v2, v2, v2, 4
; P9-NOVSX-NEXT:    blr
;
; P8-VSX-LABEL: rotl_96:
; P8-VSX:       # %bb.0: # %entry
; P8-VSX-NEXT:    xxsldwi v2, v2, v2, 1
; P8-VSX-NEXT:    blr
;
; P8-NOVSX-LABEL: rotl_96:
; P8-NOVSX:       # %bb.0: # %entry
; P8-NOVSX-NEXT:    vsldoi v2, v2, v2, 4
; P8-NOVSX-NEXT:    blr
entry:
  %shl = shl <1 x i128> %num, <i128 96>
  %shr = lshr <1 x i128> %num, <i128 32>
  %or = or <1 x i128> %shl, %shr
  ret <1 x i128> %or
}

define <1 x i128> @rotl_16(<1 x i128> %num) {
; P9-VSX-LABEL: rotl_16:
; P9-VSX:       # %bb.0: # %entry
; P9-VSX-NEXT:    vsldoi v2, v2, v2, 14
; P9-VSX-NEXT:    blr
;
; P9-NOVSX-LABEL: rotl_16:
; P9-NOVSX:       # %bb.0: # %entry
; P9-NOVSX-NEXT:    vsldoi v2, v2, v2, 14
; P9-NOVSX-NEXT:    blr
;
; P8-VSX-LABEL: rotl_16:
; P8-VSX:       # %bb.0: # %entry
; P8-VSX-NEXT:    vsldoi v2, v2, v2, 14
; P8-VSX-NEXT:    blr
;
; P8-NOVSX-LABEL: rotl_16:
; P8-NOVSX:       # %bb.0: # %entry
; P8-NOVSX-NEXT:    vsldoi v2, v2, v2, 14
; P8-NOVSX-NEXT:    blr
entry:
  %shl = shl <1 x i128> %num, <i128 16>
  %shr = lshr <1 x i128> %num, <i128 112>
  %or = or <1 x i128> %shl, %shr
  ret <1 x i128> %or
}

define <1 x i128> @rotl_112(<1 x i128> %num) {
; P9-VSX-LABEL: rotl_112:
; P9-VSX:       # %bb.0: # %entry
; P9-VSX-NEXT:    vsldoi v2, v2, v2, 2
; P9-VSX-NEXT:    blr
;
; P9-NOVSX-LABEL: rotl_112:
; P9-NOVSX:       # %bb.0: # %entry
; P9-NOVSX-NEXT:    vsldoi v2, v2, v2, 2
; P9-NOVSX-NEXT:    blr
;
; P8-VSX-LABEL: rotl_112:
; P8-VSX:       # %bb.0: # %entry
; P8-VSX-NEXT:    vsldoi v2, v2, v2, 2
; P8-VSX-NEXT:    blr
;
; P8-NOVSX-LABEL: rotl_112:
; P8-NOVSX:       # %bb.0: # %entry
; P8-NOVSX-NEXT:    vsldoi v2, v2, v2, 2
; P8-NOVSX-NEXT:    blr
entry:
  %shl = shl <1 x i128> %num, <i128 112>
  %shr = lshr <1 x i128> %num, <i128 16>
  %or = or <1 x i128> %shl, %shr
  ret <1 x i128> %or
}

define <1 x i128> @rotl_8(<1 x i128> %num) {
; P9-VSX-LABEL: rotl_8:
; P9-VSX:       # %bb.0: # %entry
; P9-VSX-NEXT:    vsldoi v2, v2, v2, 15
; P9-VSX-NEXT:    blr
;
; P9-NOVSX-LABEL: rotl_8:
; P9-NOVSX:       # %bb.0: # %entry
; P9-NOVSX-NEXT:    vsldoi v2, v2, v2, 15
; P9-NOVSX-NEXT:    blr
;
; P8-VSX-LABEL: rotl_8:
; P8-VSX:       # %bb.0: # %entry
; P8-VSX-NEXT:    vsldoi v2, v2, v2, 15
; P8-VSX-NEXT:    blr
;
; P8-NOVSX-LABEL: rotl_8:
; P8-NOVSX:       # %bb.0: # %entry
; P8-NOVSX-NEXT:    vsldoi v2, v2, v2, 15
; P8-NOVSX-NEXT:    blr
entry:
  %shl = shl <1 x i128> %num, <i128 8>
  %shr = lshr <1 x i128> %num, <i128 120>
  %or = or <1 x i128> %shl, %shr
  ret <1 x i128> %or
}

define <1 x i128> @rotl_120(<1 x i128> %num) {
; P9-VSX-LABEL: rotl_120:
; P9-VSX:       # %bb.0: # %entry
; P9-VSX-NEXT:    vsldoi v2, v2, v2, 1
; P9-VSX-NEXT:    blr
;
; P9-NOVSX-LABEL: rotl_120:
; P9-NOVSX:       # %bb.0: # %entry
; P9-NOVSX-NEXT:    vsldoi v2, v2, v2, 1
; P9-NOVSX-NEXT:    blr
;
; P8-VSX-LABEL: rotl_120:
; P8-VSX:       # %bb.0: # %entry
; P8-VSX-NEXT:    vsldoi v2, v2, v2, 1
; P8-VSX-NEXT:    blr
;
; P8-NOVSX-LABEL: rotl_120:
; P8-NOVSX:       # %bb.0: # %entry
; P8-NOVSX-NEXT:    vsldoi v2, v2, v2, 1
; P8-NOVSX-NEXT:    blr
entry:
  %shl = shl <1 x i128> %num, <i128 120>
  %shr = lshr <1 x i128> %num, <i128 8>
  %or = or <1 x i128> %shl, %shr
  ret <1 x i128> %or
}

define <1 x i128> @rotl_28(<1 x i128> %num) {
; P9-VSX-LABEL: rotl_28:
; P9-VSX:       # %bb.0: # %entry
; P9-VSX-NEXT:    mfvsrld r4, v2
; P9-VSX-NEXT:    mfvsrd r3, v2
; P9-VSX-NEXT:    rotldi r5, r4, 28
; P9-VSX-NEXT:    rldimi r5, r3, 28, 0
; P9-VSX-NEXT:    rotldi r3, r3, 28
; P9-VSX-NEXT:    rldimi r3, r4, 28, 0
; P9-VSX-NEXT:    mtvsrdd v2, r5, r3
; P9-VSX-NEXT:    blr
;
; P9-NOVSX-LABEL: rotl_28:
; P9-NOVSX:       # %bb.0: # %entry
; P9-NOVSX-NEXT:    addi r3, r1, -32
; P9-NOVSX-NEXT:    stvx v2, 0, r3
; P9-NOVSX-NEXT:    ld r4, -32(r1)
; P9-NOVSX-NEXT:    ld r3, -24(r1)
; P9-NOVSX-NEXT:    rotldi r5, r4, 28
; P9-NOVSX-NEXT:    rldimi r5, r3, 28, 0
; P9-NOVSX-NEXT:    rotldi r3, r3, 28
; P9-NOVSX-NEXT:    rldimi r3, r4, 28, 0
; P9-NOVSX-NEXT:    std r5, -8(r1)
; P9-NOVSX-NEXT:    std r3, -16(r1)
; P9-NOVSX-NEXT:    addi r3, r1, -16
; P9-NOVSX-NEXT:    lvx v2, 0, r3
; P9-NOVSX-NEXT:    blr
;
; P8-VSX-LABEL: rotl_28:
; P8-VSX:       # %bb.0: # %entry
; P8-VSX-NEXT:    xxswapd vs0, v2
; P8-VSX-NEXT:    mfvsrd r3, v2
; P8-VSX-NEXT:    rotldi r5, r3, 28
; P8-VSX-NEXT:    mffprd r4, f0
; P8-VSX-NEXT:    rldimi r5, r4, 28, 0
; P8-VSX-NEXT:    rotldi r4, r4, 28
; P8-VSX-NEXT:    rldimi r4, r3, 28, 0
; P8-VSX-NEXT:    mtfprd f0, r5
; P8-VSX-NEXT:    mtfprd f1, r4
; P8-VSX-NEXT:    xxmrghd v2, vs1, vs0
; P8-VSX-NEXT:    blr
;
; P8-NOVSX-LABEL: rotl_28:
; P8-NOVSX:       # %bb.0: # %entry
; P8-NOVSX-NEXT:    addi r3, r1, -32
; P8-NOVSX-NEXT:    stvx v2, 0, r3
; P8-NOVSX-NEXT:    ld r3, -24(r1)
; P8-NOVSX-NEXT:    ld r4, -32(r1)
; P8-NOVSX-NEXT:    rotldi r5, r4, 28
; P8-NOVSX-NEXT:    rotldi r6, r3, 28
; P8-NOVSX-NEXT:    rldimi r5, r3, 28, 0
; P8-NOVSX-NEXT:    rldimi r6, r4, 28, 0
; P8-NOVSX-NEXT:    addi r3, r1, -16
; P8-NOVSX-NEXT:    std r5, -8(r1)
; P8-NOVSX-NEXT:    std r6, -16(r1)
; P8-NOVSX-NEXT:    lvx v2, 0, r3
; P8-NOVSX-NEXT:    blr
entry:
  %shl = shl <1 x i128> %num, <i128 28>
  %shr = lshr <1 x i128> %num, <i128 100>
  %or = or <1 x i128> %shl, %shr
  ret <1 x i128> %or
}

define <1 x i128> @NO_rotl(<1 x i128> %num) {
; P9-VSX-LABEL: NO_rotl:
; P9-VSX:       # %bb.0: # %entry
; P9-VSX-NEXT:    addis r3, r2, .LCPI8_0@toc@ha
; P9-VSX-NEXT:    addi r3, r3, .LCPI8_0@toc@l
; P9-VSX-NEXT:    lxvx v3, 0, r3
; P9-VSX-NEXT:    addis r3, r2, .LCPI8_1@toc@ha
; P9-VSX-NEXT:    addi r3, r3, .LCPI8_1@toc@l
; P9-VSX-NEXT:    vslo v4, v2, v3
; P9-VSX-NEXT:    vspltb v3, v3, 15
; P9-VSX-NEXT:    vsl v3, v4, v3
; P9-VSX-NEXT:    lxvx v4, 0, r3
; P9-VSX-NEXT:    vsro v2, v2, v4
; P9-VSX-NEXT:    vspltb v4, v4, 15
; P9-VSX-NEXT:    vsr v2, v2, v4
; P9-VSX-NEXT:    xxlor v2, v3, v2
; P9-VSX-NEXT:    blr
;
; P9-NOVSX-LABEL: NO_rotl:
; P9-NOVSX:       # %bb.0: # %entry
; P9-NOVSX-NEXT:    addis r3, r2, .LCPI8_0@toc@ha
; P9-NOVSX-NEXT:    addi r3, r3, .LCPI8_0@toc@l
; P9-NOVSX-NEXT:    lvx v3, 0, r3
; P9-NOVSX-NEXT:    addis r3, r2, .LCPI8_1@toc@ha
; P9-NOVSX-NEXT:    addi r3, r3, .LCPI8_1@toc@l
; P9-NOVSX-NEXT:    vslo v4, v2, v3
; P9-NOVSX-NEXT:    vspltb v3, v3, 15
; P9-NOVSX-NEXT:    vsl v3, v4, v3
; P9-NOVSX-NEXT:    lvx v4, 0, r3
; P9-NOVSX-NEXT:    vsro v2, v2, v4
; P9-NOVSX-NEXT:    vspltb v4, v4, 15
; P9-NOVSX-NEXT:    vsr v2, v2, v4
; P9-NOVSX-NEXT:    vor v2, v3, v2
; P9-NOVSX-NEXT:    blr
;
; P8-VSX-LABEL: NO_rotl:
; P8-VSX:       # %bb.0: # %entry
; P8-VSX-NEXT:    xxswapd vs0, v2
; P8-VSX-NEXT:    li r3, 0
; P8-VSX-NEXT:    mfvsrd r5, v2
; P8-VSX-NEXT:    mffprd r4, f0
; P8-VSX-NEXT:    mtfprd f0, r3
; P8-VSX-NEXT:    rotldi r3, r4, 20
; P8-VSX-NEXT:    sldi r4, r4, 20
; P8-VSX-NEXT:    rldimi r3, r5, 20, 0
; P8-VSX-NEXT:    mtfprd f1, r4
; P8-VSX-NEXT:    rldicl r4, r5, 28, 36
; P8-VSX-NEXT:    mtfprd f2, r3
; P8-VSX-NEXT:    mtfprd f3, r4
; P8-VSX-NEXT:    xxmrghd v2, vs2, vs1
; P8-VSX-NEXT:    xxmrghd v3, vs0, vs3
; P8-VSX-NEXT:    xxlor v2, v2, v3
; P8-VSX-NEXT:    blr
;
; P8-NOVSX-LABEL: NO_rotl:
; P8-NOVSX:       # %bb.0: # %entry
; P8-NOVSX-NEXT:    addis r3, r2, .LCPI8_0@toc@ha
; P8-NOVSX-NEXT:    addis r4, r2, .LCPI8_1@toc@ha
; P8-NOVSX-NEXT:    addi r3, r3, .LCPI8_0@toc@l
; P8-NOVSX-NEXT:    lvx v3, 0, r3
; P8-NOVSX-NEXT:    addi r3, r4, .LCPI8_1@toc@l
; P8-NOVSX-NEXT:    lvx v4, 0, r3
; P8-NOVSX-NEXT:    vslo v5, v2, v3
; P8-NOVSX-NEXT:    vspltb v3, v3, 15
; P8-NOVSX-NEXT:    vsro v2, v2, v4
; P8-NOVSX-NEXT:    vspltb v4, v4, 15
; P8-NOVSX-NEXT:    vsl v3, v5, v3
; P8-NOVSX-NEXT:    vsr v2, v2, v4
; P8-NOVSX-NEXT:    vor v2, v3, v2
; P8-NOVSX-NEXT:    blr
entry:
  %shl = shl <1 x i128> %num, <i128 20>
  %shr = lshr <1 x i128> %num, <i128 100>
  %or = or <1 x i128> %shl, %shr
  ret <1 x i128> %or
}

define <1 x i128> @shufflevector(<1 x i128> %num) {
; P9-VSX-LABEL: shufflevector:
; P9-VSX:       # %bb.0: # %entry
; P9-VSX-NEXT:    xxswapd v2, v2
; P9-VSX-NEXT:    blr
;
; P9-NOVSX-LABEL: shufflevector:
; P9-NOVSX:       # %bb.0: # %entry
; P9-NOVSX-NEXT:    vsldoi v2, v2, v2, 8
; P9-NOVSX-NEXT:    blr
;
; P8-VSX-LABEL: shufflevector:
; P8-VSX:       # %bb.0: # %entry
; P8-VSX-NEXT:    xxswapd v2, v2
; P8-VSX-NEXT:    blr
;
; P8-NOVSX-LABEL: shufflevector:
; P8-NOVSX:       # %bb.0: # %entry
; P8-NOVSX-NEXT:    vsldoi v2, v2, v2, 8
; P8-NOVSX-NEXT:    blr
entry:
  %0 = bitcast <1 x i128> %num to <2 x i64>
  %vecins2 = shufflevector <2 x i64> %0, <2 x i64> undef, <2 x i32> <i32 1, i32 0>
  %1 = bitcast <2 x i64> %vecins2 to <1 x i128>
  ret <1 x i128> %1
}
