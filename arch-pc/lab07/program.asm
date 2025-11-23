%include 'in_out.asm'

section .data
    msg_x db 'Введите x: ', 0h
    msg_a db 'Введите a: ', 0h
    msg_result db 'Результат f(x): ', 0h

section .bss
    x resb 10
    a resb 10
    result resb 10

section .text
global _start

_start:
    ; Ввод x
    mov eax, msg_x
    call sprint
    mov ecx, x
    mov edx, 10
    call sread
    mov eax, x
    call atoi
    mov [x], eax
    
    ; Ввод a
    mov eax, msg_a
    call sprint
    mov ecx, a
    mov edx, 10
    call sread
    mov eax, a
    call atoi
    mov [a], eax
    
    ; Вычисление f(x) = 2x + a (пример функции из таблицы 7.6)
    mov eax, [x]     ; eax = x
    mov ebx, 2       ; ebx = 2
    mul ebx          ; eax = 2*x
    add eax, [a]     ; eax = 2*x + a
    mov [result], eax
    
    ; Вывод результата
    mov eax, msg_result
    call sprint
    mov eax, [result]
    call iprintLF
    
    call quit
