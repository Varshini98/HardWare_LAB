;reverse toggling
global _start
_start:


mov edx,msgDLen
mov ecx,msgD
mov ebx,1
mov eax,4
int 80h

call read_array

mov edx,msgELen
mov ecx,msgE
mov ebx,1
mov eax,4
int 80h

call print_array

exit:
    call print_newline
    mov eax,1
    mov ebx,0
    int 80h

print_character:
    mov edx,1
    mov ecx,print_char_value
    mov ebx,1
    mov eax,4
    int 80h
    ret

read_character:
    mov edx,1
    mov ecx,read_char_value
    mov ebx,0
    mov eax,3
    int 80h
    ret
   
read_array:
    mov byte[strLen],0
   
    l1:
    call read_character
    cmp byte[read_char_value],'a'
    jb n1
    cmp byte[read_char_value],'z'
    ja n1

    ;subtract something

    sub byte[read_char_value],32

    jmp write

    n1:

    cmp byte[read_char_value],'A'
    jb write
    cmp byte[read_char_value],'Z'
    ja write

    ; add something
    add byte[read_char_value],32


    write: 
    mov al,byte[read_char_value]
    cmp byte[read_char_value],10
    je return
    movzx ecx, byte[strLen]
    mov byte[string+ecx],al
    inc byte[strLen]
    jmp l1

print_array:
        l2:
        mov al,byte[strLen]
        cmp al,0
        je return
        dec byte[strLen]
        movzx ecx,byte[strLen]
        mov al,byte[string+ecx]
        mov byte[print_char_value],al
        call print_character
        jmp l2

print_newline:
    mov edx,newlineLength
    mov ecx,newline
    mov ebx,1
    mov eax,4
    int 80h
    ret
              
return:
    ret
   
section .bss
    string: resb 50
    char: resb 1
    print_char_value: resb 1
    read_char_value: resb 1
    strLen: resb 1
    var: resb 1

section .data
    newline: db 0ah
    newlineLength: equ $ - newline
    msgD: db 'Enter the string: '
    msgDLen: equ $ - msgD
    msgE: db 'The transformed string: '
    msgELen: equ $ - msgE
