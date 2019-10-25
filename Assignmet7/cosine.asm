;Compute the cosine series below 
section .data
	msg1: db "Enter the value of X	 : ",0Ah
	len_msg1: equ $-msg1
	prog: db "Program Result	:	"
	blank: db 10

	format1 db "%lf",0
	format2 db 10,"Processor Result		=	  %lf",0
	format3 db 10,"Program Result			=	  %lf",10
section .bss
	x: resd 1
	n: resd 1
	count: resd 1
	fact: resd 1
	result: resd 1
	pr: resd 1
	fr: resd 1
	power: resd 1

	cnt: resd 1
	one: resd 1
section .text
	global main
	extern scanf
	extern printf
	
main:
	mov ecx, msg1
	mov edx, len_msg1
	call WRITE

	mov DWORD[one],1

	mov DWORD[fact],0
	mov DWORD[n],6
	mov DWORD[count],1
	mov DWORD[power],0
	

reading:
	call read
	fst DWORD[x]
	fcos
	call print1

	mov DWORD[result],0
SERIES:
	mov eax,DWORD[n]
	cmp DWORD[count],eax
	ja over

	call CALCULATEPOWER	
	
	mov edx,0
	mov eax,DWORD[count]
	mov ebx,2
	div ebx
	cmp edx,0
	jne positive
	
	fldz
	fsub DWORD[pr]
	fstp DWORD[pr]
positive:
	mov ebx,DWORD[fact]
	call FACTORIAL
	mov DWORD[fr],eax
	
	fld DWORD[pr]
	fidiv DWORD[fr]
	fadd DWORD[result]
	fstp DWORD[result]
			
	add DWORD[fact],2
	add DWORD[count],1
	add DWORD[power],2
	jmp SERIES

over:
	fld DWORD[result]
	call print2
	jmp exit	

	
	;ebx-number
	;eax-result
FACTORIAL:
	cmp ebx,1
	ja recursive_call_factorial
	mov eax,1 ;n<=1
	ret
 recursive_call_factorial:
		push ebx
		dec ebx
		call FACTORIAL
		pop ebx
		mul ebx
		ret

	;power
	;x-number
	;pr-result
CALCULATEPOWER:
	cmp DWORD[power],0
	jne power_loop_set

	fild DWORD[one]
	jmp got_power

power_loop_set:
	mov eax,DWORD[power]
	mov DWORD[cnt],eax

	fld DWORD[x]
	fst ST1

	power_loop:
		cmp DWORD[cnt],1
		je got_power
		
		fmul ST1	
		dec DWORD[cnt]
		jmp power_loop
got_power:
	fstp DWORD[pr]
	ret

	
exit:
	mov eax, 1
	mov ebx, 0
	int 80h
	
	
WRITE:
	mov eax,4
	mov ebx,1
	int 80h
	ret

	
print1:
	 push ebp
	 mov ebp, esp
	 sub esp, 8
	 
	 fst qword[ebp-8]
	 push format2
	 call printf
	 
	 mov esp, ebp
	 pop ebp
	 ret

print2:
	 push ebp
	 mov ebp, esp
	 sub esp, 8
	 
	 fst qword[ebp-8]
	 push format3
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

