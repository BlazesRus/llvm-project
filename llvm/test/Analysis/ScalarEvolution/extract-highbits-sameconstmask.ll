; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -S -analyze -enable-new-pm=0 -scalar-evolution < %s | FileCheck %s
; RUN: opt -S -disable-output "-passes=print<scalar-evolution>" < %s 2>&1 | FileCheck %s

; The obvious case.
define i32 @div(i32 %val) nounwind {
; CHECK-LABEL: 'div'
; CHECK-NEXT:  Classifying expressions for: @div
; CHECK-NEXT:    %tmp1 = udiv i32 %val, 16
; CHECK-NEXT:    -->  (%val /u 16) U: [0,268435456) S: [0,268435456)
; CHECK-NEXT:    %tmp2 = mul i32 %tmp1, 16
; CHECK-NEXT:    -->  (16 * (%val /u 16))<nuw> U: [0,-15) S: [-2147483648,2147483633)
; CHECK-NEXT:  Determining loop execution counts for: @div
;
  %tmp1 = udiv i32 %val, 16
  %tmp2 = mul i32 %tmp1, 16
  ret i32 %tmp2
}

define i32 @sdiv(i32 %val) nounwind {
; CHECK-LABEL: 'sdiv'
; CHECK-NEXT:  Classifying expressions for: @sdiv
; CHECK-NEXT:    %tmp1 = sdiv i32 %val, 16
; CHECK-NEXT:    -->  %tmp1 U: full-set S: [-134217728,134217728)
; CHECK-NEXT:    %tmp2 = mul i32 %tmp1, 16
; CHECK-NEXT:    -->  (16 * %tmp1)<nsw> U: [0,-15) S: [-2147483648,2147483633)
; CHECK-NEXT:  Determining loop execution counts for: @sdiv
;
  %tmp1 = sdiv i32 %val, 16
  %tmp2 = mul i32 %tmp1, 16
  ret i32 %tmp2
}

; Or, it could be a number of equivalent patterns with mask:
;   b) x &  (-1 << nbits)
;   d) x >> nbits << nbits

define i32 @mask_b(i32 %val) nounwind {
; CHECK-LABEL: 'mask_b'
; CHECK-NEXT:  Classifying expressions for: @mask_b
; CHECK-NEXT:    %masked = and i32 %val, -16
; CHECK-NEXT:    -->  (16 * (%val /u 16))<nuw> U: [0,-15) S: [-2147483648,2147483633)
; CHECK-NEXT:  Determining loop execution counts for: @mask_b
;
  %masked = and i32 %val, -16
  ret i32 %masked
}

define i32 @mask_d(i32 %val) nounwind {
; CHECK-LABEL: 'mask_d'
; CHECK-NEXT:  Classifying expressions for: @mask_d
; CHECK-NEXT:    %lowbitscleared = lshr i32 %val, 4
; CHECK-NEXT:    -->  (%val /u 16) U: [0,268435456) S: [0,268435456)
; CHECK-NEXT:    %masked = shl i32 %lowbitscleared, 4
; CHECK-NEXT:    -->  (16 * (%val /u 16))<nuw> U: [0,-15) S: [-2147483648,2147483633)
; CHECK-NEXT:  Determining loop execution counts for: @mask_d
;
  %lowbitscleared = lshr i32 %val, 4
  %masked = shl i32 %lowbitscleared, 4
  ret i32 %masked
}
