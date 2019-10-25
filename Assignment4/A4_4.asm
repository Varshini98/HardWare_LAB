section .data
msg1: db "Enter the string	 : "
len1: equ $-msg1
msg2: db "The encrypted string	 : "
len2: equ $-msg2
newline: db 10

section .bss
array: resb 50
i: resb 1
count: resw 1
temp :resb 1
length:resb 1
t:resw 1
num:resw 1
nod:resb 1
section .text
global _start
_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

mov ebx,array

read_string:

push ebx
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
pop ebx

cmp byte[temp],10
je end_reading

inc byte[length]
mov al,byte[temp]
mov byte[ebx],al
inc ebx
jmp read_string

end_reading:
mov byte[ebx],0


encrypt:
mov ebx,array
mov byte[i],0

loop:
mov al,byte[length]
cmp byte[i],al
je print
;cmp byte[ebx],'z'
;je update1
;cmp byte[ebx],'Z'
;je update2
add byte[ebx],1
l:
inc ebx
inc byte[i]
jmp loop

update1:
mov byte[ebx],'a'
jmp l

update2:
mov byte[ebx],'A'
jmp l



print:
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h
mov ebx,array

print_string:
cmp byte[ebx],0
je print_newline
push ebx
mov al,byte[ebx]
mov byte[temp],al
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
pop ebx
inc ebx
jmp print_string
 
print_newline:
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



;;reverse:
	cmp ebx,ecx
	jnb print_reverse

	call SWAP	
	inc ebx
	dec ecx
	call reverse

print_reverse:
	mov ecx,print
	mov edx,len_print
	call WRITE
	
	mov ecx,str
	movzx edx,BYTE[str_len]
	call WRITE
	
	call NEWLINE

SWAP:
	mov al,BYTE[ebx]
	mov dl,BYTE[ecx]
	mov BYTE[ebx],dl
	mov BYTE[ecx],al
	ret
  	mov edx,1
	call READ
	pop  ebx
	
	cmp BYTE[char],10
	jne carry_on
	ret

	
