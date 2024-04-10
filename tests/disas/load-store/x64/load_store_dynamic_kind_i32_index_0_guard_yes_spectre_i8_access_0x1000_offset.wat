;;! target = "x86_64"
;;! test = "compile"
;;! flags = " -C cranelift-enable-heap-access-spectre-mitigation -O static-memory-maximum-size=0 -O static-memory-guard-size=0 -O dynamic-memory-guard-size=0"

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i32 1)

  (func (export "do_store") (param i32 i32)
    local.get 0
    local.get 1
    i32.store8 offset=0x1000)

  (func (export "do_load") (param i32) (result i32)
    local.get 0
    i32.load8_u offset=0x1000))

;; wasm[0]::function[0]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       movq    0x68(%rdi), %r11
;;       movq    0x60(%rdi), %rax
;;       movl    %edx, %edx
;;       subq    $0x1001, %r11
;;       xorq    %r8, %r8
;;       leaq    0x1000(%rax, %rdx), %rdi
;;       cmpq    %r11, %rdx
;;       cmovaq  %r8, %rdi
;;       movb    %cl, (%rdi)
;;       movq    %rbp, %rsp
;;       popq    %rbp
;;       retq
;;
;; wasm[0]::function[1]:
;;       pushq   %rbp
;;       movq    %rsp, %rbp
;;       movq    0x68(%rdi), %r11
;;       movq    0x60(%rdi), %rax
;;       movl    %edx, %ecx
;;       subq    $0x1001, %r11
;;       xorq    %rdx, %rdx
;;       leaq    0x1000(%rax, %rcx), %rdi
;;       cmpq    %r11, %rcx
;;       cmovaq  %rdx, %rdi
;;       movzbq  (%rdi), %rax
;;       movq    %rbp, %rsp
;;       popq    %rbp
;;       retq