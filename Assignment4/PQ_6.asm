global _start
_start:

mov edx,msgDLen
mov ecx,msgD
mov ebx,1
mov eax,4
int 80h

call read_array

call print_alphabets
call print_newline

call print_numbers
call print_newline

call print_symbols

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
    mov al,byte[read_char_value]
    cmp byte[read_char_value],10
    je return
    movzx ecx, byte[strLen]
    mov byte[string+ecx],al
    inc byte[strLen]
    jmp l1

print_alphabets:
    mov edx,alphabetsLength
    mov ecx,alphabets
    mov ebx,1
    mov eax,4
    int 80h
    mov byte[var],0
    l2:
    mov al,byte[var]
    cmp al,byte[strLen]
    je return
    movzx ecx,byte[var]
    inc byte[var]
    mov al,byte[string+ecx]
    ;compare value of al here
    ;print suitable thing
    cmp al,'a'
    jb n2
    cmp al,'z'
    ja n2

    mov byte[print_char_value],al
    call print_character
    jmp l2

    n2:
    cmp al,'A'
    jb l2
    cmp al,'Z'
    ja l2

    mov byte[print_char_value],al
    call print_character

    jmp l2
       

print_numbers:
    mov edx,numbersLength
    mov ecx,numbers
    mov ebx,1
    mov eax,4
    int 80h
    mov byte[var],0
    l3:
    mov al,byte[var]
    cmp al,byte[strLen]
    je return
    movzx ecx,byte[var]
    inc byte[var]
    mov al,byte[string+ecx]
    ;compare value of al here
    ;print suitable thing
    
    cmp al,'0'
    jb l3
    cmp al,'9'
    ja l3

    mov byte[print_char_value],al
    call print_character

    jmp l3

print_symbols:
    mov edx,symbolsLength
    mov ecx,symbols
    mov ebx,1
    mov eax,4
    int 80h
    mov byte[var],0
    
    l4:
    mov al,byte[var]
    cmp al,byte[strLen]
    je return
    movzx ecx,byte[var]
    inc byte[var]
    mov al,byte[string+ecx]
    ;compare value of al here
    ;print suitable thing
    
    cmp al,'0'
    jb n4
    cmp al,'9'
    ja n4

    jmp next

    n4:

    cmp al,'a'
    jb n5
    cmp al,'z'
    ja n5

    jmp next

    n5:
    cmp al,'A'
    jb n6
    cmp al,'Z'
    ja n6    

    jmp next

    n6:

    mov byte[print_char_value],al
    call print_character

    jmp l4

next: 
    jmp l4


return:
    ret

print_newline:
    mov edx,newlineLength
    mov ecx,newline
    mov ebx,1
    mov eax,4
    int 80h
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
    alphabets: db 'Alphabets: '
    alphabetsLength: equ $ - alphabets
    numbers: db 'Numbers: '
    numbersLength: equ $ - numbers
    symbols: db 'Special symbols: '
    symbolsLength: equ $ - symbols
    msgD: db 'Enter the string: '
    msgDLen: equ $ - msgD
