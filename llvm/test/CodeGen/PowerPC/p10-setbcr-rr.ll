; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -O2 \
; RUN:     -ppc-asm-full-reg-names -mcpu=pwr10 < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,CHECK-LE
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -O2 \
; RUN:     -ppc-asm-full-reg-names -mcpu=pwr10 < %s | FileCheck %s \
; RUN:     --check-prefixes=CHECK,CHECK-BE

; This file does not contain many test cases involving comparisons and logical
; comparisons (cmplwi, cmpldi). This is because alternative code is generated
; when there is a compare (logical or not), followed by a sign or zero extend.
; This codegen will be re-evaluated at a later time on whether or not it should
; be emitted on P10.

@globalVal = common local_unnamed_addr global i8 0, align 1
@globalVal2 = common local_unnamed_addr global i32 0, align 4
@globalVal3 = common local_unnamed_addr global i64 0, align 8
@globalVal4 = common local_unnamed_addr global i16 0, align 2


define signext i32 @setbcr1(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: setbcr1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sge i32 %a, %b
  %lnot.ext = zext i1 %cmp to i32
  ret i32 %lnot.ext
}


define signext i32 @setbcr2(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: setbcr2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sle i32 %a, %b
  %lnot.ext = zext i1 %cmp to i32
  ret i32 %lnot.ext
}


define signext i32 @setbcr3(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: setbcr3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i32 %a, %b
  %lnot.ext = zext i1 %cmp to i32
  ret i32 %lnot.ext
}


define signext i32 @setbcr4(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: setbcr4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sge i8 %a, %b
  %conv2 = zext i1 %cmp to i32
  ret i32 %conv2
}


define void @setbcr5(i8 signext %a, i8 signext %b) {
; CHECK-LE-LABEL: setbcr5:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, lt
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr5:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC0@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC0@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, lt
; CHECK-BE-NEXT:    stb r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sge i8 %a, %b
  %conv3 = zext i1 %cmp to i8
  store i8 %conv3, i8* @globalVal, align 1
  ret void
}


define void @setbcr6(i32 signext %a, i32 signext %b) {
; CHECK-LE-LABEL: setbcr6:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, lt
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr6:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC1@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC1@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, lt
; CHECK-BE-NEXT:    stw r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sge i32 %a, %b
  %conv = zext i1 %cmp to i32
  store i32 %conv, i32* @globalVal2, align 4
  ret void
}


define signext i32 @setbcr7(i64 %a, i64 %b) {
; CHECK-LABEL: setbcr7:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setbcr r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sge i64 %a, %b
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}


define signext i64 @setbcr8(i64 %a, i64 %b) {
; CHECK-LABEL: setbcr8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setbcr r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sge i64 %a, %b
  %conv = zext i1 %cmp to i64
  ret i64 %conv
}


define void @setbcr9(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setbcr9:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpd r3, r4
; CHECK-LE-NEXT:    setbcr r3, lt
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr9:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpd r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC2@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC2@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, lt
; CHECK-BE-NEXT:    std r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sge i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, i64* @globalVal3, align 8
  ret void
}


define signext i32 @setbcr10(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: setbcr10:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sge i16 %a, %b
  %conv2 = zext i1 %cmp to i32
  ret i32 %conv2
}


define void @setbcr11(i16 signext %a, i16 signext %b) {
; CHECK-LE-LABEL: setbcr11:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, lt
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr11:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC3@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC3@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, lt
; CHECK-BE-NEXT:    sth r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sge i16 %a, %b
  %conv3 = zext i1 %cmp to i16
  store i16 %conv3, i16* @globalVal4, align 2
  ret void
}


define signext i32 @setbcr12(i64 %a, i64 %b) {
; CHECK-LABEL: setbcr12:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpld r3, r4
; CHECK-NEXT:    setbcr r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i64 %a, %b
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}


define void @setbcr13(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setbcr13:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpld r3, r4
; CHECK-LE-NEXT:    setbcr r3, lt
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr13:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpld r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC2@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC2@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, lt
; CHECK-BE-NEXT:    std r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp uge i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, i64* @globalVal3
  ret void
}


define signext i32 @setbcr14(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: setbcr14:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sle i8 %a, %b
  %conv2 = zext i1 %cmp to i32
  ret i32 %conv2
}


