;Write a program to calculate the perimeter of a circle, it should accept the radius from the user.
section .data
	msg1: db "Enter the radius : ",0Ah
	len_msg1: equ $-msg1
	blank: db 10

	format1 db "%lf",0
	format2 db 10,"Perimeter = %lf",10
section .bss
	count: resb 1
	two: resd 1
section .text
	global main
	extern scanf
	extern printf
	
main:
	mov ecx, msg1
	mov edx, len_msg1
	call WRITE

	mov DWORD[two],2

get_radius:
	call read ;stores value to ST0....pushes other values down
	fst ST1
	fldpi
	fmul ST1 
	fild DWORD[two]
	fmul ST1	
	call print1

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

