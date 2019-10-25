
section .bss
i:resb 1
sum: resw 1
number: resw 1
nod: resb 1
dig: resb 1
digit1: resb 1
digit0: resb 1
num: resb 1

section .data
msg1: db 'Enter the number ',0Ah
len1: equ $ -msg1
msg2: db 'hi'
len2: equ $ -msg2

section .text
global _start
_start:
mov word[sum],0
mov byte[i],0
reading: 
        cmp byte[i],10
        je printsum

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h
        inc byte[i]
        call read_num
       
        jmp reading

printsum:

mov ax,word[sum]
mov word[number],ax


call print_num
exit:
mov eax,1
mov ebx,0
int 80h




read_num:

pusha
mov word[num],0
loop:

mov eax,3
mov ebx,0
mov ecx,dig
mov edx,1
int 80h

cmp byte[dig],10
je findsum
sub byte[dig],30h
mov al,byte[num]
mov bl,10
mul bl
add al,byte[dig]
mov byte[num],al
jmp loop


findsum:
mov al,byte[num]
mov bl,byte[num]
mul bl
add word[sum],ax

end:
popa
ret




print_num:
pusha
cmp word[number],0
je printzero
loop5:
	cmp word[number], 0
	je print_no
	inc byte[nod]
	mov dx, 0
	mov ax, word[number]
	mov bx, 10
	div bx
	push dx
	mov word[number], ax
	jmp loop5

	print_no:
	cmp byte[nod], 0
	je end_print
	dec byte[nod]
	pop dx
	mov byte[dig], dl
	add byte[dig], 30h
mov eax,4
mov ebx,1
mov ecx,dig
mov edx,1
int 80h


jmp print_no

end_print:


popa
ret

printzero:
add word[number],30h
mov eax,4
mov ebx,1
mov ecx,number
mov edx,1
int 80h
jmp end_print


	


  