define void @setbcr15(i8 signext %a, i8 signext %b) {
; CHECK-LE-LABEL: setbcr15:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, gt
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr15:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC0@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC0@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, gt
; CHECK-BE-NEXT:    stb r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sle i8 %a, %b
  %conv3 = zext i1 %cmp to i8
  store i8 %conv3, i8* @globalVal, align 1
  ret void
}


define signext i32 @setbcr16(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: setbcr16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sle i32 %a, %b
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}


define void @setbcr17(i32 signext %a, i32 signext %b) {
; CHECK-LE-LABEL: setbcr17:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, gt
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr17:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC1@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC1@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, gt
; CHECK-BE-NEXT:    stw r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sle i32 %a, %b
  %conv = zext i1 %cmp to i32
  store i32 %conv, i32* @globalVal2, align 4
  ret void
}


define signext i32 @setbcr18(i64 %a, i64 %b) {
; CHECK-LABEL: setbcr18:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setbcr r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sle i64 %a, %b
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}


define void @setbcr19(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setbcr19:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpd r3, r4
; CHECK-LE-NEXT:    setbcr r3, gt
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr19:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpd r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC2@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC2@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, gt
; CHECK-BE-NEXT:    std r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sle i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, i64* @globalVal3, align 8
  ret void
}


define signext i32 @setbcr20(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: setbcr20:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sle i16 %a, %b
  %conv2 = zext i1 %cmp to i32
  ret i32 %conv2
}


define void @setbcr21(i16 signext %a, i16 signext %b) {
; CHECK-LE-LABEL: setbcr21:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, gt
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr21:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC3@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC3@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, gt
; CHECK-BE-NEXT:    sth r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sle i16 %a, %b
  %conv3 = zext i1 %cmp to i16
  store i16 %conv3, i16* @globalVal4, align 2
  ret void
}


define signext i32 @setbcr22(i64 %a, i64 %b) {
; CHECK-LABEL: setbcr22:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpld r3, r4
; CHECK-NEXT:    setbcr r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ule i64 %a, %b
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}


define void @setbcr23(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setbcr23:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpld r3, r4
; CHECK-LE-NEXT:    setbcr r3, gt
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr23:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpld r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC2@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC2@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, gt
; CHECK-BE-NEXT:    std r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ule i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, i64* @globalVal3
  ret void
}

define signext i32 @setbcr24(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: setbcr24:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i8 %a, %b
  %conv2 = zext i1 %cmp to i32
  ret i32 %conv2
}

define void @setbcr25(i8 signext %a, i8 signext %b) {
; CHECK-LE-LABEL: setbcr25:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, eq
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr25:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC0@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC0@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, eq
; CHECK-BE-NEXT:    stb r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ne i8 %a, %b
  %conv3 = zext i1 %cmp to i8
  store i8 %conv3, i8* @globalVal, align 1
  ret void
}

define void @setbcr26(i32 signext %a, i32 signext %b) {
; CHECK-LE-LABEL: setbcr26:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, eq
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr26:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC1@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC1@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, eq
; CHECK-BE-NEXT:    stw r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ne i32 %a, %b
  %conv = zext i1 %cmp to i32
  store i32 %conv, i32* @globalVal2, align 4
  ret void
}

