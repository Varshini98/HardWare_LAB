section .data
format1: db "%lf",0
format2 db 10,"The cube is : %lf",10, 10
format3 db 10,"The difference is : %lf",0
format4 db 10,"The product is : %lf",10,10
msg1: db "Enter the 2 numbers : "
len1: equ $-msg1


section .bss

temp1: resb 1
temp2: resb 1
temp3: resb 1
num: resb 1
ctr: resb 1
num2: resw 1
sum : resd 1
cube: resd 1
diff : resd 1
mul : resd 1
var1 : resd 1







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
 
 mov byte[ctr],2

fldz

reading:
call read
dec byte[ctr]
cmp byte[ctr], 0
jne reading

fst dword[var1]
fadd ST1
fst dword[sum]
fldz
fadd ST1
fmul ST1
fmul ST1
fstp dword[cube]

fld dword[cube]
call print1

exit:
mov eax, 1
mov ebx, 0
int 80h

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
 lea eax, [esp]
 push eax
 push format1
 call scanf
 fld qword[ebp-8]
 mov esp, ebp
 pop ebp
 ret

