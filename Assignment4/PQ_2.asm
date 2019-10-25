;Write a program to read 2 strings and concatenate them
section .data
	enter1: db "Enter first string 	:	"
	len_enter1: equ $-enter1
	enter2: db "Enter second string 	:	"
	len_enter2: equ $-enter2
	result: db "Concatenated string	:	"
	len_result: equ $-result
	blank: db 10

	str_len: db 0
	str1_len: db 0
	str2_len: db 0
section .bss
	str1: resb 200
	str2: resb 100
	char: resb 1
	temp: resb 1
section .text
	global _start:
_start:

reading:
	;;read first string
	mov ecx,enter1
	mov edx,len_enter1
	call WRITE
	
	mov ebx,str1
	call READSTRING
	mov al,BYTE[str_len]
	mov BYTE[str1_len],al
	
	;;read second string
	mov ecx,enter2
	mov edx,len_enter2
	call WRITE
	
	mov ebx,str2
	call READSTRING
	mov al,BYTE[str_len]
	mov BYTE[str2_len],al
concatenation:
	mov ecx,result
	mov edx,len_result
	call WRITE
	
	mov ebx,str1
	movzx eax,BYTE[str1_len]
	add ebx,eax
	mov ecx,str2
	mov al,BYTE[str2_len]
	mov BYTE[temp],al
	
begin:
	cmp BYTE[temp],0
	je over
	dec BYTE[temp]
	
	mov al,BYTE[ecx]
	mov BYTE[ebx],al
	inc BYTE[str1_len]

	inc ebx
	inc ecx
	jmp begin
over:
	mov ecx,str1
	movzx edx,BYTE[str1_len]
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
	
