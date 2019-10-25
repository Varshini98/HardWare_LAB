section .text
global _start
_start:

call read_num1
call read_num2

read_num1:

pusha
mov word[num1],0

loop_read:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end_read

mov ax,word[num1]
mov bx,10
mul bx
mov bl,byte[temp]
sub bl,30h
mov bh,0
add ax,bx
mov word[num1],ax
jmp loop_read

end_read:
popa

ret

read_num2:

pusha
mov word[num2],0

loop_read1:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end_read1

mov ax,word[num2]
mov bx,10
mul bx
mov bl,byte[temp]
sub bl,30h
mov bh,0
add ax,bx
mov word[num2],ax
jmp loop_read1

end_read1:
popa

mov ax,word[num1]
mov bx,word[num2]
div bx
cmp dx,0
je mul

notmul:

mov eax,4
mov ebx,1
mov ecx,message1
mov edx,l1
int 80h
jmp exit

mul:

mov eax,4
mov ebx,1
mov ecx,mesage2
mov edx,l2
int 80h
jmp exit

exit:
mov eax,1
mov ebx,0
int 80h

section .data 

message1:db 'Not a multiple',10
l1: equ $-message1

message2:db ' IS Multiple',10
l2: equ $-message2

section .bss

temp: resb 2
num1: resw 1
num2: resw 1

