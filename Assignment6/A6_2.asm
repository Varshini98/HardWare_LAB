
section .bss
i:resb 1
sum: resw 1
number: resw 1
nod: resb 1
dig: resb 1
digit1: resb 1
digit0: resb 1
num: resb 1
n: resb 1
f1:resb 1
f2:resb 1

section .data
msg1: db 'Enter the number ',0Ah
len1: equ $ -msg1
msg2: db 'hi'
len2: equ $ -msg2
spa: db ' '

section .text
global _start
_start:


mov byte[f1],0
mov byte[f2],1
reading: 
        
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h
        
        call read_num
       
        add byte[f1],30h      
        mov eax,4
        mov ebx,1
   	mov ecx,f1
	mov edx,1
	int 80h
        sub byte[f1],30h
        call printspace
 
        cmp byte[num],0
        je exit
        add byte[f2],30h
        mov eax,4
        mov ebx,1
   	mov ecx,f2
	mov edx,1
	int 80h  
        call printspace 
        mov eax,4
        mov ebx,1
   	mov ecx,f2
	mov edx,1
	int 80h 
        call printspace
        sub byte[f2],30h
	cmp byte[num],1
	je exit
                 
        mov byte[f1],1
        mov byte[f2],1
        call fib     
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
je end
sub byte[dig],30h
mov al,byte[num]
mov bl,10
mul bl
add al,byte[dig]
mov byte[num],al
jmp loop


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


fib:
pusha
mov al,byte[f2]
mov bl,byte[f1]
add byte[f2],bl
mov byte[f1],al

mov al,byte[f2]
cmp al,byte[num]
ja complete

mov al,byte[f2]
mov ah,0
mov word[number],ax
call print_num
call printspace
call fib

complete:
popa
ret



printspace:
pusha
mov eax,4
mov ebx,1
mov ecx,spa
mov edx,1
int 80h
popa
ret
