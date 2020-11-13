; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instsimplify -S | FileCheck %s

; %result = x & (1 ^ sel) = (x & 1) ^ (x & sel)
;         = x ^ (select cond, false, false)
;         = x ^ false = x
;
define i1 @f(i1 %cond, i1 noundef %x, i1 %y, i1 %z) {
; CHECK-LABEL: @f(
; CHECK-NEXT:    ret i1 [[X:%.*]]
;
  %notx = xor i1 %x, 1
  %lhs = and i1 %notx, %y
  %rhs = and i1 %notx, %z
  %sel = select i1 %cond, i1 %lhs, i1 %rhs
  %op1 = xor i1 1, %sel
  %result = and i1 %x, %op1
  ret i1 %result
}

define i1 @f_dontfold(i1 %cond, i1 %x, i1 %y, i1 %z) {
; CHECK-LABEL: @f_dontfold(
; CHECK-NEXT:    ret i1 [[X:%.*]]
;
  %notx = xor i1 %x, 1
  %lhs = and i1 %notx, %y
  %rhs = and i1 %notx, %z
  %sel = select i1 %cond, i1 %lhs, i1 %rhs
  %op1 = xor i1 1, %sel
  %result = and i1 %x, %op1
  ret i1 %result
}
