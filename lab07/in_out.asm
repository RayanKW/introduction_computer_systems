; in_out.asm
global sprint, sprintLF, sread, atoi, iprint, iprintLF, quit

section .text

; Вывод строки
sprint:
    push edx
    push ecx
    push ebx
    push eax
    call slen
    mov edx, eax
    pop eax
    mov ecx, eax
    mov ebx, 1
    mov eax, 4
    int 0x80
    pop ebx
    pop ecx
    pop edx
    ret

; Вывод строки с переводом строки
sprintLF:
    call sprint
    push eax
    mov eax, 0xA
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax
    ret

; Ввод строки
sread:
    push eax
    push ebx
    mov eax, 3
    mov ebx, 0
    int 0x80
    pop ebx
    pop eax
    ret

; Преобразование строки в число
atoi:
    push ebx
    push ecx
    push edx
    xor ebx, ebx
    xor ecx, ecx
.next:
    mov cl, [eax]
    cmp cl, '0'
    jb .done
    cmp cl, '9'
    ja .done
    sub cl, '0'
    imul ebx, 10
    add ebx, ecx
    inc eax
    jmp .next
.done:
    mov eax, ebx
    pop edx
    pop ecx
    pop ebx
    ret

; Вывод числа
iprint:
    push eax
    push ecx
    push edx
    push esi
    mov ecx, 0
.divide:
    inc ecx
    mov edx, 0
    mov esi, 10
    idiv esi
    add edx, 48
    push edx
    cmp eax, 0
    jnz .divide
.print:
    dec ecx
    mov eax, esp
    call sprint
    pop eax
    cmp ecx, 0
    jnz .print
    pop esi
    pop edx
    pop ecx
    pop eax
    ret

; Вывод числа с переводом строки
iprintLF:
    call iprint
    push eax
    mov eax, 0xA
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax
    ret

; Длина строки
slen:
    push ebx
    mov ebx, eax
.next:
    cmp byte [eax], 0
    jz .finish
    inc eax
    jmp .next
.finish:
    sub eax, ebx
    pop ebx
    ret

; Завершение программы
quit:
    mov ebx, 0
    mov eax, 1
    int 0x80