define signext i32 @setbcr27(i64 %a, i64 %b) {
; CHECK-LABEL: setbcr27:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setbcr r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i64 %a, %b
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define void @setbcr28(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setbcr28:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpd r3, r4
; CHECK-LE-NEXT:    setbcr r3, eq
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr28:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpd r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC2@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC2@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, eq
; CHECK-BE-NEXT:    std r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ne i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, i64* @globalVal3, align 8
  ret void
}

define signext i32 @setbcr29(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: setbcr29:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i16 %a, %b
  %conv2 = zext i1 %cmp to i32
  ret i32 %conv2
}

define void @setbcr30(i16 signext %a, i16 signext %b) {
; CHECK-LE-LABEL: setbcr30:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, eq
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr30:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC3@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC3@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, eq
; CHECK-BE-NEXT:    sth r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ne i16 %a, %b
  %conv3 = zext i1 %cmp to i16
  store i16 %conv3, i16* @globalVal4, align 2
  ret void
}

define signext i32 @setbcr31(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: setbcr31:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i8 %a, %b
  %conv2 = zext i1 %cmp to i32
  ret i32 %conv2
}

define void @setbcr32(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LE-LABEL: setbcr32:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, eq
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr32:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC0@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC0@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, eq
; CHECK-BE-NEXT:    stb r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ne i8 %a, %b
  %conv3 = zext i1 %cmp to i8
  store i8 %conv3, i8* @globalVal, align 1
  ret void
}

define signext i32 @setbcr33(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LABEL: setbcr33:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i32 %a, %b
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

define void @setbcr34(i32 zeroext %a, i32 zeroext %b) {
; CHECK-LE-LABEL: setbcr34:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, eq
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr34:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC1@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC1@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, eq
; CHECK-BE-NEXT:    stw r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ne i32 %a, %b
  %conv = zext i1 %cmp to i32
  store i32 %conv, i32* @globalVal2, align 4
  ret void
}

define signext i32 @setbcr35(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LABEL: setbcr35:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i16 %a, %b
  %conv2 = zext i1 %cmp to i32
  ret i32 %conv2
}

define void @setbcr36(i16 zeroext %a, i16 zeroext %b) {
; CHECK-LE-LABEL: setbcr36:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, eq
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr36:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC3@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC3@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, eq
; CHECK-BE-NEXT:    sth r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ne i16 %a, %b
  %conv3 = zext i1 %cmp to i16
  store i16 %conv3, i16* @globalVal4, align 2
  ret void
}

define i64 @setbcr37(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: setbcr37:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sge i8 %a, %b
  %conv3 = zext i1 %cmp to i64
  ret i64 %conv3
}

define void @setbcr38(i8 signext %a, i8 signext %b) {
; CHECK-LE-LABEL: setbcr38:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, lt
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr38:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC0@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC0@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, lt
; CHECK-BE-NEXT:    stb r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sge i8 %a, %b
  %conv3 = zext i1 %cmp to i8
  store i8 %conv3, i8* @globalVal, align 1
  ret void
}

define i64 @setbcr39(i32 signext %a, i32 signext %b) {
; CHECK-LABEL: setbcr39:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sge i32 %a, %b
  %conv1 = zext i1 %cmp to i64
  ret i64 %conv1
}

define void @setbcr40(i32 signext %a, i32 signext %b) {
; CHECK-LE-LABEL: setbcr40:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, lt
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr40:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC1@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC1@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, lt
; CHECK-BE-NEXT:    stw r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sge i32 %a, %b
  %conv = zext i1 %cmp to i32
  store i32 %conv, i32* @globalVal2, align 4
  ret void
}

define i64 @setbcr41(i64 %a, i64 %b) {
; CHECK-LABEL: setbcr41:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setbcr r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sge i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  ret i64 %conv1
}

define void @setbcr42(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setbcr42:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpd r3, r4
; CHECK-LE-NEXT:    setbcr r3, lt
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr42:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpd r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC2@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC2@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, lt
; CHECK-BE-NEXT:    std r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sge i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, i64* @globalVal3, align 8
  ret void
}

define i64 @setbcr43(i16 signext %a, i16 signext %b) {
; CHECK-LABEL: setbcr43:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sge i16 %a, %b
  %conv3 = zext i1 %cmp to i64
  ret i64 %conv3
}

define void @setbcr44(i16 signext %a, i16 signext %b) {
; CHECK-LE-LABEL: setbcr44:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, lt
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr44:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC3@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC3@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, lt
; CHECK-BE-NEXT:    sth r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sge i16 %a, %b
  %conv3 = zext i1 %cmp to i16
  store i16 %conv3, i16* @globalVal4, align 2
  ret void
}


define i64 @setbcr45(i64 %a, i64 %b) {
; CHECK-LABEL: setbcr45:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpld r3, r4
; CHECK-NEXT:    setbcr r3, lt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp uge i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  ret i64 %conv1
}


define void @setbcr46(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setbcr46:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpld r3, r4
; CHECK-LE-NEXT:    setbcr r3, lt
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr46:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpld r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC2@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC2@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, lt
; CHECK-BE-NEXT:    std r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp uge i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, i64* @globalVal3
  ret void
}

define i64 @setbcr47(i8 signext %a, i8 signext %b) {
; CHECK-LABEL: setbcr47:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sle i8 %a, %b
  %conv3 = zext i1 %cmp to i64
  ret i64 %conv3
}

define void @setbcr48(i8 signext %a, i8 signext %b) {
; CHECK-LE-LABEL: setbcr48:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, gt
; CHECK-LE-NEXT:    pstb r3, globalVal@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr48:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC0@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC0@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, gt
; CHECK-BE-NEXT:    stb r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sle i8 %a, %b
  %conv3 = zext i1 %cmp to i8
  store i8 %conv3, i8* @globalVal, align 1
  ret void
}

define i64 @setbcr49(i32 signext %a, i32 signext %b)  {
; CHECK-LABEL: setbcr49:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sle i32 %a, %b
  %conv1 = zext i1 %cmp to i64
  ret i64 %conv1
}

define void @setbcr50(i32 signext %a, i32 signext %b) {
; CHECK-LE-LABEL: setbcr50:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, gt
; CHECK-LE-NEXT:    pstw r3, globalVal2@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr50:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC1@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC1@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, gt
; CHECK-BE-NEXT:    stw r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sle i32 %a, %b
  %conv = zext i1 %cmp to i32
  store i32 %conv, i32* @globalVal2, align 4
  ret void
}


define i64 @setbcr51(i64 %a, i64 %b)  {
; CHECK-LABEL: setbcr51:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setbcr r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sle i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  ret i64 %conv1
}


define void @setbcr52(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setbcr52:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpd r3, r4
; CHECK-LE-NEXT:    setbcr r3, gt
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr52:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpd r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC2@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC2@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, gt
; CHECK-BE-NEXT:    std r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sle i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, i64* @globalVal3, align 8
  ret void
}

define i64 @setbcr53(i16 signext %a, i16 signext %b)  {
; CHECK-LABEL: setbcr53:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpw r3, r4
; CHECK-NEXT:    setbcr r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp sle i16 %a, %b
  %conv3 = zext i1 %cmp to i64
  ret i64 %conv3
}

define void @setbcr54(i16 signext %a, i16 signext %b) {
; CHECK-LE-LABEL: setbcr54:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpw r3, r4
; CHECK-LE-NEXT:    setbcr r3, gt
; CHECK-LE-NEXT:    psth r3, globalVal4@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr54:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpw r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC3@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC3@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, gt
; CHECK-BE-NEXT:    sth r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp sle i16 %a, %b
  %conv3 = zext i1 %cmp to i16
  store i16 %conv3, i16* @globalVal4, align 2
  ret void
}


define i64 @setbcr55(i64 %a, i64 %b) {
; CHECK-LABEL: setbcr55:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpld r3, r4
; CHECK-NEXT:    setbcr r3, gt
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ule i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  ret i64 %conv1
}


define void @setbcr56(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setbcr56:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpld r3, r4
; CHECK-LE-NEXT:    setbcr r3, gt
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr56:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpld r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC2@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC2@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, gt
; CHECK-BE-NEXT:    std r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ule i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, i64* @globalVal3
  ret void
}

define i64 @setbcr57(i64 %a, i64 %b) {
; CHECK-LABEL: setbcr57:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setbcr r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  ret i64 %conv1
}

define void @setbcr58(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setbcr58:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpd r3, r4
; CHECK-LE-NEXT:    setbcr r3, eq
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr58:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpd r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC2@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC2@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, eq
; CHECK-BE-NEXT:    std r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ne i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, i64* @globalVal3, align 8
  ret void
}

define i64 @setbcr59(i64 %a, i64 %b) {
; CHECK-LABEL: setbcr59:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpd r3, r4
; CHECK-NEXT:    setbcr r3, eq
; CHECK-NEXT:    blr
entry:
  %cmp = icmp ne i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  ret i64 %conv1
}

define void @setbcr60(i64 %a, i64 %b) {
; CHECK-LE-LABEL: setbcr60:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    cmpd r3, r4
; CHECK-LE-NEXT:    setbcr r3, eq
; CHECK-LE-NEXT:    pstd r3, globalVal3@PCREL(0), 1
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: setbcr60:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    cmpd r3, r4
; CHECK-BE-NEXT:    addis r4, r2, .LC2@toc@ha
; CHECK-BE-NEXT:    ld r4, .LC2@toc@l(r4)
; CHECK-BE-NEXT:    setbcr r3, eq
; CHECK-BE-NEXT:    std r3, 0(r4)
; CHECK-BE-NEXT:    blr
entry:
  %cmp = icmp ne i64 %a, %b
  %conv1 = zext i1 %cmp to i64
  store i64 %conv1, i64* @globalVal3, align 8
  ret void
}
