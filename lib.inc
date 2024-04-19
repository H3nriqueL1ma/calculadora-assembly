segment .text

show_OUT:
    mov         eax, 4
    mov         ebx, 1
    INT         0x80
    ret

_exit:
    mov         eax, 1
    INT         0x80

show_result:
    mov         ecx, result
    mov         edx, 25
    call        show_OUT

    mov         ecx, res_opr
    mov         edx, 2
    call        show_OUT

    mov         ecx, line_c
    mov         edx, 31
    call        show_OUT
    jmp         _exit

error_opt:
    mov         byte [n1], 0
    mov         byte [n2], 0
    mov         byte [opt_n], 0

    mov         ecx, err_opt
    mov         edx, 18
    call        show_OUT

    mov         ecx, line_c
    mov         edx, 31
    call        show_OUT
    jmp         _exit

error_input:
    mov         byte [n1], 0
    mov         byte [n2], 0
    mov         byte [opt_n], 0

    mov         ecx, line
    mov         edx, 31
    call        show_OUT

    mov         ecx, err_input
    mov         edx, 20
    call        show_OUT
    jmp         _exit

error_sub:
    mov         byte [n1], 0
    mov         byte [n2], 0
    mov         byte [opt_n], 0

    mov         ecx, err_sub
    mov         edx, 33
    call        show_OUT

    mov         ecx, line_c
    mov         edx, 31
    call        show_OUT
    jmp         _exit