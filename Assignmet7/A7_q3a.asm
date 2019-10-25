;Write a program to sort an array of floating point numbers.
section .data
	msg1: db "Enter number of elements	:	",10
	len_msg1: equ $-msg1
	msg2: db "Enter the elements",10
	len_msg2: equ $-msg2
	msg3: db "After Sorting",10
	len_msg3: equ $-msg3
	blank: db 10

	format1 db "%lf",0
	formatp db "%lf",10
section .bss
	n: resd 1
	array: resd 100
	temp: resd 1
	waste: resd 1
	counter1: resd 1
	counter2: resd 1

	number: resd 1
	digit: resb 1
section .text
	global main
	extern scanf
	extern printf	
main:
	mov ecx, msg1
	mov edx, len_msg1
	call WRITE
	
	call GETANYNUMBER
	mov eax,DWORD[number]	
	mov DWORD[n],eax
	mov DWORD[temp],eax

	cmp eax,0
	je exit
	
	push eax
	mov ecx, msg2
	mov edx, len_msg2
	call WRITE
	pop eax

	mov ebx,array
	mov DWORD[temp],eax
	call GET_FLOAT_ARRAY
		
BUBBLESORT:
	mov ebx,array  ;main pointer
	mov ecx,array  ;sub pointer
	
	mov eax,DWORD[n]
	mov DWORD[counter1],eax
	mov DWORD[counter2],eax
bubble:
	fld DWORD[ecx]	
	fld DWORD[ebx]
	
	fcomp ST1
	fstsw ax
	sahf
	fstp DWORD[waste]
	fstp DWORD[waste]
	jna skip
	call SWAP

	skip:
		add ecx,4
		dec DWORD[counter2]
		cmp DWORD[counter2],0
		je setsecpointer
		jmp bubble
	
		setsecpointer:
			add ebx,4
			dec DWORD[counter1]
			cmp DWORD[counter1],0
			je bubble_sort_done
			mov eax,DWORD[counter1],
			mov DWORD[counter2],eax
			mov ecx,ebx
			jmp bubble
	
bubble_sort_done:
	mov ecx,msg3
	mov edx,len_msg3
	call WRITE

	mov ebx,array
	mov eax,DWORD[n]
	mov DWORD[temp],eax
	call PRINT_FLOAT_ARRAY

exit:
	mov eax, 1
	mov ebx, 0
	int 80h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SUBROUTINES
	;ebx-array
	;temp-size
GET_FLOAT_ARRAY:
readelement:
	push ebx
	call read ;stores value to ST0....pushes other values down
	pop ebx
	
	fstp DWORD[ebx]
	add ebx,4

	dec DWORD[temp]
	cmp DWORD[temp],0
	ja readelement
	ret
 
	;ebx-array
	;temp-size
PRINT_FLOAT_ARRAY:
	cmp DWORD[temp],0
	je printing_done

	fld DWORD[ebx]
	call print
	fstp DWORD[waste]	
	
	add ebx,4
	dec DWORD[temp]
	jmp PRINT_FLOAT_ARRAY
printing_done:
	ret	
	
GETANYNUMBER:
	mov DWORD[number],0
  getnumber:
	mov ecx,digit
	mov edx,1
	call READ

	cmp BYTE[digit],10                 ;is digit=newline
	jne carryon
	ret			   	   ;got the n digit number
  carryon:				   ;to change number from ascii
	sub byte[digit],30h
	mov eax,DWORD[number]
	mov ebx,10
	mul ebx
	
	movzx ebx,byte[digit]
	add eax,ebx
	mov DWORD[number],eax
	jmp getnumber
	
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
print:
	 push ebp
	 mov ebp, esp
	 sub esp, 8
	 
	 fst qword[ebp-8]
	 push formatp
	 call printf
	 
	 mov esp, ebp
	 pop ebp
	 ret

read:
	 push ebp
	 mov ebp, esp
	 sub esp, 8
	 
	 lea eax, [esp] ;load effective adress
	 push eax
	 push format1
	 call scanf
	 fld qword[ebp-8]
	 
	 mov esp, ebp
	 pop ebp
	 ret

SWAP:
	mov eax,DWORD[ebx]
	mov edx,DWORD[ecx]
	mov DWORD[ebx],edx
	mov DWORD[ecx],eax
	ret
