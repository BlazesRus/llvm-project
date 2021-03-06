; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -O2 \
; RUN:     -ppc-asm-full-reg-names -mcpu=pwr10 < %s | \
; RUN:     FileCheck --check-prefix=CHECK-LE %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -O2 \
; RUN:     -ppc-asm-full-reg-names -mcpu=pwr10 < %s | \
; RUN:     FileCheck --check-prefix=CHECK-BE %s

; Function Attrs: norecurse nounwind readnone
define  <4 x i32> @test_xxsplti32dx_1(<4 x i32> %a) {
; CHECK-LE-LABEL: test_xxsplti32dx_1:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    xxsplti32dx vs34, 0, 566
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: test_xxsplti32dx_1:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsplti32dx vs34, 1, 566
; CHECK-BE-NEXT:    blr
entry:
  %vecins1 = shufflevector <4 x i32> %a, <4 x i32> <i32 undef, i32 566, i32 undef, i32 566>, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  ret <4 x i32> %vecins1
}

; Function Attrs: norecurse nounwind readnone
define  <4 x i32> @test_xxsplti32dx_2(<4 x i32> %a) {
; CHECK-LE-LABEL: test_xxsplti32dx_2:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    xxsplti32dx vs34, 1, 33
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: test_xxsplti32dx_2:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsplti32dx vs34, 0, 33
; CHECK-BE-NEXT:    blr
entry:
  %vecins1 = shufflevector <4 x i32> <i32 33, i32 undef, i32 33, i32 undef>, <4 x i32> %a, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  ret <4 x i32> %vecins1
}

; Function Attrs: norecurse nounwind readnone
define  <4 x i32> @test_xxsplti32dx_3(<4 x i32> %a) {
; CHECK-LE-LABEL: test_xxsplti32dx_3:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    xxsplti32dx vs34, 0, 12
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: test_xxsplti32dx_3:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsplti32dx vs34, 1, 12
; CHECK-BE-NEXT:    blr
entry:
  %vecins1 = shufflevector <4 x i32> %a, <4 x i32> <i32 undef, i32 12, i32 undef, i32 12>, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  ret <4 x i32> %vecins1
}

; Function Attrs: norecurse nounwind readnone
define  <4 x i32> @test_xxsplti32dx_4(<4 x i32> %a) {
; CHECK-LE-LABEL: test_xxsplti32dx_4:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    xxsplti32dx vs34, 1, -683
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: test_xxsplti32dx_4:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsplti32dx vs34, 0, -683
; CHECK-BE-NEXT:    blr
entry:
  %vecins1 = shufflevector <4 x i32> <i32 -683, i32 undef, i32 -683, i32 undef>, <4 x i32> %a, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  ret <4 x i32> %vecins1
}

; Function Attrs: nounwind
define  <4 x float> @test_xxsplti32dx_5(<4 x float> %vfa) {
; CHECK-LE-LABEL: test_xxsplti32dx_5:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    xxsplti32dx vs34, 0, 1065353216
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: test_xxsplti32dx_5:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsplti32dx vs34, 1, 1065353216
; CHECK-BE-NEXT:    blr
entry:
  %vecins3.i = shufflevector <4 x float> %vfa, <4 x float> <float undef, float 1.000000e+00, float undef, float 1.000000e+00>, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  ret <4 x float> %vecins3.i
}

; Function Attrs: nounwind
define  <4 x float> @test_xxsplti32dx_6(<4 x float> %vfa) {
; CHECK-LE-LABEL: test_xxsplti32dx_6:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    xxsplti32dx vs34, 1, 1073741824
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: test_xxsplti32dx_6:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsplti32dx vs34, 0, 1073741824
; CHECK-BE-NEXT:    blr
entry:
  %vecins3.i = shufflevector <4 x float> <float 2.000000e+00, float undef, float 2.000000e+00, float undef>, <4 x float> %vfa, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  ret <4 x float> %vecins3.i
}

; Function Attrs: norecurse nounwind readnone
; Test to illustrate when the splat is narrower than 32-bits.
define dso_local <4 x i32> @test_xxsplti32dx_7(<4 x i32> %a) local_unnamed_addr #0 {
; CHECK-LE-LABEL: test_xxsplti32dx_7:
; CHECK-LE:       # %bb.0: # %entry
; CHECK-LE-NEXT:    xxsplti32dx vs34, 1, -1414812757
; CHECK-LE-NEXT:    blr
;
; CHECK-BE-LABEL: test_xxsplti32dx_7:
; CHECK-BE:       # %bb.0: # %entry
; CHECK-BE-NEXT:    xxsplti32dx vs34, 0, -1414812757
; CHECK-BE-NEXT:    blr
entry:
  %vecins1 = shufflevector <4 x i32> <i32 -1414812757, i32 undef, i32 -1414812757, i32 undef>, <4 x i32> %a, <4 x i32> <i32 0, i32 5, i32 2, i32 7>
  ret <4 x i32> %vecins1
}
