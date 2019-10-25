section .data
msg1: db 'Enter the Digit1:',0Ah
length1:equ $-msg1
msg2: db 'Enter the digit2:',0Ah
length2:equ $-msg2

section .bss
digit1: resb 1
digit2: resb 1
size1: equ $-digit1
size2: equ $-digit2

 


section .text
global _start
_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, length1
int 80h

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, length2
int 80h


mov eax, 3
mov ebx, 0
mov ecx, digit1
mov edx, size1
int 80h
sub byte[digit1], 30h


mov eax, 3
mov ebx, 0
mov ecx, digit2
mov edx, size2
int 80h
sub byte[digit2], 30h

mov al, byte[digit1]
cmp al, byte[digit2]
ja if

else:
add byte[digit2], 30h
mov eax, 4
mov ebx, 1
mov ecx, digit2
mov edx, length2
int 80h

jmp L

if:
add byte[digit1], 30h
mov eax, 4                                                                            
mov ebx, 1
mov ecx, digit1
mov edx, length1
int 80h

L:



mov eax, 1
mov ebx, 0
int 80h

