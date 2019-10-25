;Write a program to check whether a string is a palindrome or not 
section .data
	enter: db "Enter the string 	:	"
	len_enter: equ $-enter
	no: db "NO...String is not a palindrome"
	len_no: equ $-no
	yes: db "YES...String is a palindrome"
	len_yes: equ $-yes
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
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;CHECK FOR PALINDROME
	mov ebx,str
	movzx eax,BYTE[str_len]
	dec eax
	add ebx,eax
	mov ecx,ebx ;;;ecx points to end
	mov ebx,str   ;;ebx points to beg
	
	mov al,BYTE[str_len]
	mov BYTE[temp],al
check:
	mov al,BYTE[ecx]
	cmp BYTE[ebx],al
	jne no_palindrome
	
	dec BYTE[temp]
	cmp BYTE[temp],0
	je yes_palindrome
	inc ebx
	dec ecx
	jmp check
	
no_palindrome:
	mov ecx,no
	mov edx,len_no
	call WRITE
	call NEWLINE
	jmp exit
yes_palindrome:
	mov ecx,yes
	mov edx,len_yes
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
	
