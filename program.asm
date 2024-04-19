%include "lib.inc"

section .data
    title       db "CALCULADORA", 0xD, 0xA

    input1      db "Digite o primeiro número: "
    len_input1  equ $- input1
    input2      db "Digite o segundo número: "
    len_input2  equ $- input2

    line        db "-----------------------------", 0xD, 0xA
    line_c      db 0xA, "-----------------------------", 0xD, 0xA, 0xA
    option_add  db "1. Adição", 0xD, 0xA
    option_sub  db "2. Subtração", 0xD, 0xA
    option_div  db "3. Divisão", 0xD, 0xA
    option_mult db "4. Multiplicação", 0xD, 0xA

    opt         db "Digite sua opção: "
    len_opt     equ $- opt

    result      db "Resultado da operação: "

    err_opt     db "Opção inválida!", 0xD, 0xA
    err_input   db "Valor menor que 0!", 0xD, 0xA
    err_sub     db "Subtração com retorno negativo!", 0xD, 0xA
    
section .bss
    n1          resb 2
    n2          resb 2
    opt_n       resb 2
    res_opr     resb 2

section .text

global _start

_start:
;######### TITLE #########
    mov         ecx, line
    mov         edx, 31
    call        show_OUT

    mov         ecx, title
    mov         edx, 13
    call        show_OUT

    mov         ecx, line
    mov         edx, 31
    call        show_OUT
;######### INPUT 1 #########
    mov         ecx, input1
    mov         edx, len_input1
    call        show_OUT

    mov         eax, 3
    mov         ebx, 0
    mov         ecx, n1
    mov         edx, ecx
    int         0x80
;######### VERIFICATION INPUT 1 #########
    mov         ah, [n1]
    sub         ah, '0'

    cmp         ah, 0
    jl          error_input
;######### INPUT 2 #########
    mov         ecx, input2
    mov         edx, len_input2
    call        show_OUT

    mov         eax, 3
    mov         ebx, 0
    mov         ecx, n2
    mov         edx, ecx
    int         0x80
;######### VERIFICATION INPUT 2 #########
    mov         bh, [n2]
    sub         bh, '0'

    cmp         bh, 0
    jl          error_input
;######### OPTIONS #########
    mov         ecx, line
    mov         edx, 31
    call        show_OUT

    mov         ecx, option_add
    mov         edx, 13
    call        show_OUT

    mov         ecx, option_sub
    mov         edx, 16
    call        show_OUT

    mov         ecx, option_div
    mov         edx, 13
    call        show_OUT

    mov         ecx, option_mult
    mov         edx, 20
    call        show_OUT

    mov         ecx, line
    mov         edx, 31
    call        show_OUT
;######### OBTAIN OPTIONS #########
    mov         ecx, opt 
    mov         edx, len_opt
    call        show_OUT

    mov         eax, 3
    mov         ebx, 0
    mov         ecx, opt_n
    mov         edx, 2
    int         0x80

    mov         ecx, line
    mov         edx, 31
    call        show_OUT    
;######### VERIFICATION OPTION #########
    mov         ah, [opt_n]
    sub         ah, '0'

    cmp         ah, 1
    jb          error_opt
    cmp         ah, 1
    je          addition
    cmp         ah, 2
    je          subtraction

addition:
    mov         ah, [n1]
    sub         ah, '0'
    mov         bh, [n2]
    sub         ah, '0'

    add         ah, bh
    add         ah, '0'
    mov         [res_opr], ah
    jmp         show_result

subtraction:
    mov         ah, [n1]
    sub         ah, '0'
    mov         bh, [n2]
    sub         bh, '0'

    cmp         ah, bh
    jb          error_sub

    sub         ah, bh
    add         ah, '0'
    mov         [res_opr], ah
    jmp         show_result