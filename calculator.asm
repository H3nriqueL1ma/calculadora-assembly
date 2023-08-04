%include 'lib.inc'

section .data
    title       DB LF, '+-------------+', LF, '| Calculadora |', LF, '+-------------+', LF, NULL ; Título da calculadora com quebras de linha (LF) e final da string (NULL)
    getValue1   DB LF, 'Valor 1: ', NULL                                                         ; Mensagem para obter o primeiro valor com quebra de linha (LF) e final da string (NULL)
    getValue2   DB LF, 'Valor 2: ', NULL                                                         ; Mensagem para obter o segundo valor com quebra de linha (LF) e final da string (NULL)
    opt1        DB LF, '1. Adição', NULL                                                         ; Opção 1: Adição com quebra de linha (LF) e final da string (NULL)
    opt2        DB LF, '2. Subtração', NULL                                                      ; Opção 2: Subtração com quebra de linha (LF) e final da string (NULL)
    opt3        DB LF, '3. Multiplicação', NULL                                                  ; Opção 3: Multiplicação com quebra de linha (LF) e final da string (NULL)
    opt4        DB LF, '4. Divisão', NULL                                                        ; Opção 4: Divisão com quebra de linha (LF) e final da string (NULL)
    msgOpt      DB LF, 'Opção: ', NULL                                                           ; Mensagem para obter a opção do usuário com quebra de linha (LF) e final da string (NULL)
    msgErr      DB LF, 'Opção Inválida!', NULL                                                   ; Mensagem de erro para opção inválida com quebra de linha (LF) e final da string (NULL)
    process1    DB LF, 'Processo de Adição', NULL                                                ; Mensagem de processo de adição com quebra de linha (LF) e final da string (NULL)
    process2    DB LF, 'Processo de Subtração', NULL                                             ; Mensagem de processo de subtração com quebra de linha (LF) e final da string (NULL)
    process3    DB LF, 'Processo de Multiplicação', NULL                                         ; Mensagem de processo de multiplicação com quebra de linha (LF) e final da string (NULL)
    process4    DB LF, 'Processo de Divisão', NULL                                               ; Mensagem de processo de divisão com quebra de linha (LF) e final da string (NULL)
    msgEnd      DB LF, 'Processo Finalizado!', LF, NULL                                          ; Mensagem de processo finalizado com quebra de linha (LF) e final da string (NULL)

section .bss
    opt         RESB 2                                                                           ; Variável para armazenar a opção digitada pelo usuário (reservando 2 bytes)
    num1        RESB 4                                                                           ; Variável para armazenar o primeiro valor digitado (reservando 4 bytes)
    num2        RESB 4                                                                           ; Variável para armazenar o segundo valor digitado (reservando 4 bytes)

section .text

global _start

