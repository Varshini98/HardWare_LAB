
section .data
mes1: db "Enter the value of n : "
len1: equ $-mes1
mes2:db "Enter the values :",0Ah
len2:equ $-mes2
mes3: db "Enter the value of k : "
len3: equ $-mes3
error: db "Error"
errlen: equ $-error
open: db '('
close:db ')'
newline:db 10
comma:db ','

;mes4: db "Roots are : ",0Ah
;len4: equ $-mes4
format1: db "%lf", 0
format2: db "%lf", 10

section .bss
array:resq 100
k:resq 1
tmp: resb 1
zero:resd 1
n1:resq 1
n2:resq 1
temp:resq 1
num:resw 1
n:resd 1
nod:resb 1
i:resd 1
j:resd 1


section .text
global main:
extern scanf
extern printf

main:

;;Enter a floating point number

mov eax,4
mov ebx,1
mov ecx,mes3
mov edx,len3
int 80h

call read_float
fstp qword[k]

mov eax, 4
mov ebx, 1
mov ecx, mes1
mov edx, len1
int 80h

call read_num
movzx eax,word[num]
mov dword[n],eax

;Reading into array
mov esi,array
mov edi,0

read:
cmp dword[n],edi
je end_reading
call read_float
fstp qword[esi+8*edi]
inc edi
jmp read


end_reading:

call print_newline

mov edi,0
mov edx,dword[n]

	mov ebx,0
	mov esi,array

	loopi:

	cmp ebx,edx
	je exit
	mov edi,ebx  ;j=i+1
	add edi,1
	loopj:

	cmp edi,edx
	jne L1
	inc ebx
	jmp loopi

	L1:

	fld qword[esi+8*ebx]
	fadd qword[esi+8*edi]
	fcomp qword[k]
	fstsw ax
	sahf
	jne cont
	
	pusha;;;;;;;;;;;;;this pusha was not there...when it wasnt there it showed segmentation error
	fld qword[esi+8*ebx]
	call print_float
	ffree ST0
	fld qword[esi+8*edi]
	call print_float
	call print_newline
	;;;;;;;;;;;;;;;;;;;;;;this ffree if not present does not give output...why????

	popa
	cont:
	ffree ST0
	inc edi
	jmp loopj


print_open:
pusha
mov eax,4
mov ebx,1
mov ecx,open
mov edx,1
int 80h
popa
ret

print_close:
pusha
mov eax,4
mov ebx,1
mov ecx,close
mov edx,1
int 80h
popa
ret

print_newline:
pusha
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa
ret

print_comma:
pusha
mov eax,4
mov ebx,1
mov ecx,comma
mov edx,1
int 80h
popa
ret

print:
mov edi,0
mov esi,array
start_printing:
cmp edi,dword[n]
je exit
fld qword[esi+8*edi]
call print_float
inc edi
jmp start_printing




exit:
mov eax, 1
mov ebx, 0
int 80h   

print_error:
mov eax,4
mov ebx,1
mov ecx,error
mov edx,errlen
int 80h
jmp exit

;;;;;;;;;;;;;;;;;;;;function to read floating point

read_float:
push ebp
mov ebp, esp
sub esp, 8

lea eax, [esp]
push eax
push format1
call scanf
fld qword[ebp - 8]

mov esp, ebp
pop ebp
ret

;;;;;;;;;;;;;;;function to print floating point

print_float:
push ebp
mov ebp, esp
sub esp, 8

fst qword[ebp - 8]
push format2
call printf
mov esp, ebp
pop ebp
ret

read_num:
pusha
mov byte[num], 0
loop_read:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
cmp byte[temp], 10
je end_read
mov al, byte[num]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add al, bl
mov byte[num], al
jmp loop_read
end_read:
popa
ret
;Function to print any number stored in num...

print_num:
pusha

cmp byte[num],0
ja extract_no
add byte[num],30h
mov eax,4
mov ebx,1
mov ecx,num
mov edx,1
int 80h
popa
ret
extract_no:
cmp byte[num], 0
je print_no
inc byte[nod]
mov dx, 0
mov al, byte[num]
mov bx, 10
div bx
push dx
mov byte[num], al
jmp extract_no
print_no:
cmp byte[nod], 0
je end_print
dec byte[nod]
pop dx
mov byte[temp], dl
add byte[temp], 30h

mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h


jmp print_no
end_print:

popa
ret



