section .multiboot
align 4
    dd 0x1BADB002
    dd 0x00000003
    dd -(0x1BADB002+0x00000003)

section .text
bits 32
global start
extern kernel_main        ; declare C function

start:
    cli
    mov esp, stack_top
    call kernel_main      ; jump into C code

.halt:
    hlt
    jmp .halt

section .bss
align 16
stack_bottom:
    resb 4096
stack_top:
