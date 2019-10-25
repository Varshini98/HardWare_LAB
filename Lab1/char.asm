global _start
_start:

section .text
	
	;; Reading character
	mov edx,1
	mov ecx,char
	mov ebx,0
	mov eax,3
	int 80h
	
	;; Check for char to be [0,9]
	cmp byte[char],'9'
	ja next1
	cmp byte[char],'0'
	jb next1
	mov edx,msg1Len
	mov ecx,msg1
	mov ebx,1
	mov eax,4
	int 80h
	jmp exit


	;; Check for char to be [a,z]
	next1:
	cmp byte[char],'z'
	ja next2
	cmp byte[char],'a'
	jb next2
	mov edx,msg2Len
	mov ecx,msg2
	mov ebx,1
	mov eax,4
	int 80h
	jmp exit
	
	;; Check for char to be [A,Z]
	next2:
	cmp byte[char],'Z'
	ja next3
	cmp byte[char],'A'
	jb next3
	mov edx,msg3Len
	mov ecx,msg3
	mov ebx,1
	mov eax,4
	int 80h
	jmp exit

	;; This case denotes char being a special character
	next3:
	mov edx,msg4Len
	mov ecx,msg4
	mov ebx,1
	mov eax,4
	int 80h
	
	;; Exiting, syscall no. 1 and passing 0 to exit() denoting successful execution of code
	exit:
	
	;; Printing newline character before exiting
	mov edx,1
	mov ecx,newline
	mov ebx,1
	mov eax,4
	int 80h
	
	mov eax,1
	mov ebx,0
	int 80h
	
section .bss
	char: resb 1

section .data
	newline: db 0ah
	msg1: db 'Number',0ah
	msg1Len: equ $ - msg1
	msg2: db 'LowerCaseLetters',0ah
	msg2Len: equ $ - msg2
	msg3: db 'UpperCaseLetters',0ah
	msg3Len: equ $ - msg3
	msg4: db 'SpecialCharacter',0ah
	msg4Len: equ $ - msg4

