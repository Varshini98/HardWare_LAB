section .text
msg1:db"enter the string",0Ah
len1:equ $-msg1
msg2:db" "
len2:equ $-msg2
newline: db 10


section .bss
length: resb 1
string: resb 100
temp: resb 1
digits: resb 1
n:resb 1

section .text
global _start
_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

read:
mov esi,string
mov edi,string
mov byte[length],0
push esi
inc byte[digits]
cld
loopit:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
cmp byte[temp],10
je last
cmp byte[temp],' '
je do
mov al,byte[temp]
stosb
inc esi
inc byte[length]
jmp loopit


do:
mov al,byte[temp]
stosb
inc esi
inc byte[digits]
inc byte[length]
push esi
jmp loopit


last:
mov byte[temp],' '
mov al,byte[temp]
stosb
inc byte[length]


shift:
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h
cmp byte[digits],0
je exit
pop esi
call loop
dec byte[digits]
jmp shift




loop:
lodsb
cmp al,' '
je endloop
mov byte[temp],al
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
jmp loop

endloop:
ret


mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
jmp exit



exit:
mov eax,1
mov ebx,0
int 80h


