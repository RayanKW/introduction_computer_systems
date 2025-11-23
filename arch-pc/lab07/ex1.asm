%include 'in_out.asm'

section .data
    msg1 db 'Наименьшее число: ', 0h
    a dd 15      ; первое число (ваш вариант из таблицы 7.5)
    b dd 8       ; второе число  
    c dd 23      ; третье число

section .bss
    min resb 10   ; переменная для хранения минимального значения

section .text
global _start

_start:
    ; ---------- Записываем 'a' в переменную 'min'
    mov ecx, [a]
    mov [min], ecx

    ; ---------- Сравниваем 'min' и 'b'
    cmp ecx, [b]
    jl check_c     ; если min < b, переходим к сравнению с c
    mov ecx, [b]   ; иначе min = b
    mov [min], ecx

check_c:
    ; ---------- Сравниваем 'min' и 'c'
    mov ecx, [min]
    cmp ecx, [c]
    jl print_result  ; если min < c, переходим к выводу
    mov ecx, [c]     ; иначе min = c
    mov [min], ecx

print_result:
    ; ---------- Вывод результата
    mov eax, msg1
    call sprint      ; Вывод сообщения 'Наименьшее число: '
    mov eax, [min]
    call iprintLF    ; Вывод минимального числа

    call quit        ; Выход
