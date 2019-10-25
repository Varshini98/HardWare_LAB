;Write a program to read a string and reverse it
section .data
	enter: db "Enter the string 	:	"
	len_enter: equ $-enter
	print: db "Reversed string is	:	"
	len_print: equ $-print
	blank: db 10
	str_len: db 0
section .bss	
	str: resb 100
	char: resb 1
	temp: resb 1
section .text
	global _start:
_start:

	;;read a string
	mov ecx,enter
	mov edx,len_enter
	call WRITE
	
	mov ebx,str
	call READSTRING
	
got_str:
	mov ebx,str
	movzx ecx,BYTE[str_len]
	dec ecx
	add ecx,ebx
reverse:
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
exit:
	mov eax,1
	mov ebx,0
	int 80h
;SUBROUTINES
WRITE:
	mov eax,4
	mov ebx,1
	int 80h
	ret
READ:
	mov eax,3
	mov ebx,0
	int 80h
	ret
NEWLINE:
	mov ecx,blank
	mov edx,1
	call WRITE
	ret
READSTRING:
	mov BYTE[str_len],0
read_character:
	push ebx
	mov ecx,char
	mov edx,1
	call READ
	pop  ebx
	
	cmp BYTE[char],10
	jne carry_on
	ret
carry_on:	
	inc BYTE[str_len]
	mov al,BYTE[char]
	mov BYTE[ebx],al
	add ebx,1
	jmp read_character
	
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

	

