segment .data
    LF          equ 0xA     ; Quebra de linha
    NULL        equ 0xD     ; Final da String
    TAB         equ 0x9     ; Identação
    SYS_CALL    equ 0x80    ; Envio da informação ao SO

    ; EAX
    SYS_EXIT    equ 0x1     ; Código de chamada de finalização
    SYS_READ    equ 0x3     ; Read
    SYS_WRITE   equ 0x4     ; Write

    ; EBX
    RET_EXIT    equ 0x0     ; Operação finalizada
    STD_IN      equ 0x0     ; Entrada padrão
    STD_OUT     equ 0x1     ; Saída padrão

    BUFFER_SIZE equ 0xA

segment .text

showExit:
    CALL        strSize
    MOV         EAX, SYS_WRITE
    MOV         EBX, STD_OUT
    INT         SYS_CALL
    RET




strSize:
    MOV         EDX, ECX

nextChar:
    CMP         BYTE[EDX], NULL
    JZ          finish
    INC         EDX
    JMP         nextChar

finish:
    SUB         EDX, ECX
    RET         
