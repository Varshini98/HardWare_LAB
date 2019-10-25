section .data
msg1: db "Enter the values of a,b,c : ",0Ah
len1: equ $-msg1
msg2: db 0Ah
len2: equ $-msg2
msg3: db "Roots are imaginary"
len3: equ $-msg3
format1 db "%lf",0
format3 db 10,"The second root is : %lf",10
format4 db 10,"The first root is : %lf",0

section .bss

temp1: resb 1
temp2: resb 1
temp3: resb 1
temp: resd 1
zero: resd 1
zero1: resd 1
num: resb 1
ctr: resb 1
num2: resw 1

section .textk
global main
extern scanf
extern printf


main:
 mov dword[temp],2
 mov dword[zero],0
 
 mov eax, 4
 mov ebx, 1
 mov ecx, msg1
 mov edx, len1
 int 80h

mov al,3
mov byte[num], al
mov byte[ctr], al
mov ah, 0
mov word[num2], ax

fldz

reading:
call read
dec byte[ctr]
cmp byte[ctr], 0
jne reading

fldz
fadd st2
fmul st2
fldz
fadd st4
fmul st2
fadd st0
fadd st0
fsubr st1
fsqrt
fist dword[zero1]
mov eax,dword[zero1]
cmp eax,dword[zero]
jl not

and:
fdiv st4

fld st3
fchs
fdiv st5

fadd st1
fidiv dword[temp]
call print3

fadd st0
fsub st1
fsub st1
fidiv dword[temp]
call print2

exit:
mov eax, 1
mov ebx, 0
int 80h

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

print3:

 push ebp
 mov ebp, esp
 sub esp, 8
 fst qword[ebp-8]
 push format4
 call printf
 mov esp, ebp
 pop ebp
 ret

read:
 push ebp
 mov ebp, esp
 sub esp, 8
 lea eax, [esp]
 push eax
 push format1
 call scanf
 fld qword[ebp-8]
 mov esp, ebp
 pop ebp
 ret


not:

 mov eax, 4
 mov ebx, 1
 mov ecx, msg3
 mov edx, len3
 int 80h

 mov eax, 4
 mov ebx, 1
 mov ecx, msg2
 mov edx, len2
 int 80h
 jmp exit
