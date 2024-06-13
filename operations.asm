section .data

section .bss

section .text
global add, sub, mul, div

add:
    fld qword [esp+4]    ; Carrega o primeiro operando na pilha de FPU
    fld qword [esp+12]   ; Carrega o segundo operando na pilha de FPU
    fadd                 ; Soma os dois valores
    fstp qword [esp+4]   ; Armazena o resultado no primeiro operando
    ret 8                ; Retorna limpando a pilha

sub:
    fld qword [esp+4]
    fld qword [esp+12]
    fsub
    fstp qword [esp+4]
    ret 8

mul:
    fld qword [esp+4]
    fld qword [esp+12]
    fmul
    fstp qword [esp+4]
    ret 8

div:
    fld qword [esp+4]
    fld qword [esp+12]
    fdiv
    fstp qword [esp+4]
    ret 8