_start:
    MOV         ECX, title                                                                       ; Coloca o endereço do título na variável ECX
    CALL        showExit                                                                         ; Chama a função 'showExit' para exibir o título e aguardar o usuário pressionar Enter

    ; Mostrar opções
    MOV         ECX, opt1                                                                        ; Coloca o endereço da opção 1 na variável ECX
    CALL        showExit                                                                         ; Chama a função 'showExit' para exibir a opção 1 e aguardar o usuário pressionar Enter
    MOV         ECX, opt2                                                                        ; Coloca o endereço da opção 2 na variável ECX
    CALL        showExit                                                                         ; Chama a função 'showExit' para exibir a opção 2 e aguardar o usuário pressionar Enter
    MOV         ECX, opt3                                                                        ; Coloca o endereço da opção 3 na variável ECX
    CALL        showExit                                                                         ; Chama a função 'showExit' para exibir a opção 3 e aguardar o usuário pressionar Enter
    MOV         ECX, opt4                                                                        ; Coloca o endereço da opção 4 na variável ECX
    CALL        showExit                                                                         ; Chama a função 'showExit' para exibir a opção 4 e aguardar o usuário pressionar Enter

    ; Obtenção de opções
    MOV         ECX, msgOpt                                                                      ; Coloca o endereço da mensagem de obter opção na variável ECX
    CALL        showExit                                                                         ; Chama a função 'showExit' para exibir a mensagem de obter opção e aguardar o usuário inserir a opção
    MOV         EAX, SYS_READ                                                                    ; Coloca o código da chamada de sistema 'SYS_READ' no registrador EAX (para ler a opção)
    MOV         EBX, STD_IN                                                                      ; Coloca o código da entrada padrão (STDIN) no registrador EBX
    MOV         ECX, opt                                                                         ; Coloca o endereço da variável 'opt' no registrador ECX (para armazenar a opção lida)
    MOV         EDX, 0x2                                                                         ; Coloca o tamanho da leitura (2 bytes, uma vez que é apenas um caractere)
    INT         SYS_CALL                                                                         ; Chama o sistema operacional para realizar a operação de leitura (ler a opção)

    ; Verificação da opção
    MOV         AL, [opt]                                                                        ; Carrega o valor da variável 'opt' no registrador AL para comparar
    CMP         AL, '1'                                                                          ; Compara se a opção é igual a '1'
    JB          showError                                                                        ; Se for menor (JB - Jump if Below), mostra mensagem de erro
    CMP         AL, '4'                                                                          ; Compara se a opção é maior que '4'
    JA          showError                                                                        ; Se for maior (JA - Jump if Above), mostra mensagem de erro

    ; Obtenção de valores
    MOV         ECX, getValue1                                                                   ; Coloca o endereço da mensagem para obter o primeiro valor na variável ECX
    CALL        showExit                                                                         ; Chama a função 'showExit' para exibir a mensagem e aguardar o usuário inserir o primeiro valor
    MOV         EAX, SYS_READ                                                                    ; Coloca o código da chamada de sistema 'SYS_READ' no registrador EAX (para ler o primeiro valor)
    MOV         EBX, STD_IN                                                                      ; Coloca o código da entrada padrão (STDIN) no registrador EBX
    MOV         ECX, num1                                                                        ; Coloca o endereço da variável 'num1' no registrador ECX (para armazenar o primeiro valor lido)
    MOV         EDX, 0x3                                                                         ; Coloca o tamanho da leitura (3 bytes, uma vez que é um número inteiro)
    INT         SYS_CALL                                                                         ; Chama o sistema operacional para realizar a operação de leitura (ler o primeiro valor)

    MOV         ECX, getValue2                                                                   ; Coloca o endereço da mensagem para obter o segundo valor na variável ECX
    CALL        showExit                                                                         ; Chama a função 'showExit' para exibir a mensagem e aguardar o usuário inserir o segundo valor
    MOV         EAX, SYS_READ                                                                    ; Coloca o código da chamada de sistema 'SYS_READ' no registrador EAX (para ler o segundo valor)
    MOV         EBX, STD_IN                                                                      ; Coloca o código da entrada padrão (STDIN) no registrador EBX
    MOV         ECX, num2                                                                        ; Coloca o endereço da variável 'num2' no registrador ECX (para armazenar o segundo valor lido)
    MOV         EDX, 0x3                                                                         ; Coloca o tamanho da leitura (3 bytes, uma vez que é um número inteiro)
    INT         SYS_CALL                                                                         ; Chama o sistema operacional para realizar a operação de leitura (ler o segundo valor)

    ; Selecionar o ponto correto
    MOV         AH, [opt]                                                                        ; Carrega o valor da variável 'opt' no registrador AH
    SUB         AH, '0'                                                                          ; Subtrai o valor '0' do registrador AH para converter o caractere numérico para inteiro

    CMP         AH, 1                                                                            ; Compara se a opção é igual a 1 (adição)
    JE          addition                                                                         ; Se for igual, pula para o processo de adição
    CMP         AH, 2                                                                            ; Compara se a opção é igual a 2 (subtração)
    JE          subtraction                                                                      ; Se for igual, pula para o processo de subtração
    CMP         AH, 3                                                                            ; Compara se a opção é igual a 3 (multiplicação)
    JE          multiplication                                                                   ; Se for igual, pula para o processo de multiplicação
    CMP         AH, 4                                                                            ; Compara se a opção é igual a 4 (divisão)
    JE          division                                                                         ; Se for igual, pula para o processo de divisão

_exit:
    MOV         ECX, msgEnd                                                                      ; Coloca o endereço da mensagem de processo finalizado na variável ECX
    CALL        showExit                                                                         ; Chama a função 'showExit' para exibir a mensagem de processo finalizado e aguardar o usuário pressionar Enter

    MOV         EAX, SYS_EXIT                                                                    ; Coloca o código da chamada de sistema 'SYS_EXIT' no registrador EAX (para finalizar o programa)
    MOV         EBX, RET_EXIT                                                                    ; Coloca o código de retorno 'RET_EXIT' no registrador EBX (para indicar término normal do programa)
    INT         SYS_CALL                                                                         ; Chama o sistema operacional para realizar a operação de saída (finalizar o programa)

addition:
    MOV         ECX, process1                                                                    ; Coloca o endereço da mensagem de processo de adição na variável ECX
    CALL        showExit                                                                         ; Chama a função 'showExit' para exibir a mensagem de processo de adição e aguardar o usuário pressionar Enter
    JMP         _exit                                                                            ; Pula para o rótulo '_exit' para finalizar o programa

subtraction:
    MOV         ECX, process2                                                                    ; Coloca o endereço da mensagem de processo de subtração na variável ECX
    CALL        showExit                                                                         ; Chama a função 'showExit' para exibir a mensagem de processo de subtração e aguardar o usuário pressionar Enter
    JMP         _exit                                                                            ; Pula para o rótulo '_exit' para finalizar o programa

multiplication:
    MOV         ECX, process3                                                                    ; Coloca o endereço da mensagem de processo de multiplicação na variável ECX
    CALL        showExit                                                                         ; Chama a função 'showExit' para exibir a mensagem de processo de multiplicação e aguardar o usuário pressionar Enter
    JMP         _exit                                                                            ; Pula para o rótulo '_exit' para finalizar o programa

division:
    MOV         ECX, process4                                                                    ; Coloca o endereço da mensagem de processo de divisão na variável ECX
    CALL        showExit                                                                         ; Chama a função 'showExit' para exibir a mensagem de processo de divisão e aguardar o usuário pressionar Enter
    JMP         _exit                                                                            ; Pula para o rótulo '_exit' para finalizar o programa

showError:
    MOV         ECX, msgErr                                                                      ; Coloca o endereço da mensagem de opção inválida na variável ECX
    CALL        showExit                                                                         ; Chama a função 'showExit' para exibir a mensagem de opção inválida e aguardar o usuário pressionar Enter
    JMP         _exit                                                                            ; Pula para o rótulo '_exit' para finalizar o programa
