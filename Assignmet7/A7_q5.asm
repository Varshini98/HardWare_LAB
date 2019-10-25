section .data
msg1: db "Enter the number X (|X|<=1.57) : ",0Ah
len1: equ $-msg1
msg2: db 0Ah
len2: equ $-msg2
err: db "error is here",0Ah
lene: equ $-err
format1 db "%lf",0
format3 db 10,"Sin(X) using processor instruction : %lf",0
format4 db 10,"Sin(X) using series expansion : %lf",10

section .bss

temp1: resb 1
temp2: resb 1
temp3: resb 1
ctr: resb 1
num2: resw 1
count: resd 1
num: resd 1
num1: resd 1
fact: resd 1
d4: resb 1
d3: resb 1
d2: resb 1
d1: resb 1
rad: resd 1

section .text
global main
extern scanf
extern printf

main:

 mov eax, 4
 mov ebx, 1
 mov ecx, msg1
 mov edx, len1
 int 80h

mov dword[fact],1
mov dword[num],3
mov dword[count],2
fldz

reading:
call read
fst dword[rad]
fsin
call print2

fld dword[rad]

series:
 mov eax,dword[num]
 mov dword[num1],eax
 fld dword[rad]

 check:
  dec dword[num1]
  cmp dword[num1],0
  je check1
  fmul dword[rad]
  jmp check
  
  check1:
   call fact1
   fidiv dword[fact]

   mov eax,dword[count]
   mov bl,2
   div bl
   cmp ah,0
   jnz check2
   fchs
   
   check2:
    fadd st1
 
    add dword[num],2
    inc dword[count]
    cmp dword[count],5
    jna series

call print3
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

;--------------------------------------------------------------------------------------------------------------------------------
fact1:
  
  mov eax, dword[num]
  cmp ax, 1
  je terminate
  push word[num]

  dec dword[num]
  call fact1

  pop word[num]
  mov edx, dword[num]

  mov eax, dword[fact]
  mul dx
  mov dword[fact], eax
  jmp exit1
  
terminate:
  mov dword[fact], 1

exit1:
  ret

