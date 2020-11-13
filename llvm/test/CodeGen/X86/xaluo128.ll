; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-darwin-unknown < %s | FileCheck %s --check-prefix=SDAG --check-prefix=X64
; RUN: llc -mtriple=i686-darwin-unknown < %s | FileCheck %s --check-prefix=SDAG --check-prefix=X86

define zeroext i1 @saddoi128(i128 %v1, i128 %v2, i128* %res) nounwind {
; X64-LABEL: saddoi128:
; X64:       ## %bb.0:
; X64-NEXT:    addq %rdx, %rdi
; X64-NEXT:    adcq %rcx, %rsi
; X64-NEXT:    seto %al
; X64-NEXT:    movq %rdi, (%r8)
; X64-NEXT:    movq %rsi, 8(%r8)
; X64-NEXT:    retq
;
; X86-LABEL: saddoi128:
; X86:       ## %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    addl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    seto %al
; X86-NEXT:    movl %edi, (%ecx)
; X86-NEXT:    movl %ebx, 4(%ecx)
; X86-NEXT:    movl %esi, 8(%ecx)
; X86-NEXT:    movl %edx, 12(%ecx)
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
  %t = call {i128, i1} @llvm.sadd.with.overflow.i128(i128 %v1, i128 %v2)
  %val = extractvalue {i128, i1} %t, 0
  %obit = extractvalue {i128, i1} %t, 1
  store i128 %val, i128* %res
  ret i1 %obit
}

define zeroext i1 @uaddoi128(i128 %v1, i128 %v2, i128* %res) nounwind {
; X64-LABEL: uaddoi128:
; X64:       ## %bb.0:
; X64-NEXT:    addq %rdx, %rdi
; X64-NEXT:    adcq %rcx, %rsi
; X64-NEXT:    setb %al
; X64-NEXT:    movq %rdi, (%r8)
; X64-NEXT:    movq %rsi, 8(%r8)
; X64-NEXT:    retq
;
; X86-LABEL: uaddoi128:
; X86:       ## %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    addl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    setb %al
; X86-NEXT:    movl %edi, (%ecx)
; X86-NEXT:    movl %ebx, 4(%ecx)
; X86-NEXT:    movl %esi, 8(%ecx)
; X86-NEXT:    movl %edx, 12(%ecx)
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
  %t = call {i128, i1} @llvm.uadd.with.overflow.i128(i128 %v1, i128 %v2)
  %val = extractvalue {i128, i1} %t, 0
  %obit = extractvalue {i128, i1} %t, 1
  store i128 %val, i128* %res
  ret i1 %obit
}


define zeroext i1 @ssuboi128(i128 %v1, i128 %v2, i128* %res) nounwind {
; X64-LABEL: ssuboi128:
; X64:       ## %bb.0:
; X64-NEXT:    subq %rdx, %rdi
; X64-NEXT:    sbbq %rcx, %rsi
; X64-NEXT:    seto %al
; X64-NEXT:    movq %rdi, (%r8)
; X64-NEXT:    movq %rsi, 8(%r8)
; X64-NEXT:    retq
;
; X86-LABEL: ssuboi128:
; X86:       ## %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    seto %al
; X86-NEXT:    movl %edi, (%ecx)
; X86-NEXT:    movl %ebx, 4(%ecx)
; X86-NEXT:    movl %esi, 8(%ecx)
; X86-NEXT:    movl %edx, 12(%ecx)
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
  %t = call {i128, i1} @llvm.ssub.with.overflow.i128(i128 %v1, i128 %v2)
  %val = extractvalue {i128, i1} %t, 0
  %obit = extractvalue {i128, i1} %t, 1
  store i128 %val, i128* %res
  ret i1 %obit
}

define zeroext i1 @usuboi128(i128 %v1, i128 %v2, i128* %res) nounwind {
; X64-LABEL: usuboi128:
; X64:       ## %bb.0:
; X64-NEXT:    subq %rdx, %rdi
; X64-NEXT:    sbbq %rcx, %rsi
; X64-NEXT:    setb %al
; X64-NEXT:    movq %rdi, (%r8)
; X64-NEXT:    movq %rsi, 8(%r8)
; X64-NEXT:    retq
;
; X86-LABEL: usuboi128:
; X86:       ## %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %ebx
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    setb %al
; X86-NEXT:    movl %edi, (%ecx)
; X86-NEXT:    movl %ebx, 4(%ecx)
; X86-NEXT:    movl %esi, 8(%ecx)
; X86-NEXT:    movl %edx, 12(%ecx)
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
  %t = call {i128, i1} @llvm.usub.with.overflow.i128(i128 %v1, i128 %v2)
  %val = extractvalue {i128, i1} %t, 0
  %obit = extractvalue {i128, i1} %t, 1
  store i128 %val, i128* %res
  ret i1 %obit
}

declare {i128, i1} @llvm.sadd.with.overflow.i128(i128, i128) nounwind readnone
declare {i128, i1} @llvm.uadd.with.overflow.i128(i128, i128) nounwind readnone
declare {i128, i1} @llvm.ssub.with.overflow.i128(i128, i128) nounwind readnone
declare {i128, i1} @llvm.usub.with.overflow.i128(i128, i128) nounwind readnone
