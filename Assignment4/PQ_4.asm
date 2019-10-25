;CHOICE
global _start
_start:


mov edx,msgALen
mov ecx,msgA
mov ebx,1
mov eax,4
int 80h


mov edx,msgBLen
mov ecx,msgB
mov ebx,1
mov eax,4
int 80h


mov edx,msgCLen
mov ecx,msgC
mov ebx,1
mov eax,4
int 80h


mov edx,msgFLen
mov ecx,msgF
mov ebx,1
mov eax,4
int 80h

call read_character
mov al,byte[read_char_value]
mov byte[option],al

mov edx,msgDLen
mov ecx,msgD
mov ebx,1
mov eax,4
int 80h

call read_character
call read_array

mov edx,msgELen
mov ecx,msgE
mov ebx,1
mov eax,4
int 80h

cmp byte[option],'a'
je print_a

cmp byte[option],'b'
je print_b

cmp byte[option],'c'
je print_c

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

print_a:
        mov byte[var],0
        la:
        mov al,byte[strLen]
        cmp al,byte[var]
        je exit
        movzx ecx,byte[var]
        inc byte[var]
        mov al,byte[string+ecx]
        cmp al,'a'
        jb na
        cmp al,'z'
        ja na
        sub al,32
        na:
        mov byte[print_char_value],al
        call print_character
        jmp la

print_b:
        mov byte[var],0
        lb:
        mov al,byte[strLen]
        cmp al,byte[var]
        je exit
        movzx ecx,byte[var]
        inc byte[var]
        mov al,byte[string+ecx]
        cmp al,'A'
        jb nb
        cmp al,'Z'
        ja nb
        add al,32
        nb:
        mov byte[print_char_value],al
        call print_character
        jmp lb

print_c:
        mov byte[var],0
        mov byte[isFirst],1
        lc:
        mov al,byte[strLen]
        cmp al,byte[var]
        je exit
        movzx ecx,byte[var]
        inc byte[var]
        mov al,byte[string+ecx]
        
        cmp al,' '
        je markAsFirstAndJmpToNc1 

        cmp al,'A'
        jb nc
        cmp al,'Z'
        ja nc

        cmp byte[isFirst],1
        je before_nc1

        add al,32
        jmp nc1
        
        ;means upper case......
        ;if not first character==>>decapitalize

        nc:
        cmp al,'a'
        jb nc1
        cmp al,'z'
        ja nc1
        ;means lower case......
        ;if firstCharacter==>>Capitalize
        cmp byte[isFirst],0
        je nc1
        
        mov byte[isFirst],0
        sub al,32

        nc1:
        mov byte[print_char_value],al
        call print_character
        jmp lc

before_nc1:
    mov byte[isFirst],0
    jmp nc1
  
return:
    ret

print_newline:
    mov edx,newlineLength
    mov ecx,newline
    mov ebx,1
    mov eax,4
    int 80h
    ret

markAsFirstAndJmpToNc1:
    mov byte[isFirst],1
    jmp nc1
   
section .bss
    string: resb 50
    char: resb 1
    print_char_value: resb 1
    read_char_value: resb 1
    strLen: resb 1
    var: resb 1
    option: resb 1
    isFirst: resb 1    

section .data
    newline: db 0ah
    newlineLength: equ $ - newline
    msgA: db 'a. UPPER',0ah
    msgALen: equ $ - msgA
    msgB: db 'b. LOWER',0ah 
    msgBLen: equ $ - msgB
    msgC: db 'c. Capitalize',0ah   
    msgCLen: equ $ - msgC
    msgD: db 'Enter the string: '
    msgDLen: equ $ - msgD
    msgE: db 'The transformed string: '
    msgELen: equ $ - msgE
    msgF: db 'Enter a/b/c: '
    msgFLen: equ $ - msgF
