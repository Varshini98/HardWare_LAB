section .data
str1: db "Enter r1 and c1 :",0Ah
len1: equ $-str1
str2: db "Enter Matrix1: ",0Ah
len2: equ $-str2
str3: db "Invalid input",0Ah
len3: equ $-str3
str4: db "Enter r2 and c2 :",0Ah
len4: equ $-str4
str5: db "Enter Matrix2: ",0Ah
len5: equ $-str5
str6: db "Number of columns of A not equal to number of rows of B",0Ah
len6: equ $-str6
newline: db 0Ah
space: db " "

section .bss
num: resw 1
temp: resb 1
nod: resb 1
r1: resb 1
c1: resb 1
r2: resb 1
c2: resb 1
matrix1: resw 100
matrix2: resw 100
matrix3: resw 100
sum: resw 1
i: resb 1
j: resb 1
k: resb 1

section .text
global _start:
_start:

mov eax, 4
mov ebx, 1
mov ecx, str1
mov edx, len1	
int 80h

call read_num
mov ax, word[num]
mov byte[r1], al
call read_num
mov ax, word[num]
mov byte[c1], al

mov eax, 4
mov ebx, 1
mov ecx, str2
mov edx, len2	
int 80h

call read_matrix1

mov eax, 4
mov ebx, 1
mov ecx, str4
mov edx, len4	
int 80h

call read_num
mov ax, word[num]
mov byte[r2], al
call read_num
mov ax, word[num]
mov byte[c2], al

call check_order

mov eax, 4
mov ebx, 1
mov ecx, str5
mov edx, len5	
int 80h

call read_matrix2


call multiply_matrices
call print_matrix

mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h

mov eax, 1
mov ebx, 0
int 80h


;Function to check whether A and B are multiplyable
check_order:
pusha

mov al, byte[c1]
cmp al, byte[r2]
je end_check
mov eax, 4
mov ebx, 1
mov ecx, str6
mov edx, len6
int 80h

mov eax, 1
mov ebx, 0
int 80h

end_check:
popa
ret


;Function to multiply two matrices
multiply_matrices:
pusha
mov byte[i], 0								;I=0

loop_multiply_i:

mov byte[j], 0								;J=0

loop_multiply_j:

mov byte[k], 0								;K=0
mov word[sum], 0							;SUM=0

loop_multiply_k:							;C[I][J]+=A[I][K]+B[K][J]=SUM

movzx ax, byte[i]							
movzx bx, byte[k]							;ACCESS A[I][K]
movzx cx, byte[c1]							;I*c1--ACCESSING POSITION(ROW MAJOR..ACCESSING NEXT ELEMENT)
mul cx									
add ax, bx								
movzx ecx, ax								;POSITION AT ECX
mov edx, matrix1							;MAT 1 AT EDX
mov ax, word[edx+2*ecx]							;INCREMENT

push ax									;SAVE VALUE FROM MAT1, ACCESSING MAT2[K][J] VALUE
movzx ax, byte[k]
movzx bx, byte[j]
movzx cx, byte[c2]
mul cx
add ax, bx
movzx ecx, ax
mov edx, matrix2
mov bx, word[edx + 2*ecx]						;SAVED INTO BX
pop ax									;VALUE OF AX IS MAT1[I][K]
mul bx
add word[sum], ax
inc byte[k]								;K++
mov al, byte[k] 
cmp al, byte[r2]
jb loop_multiply_k

movzx bx, byte[c2]							;ENTERING SUMS TO NEW ARRAY
movzx ax, byte[i]
mul bx
movzx cx, byte[j]							;MAT3[I][J]=I*c2+J
add ax, cx
movzx ecx, ax
mov ax, word[sum]
mov edx, matrix3
mov word[edx+ 2*ecx], ax						;2 BYTE TO WORD
inc byte[j]

mov al, byte[j]
cmp al, byte[c2]
jb loop_multiply_j

inc byte[i]

mov al, byte[i]
cmp al, byte[r1]
jb loop_multiply_i


popa									
ret


;Function to read matrix1
read_matrix1:
pusha

mov byte[i], 0
mov edx, matrix1

loop_read1_i:

mov byte[j], 0

loop_read1_j:

call read_num
mov ax, word[num]
mov word[edx], ax

add edx, 2
inc byte[j]
mov al, byte[j]
cmp al, byte[c1]
jb loop_read1_j

inc byte[i]
mov al, byte[i]
cmp al, byte[r1]
jb loop_read1_i

popa
ret


;Function to read matrix2
read_matrix2:
pusha

mov byte[i], 0
mov edx, matrix2

loop_read2_i:

mov byte[j], 0

loop_read2_j:

call read_num
mov ax, word[num]
mov word[edx], ax

add edx, 2
inc byte[j]
mov al, byte[j]
cmp al, byte[c2]
jb loop_read2_j

inc byte[i]
mov al, byte[i]
cmp al, byte[r2]
jb loop_read2_i

popa
ret



;Function to print a matrix
print_matrix:
pusha
mov edx, matrix3
mov byte[i], 0
loop_print_i:

push edx
mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h
pop edx

mov byte[j], 0

loop_print_j:
mov ax, word[edx]
mov word[num], ax
call print_num

push edx
mov eax, 4
mov ebx, 1
mov ecx, space
mov edx, 1
int 80h
pop edx

add edx, 2
inc byte[j]
mov al, byte[j]
cmp al, byte[c2]
jb loop_print_j

inc byte[i]
mov al, byte[i]
cmp al, byte[r1]
jb loop_print_i

popa
ret


;Function to read a number
read_num:
pusha
mov word[num], 0

loop_read:
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 0Ah
je end_read

cmp byte[temp], 48
jb invalid_input
cmp byte[temp], 57
ja invalid_input

mov ax, word[num]
mov bx, 10
mul bx
movzx bx, byte[temp]
sub bx, 30h
add ax, bx
mov word[num], ax
jmp loop_read

invalid_input:
mov eax, 4
mov ebx, 1
mov ecx, str3
mov edx,len3
int 80h

mov eax, 1
mov ebx, 0
int 80h
end_read:
popa
ret

;Function for printing a number
print_num:
pusha
mov byte[nod],0

cmp word[num],0
je numzero
extract_no:
cmp word[num],0
je print_no
inc byte[nod]

mov dx, 0
mov ax, word[num]
mov bx, 10
div bx
mov word[num], ax
push dx
jmp extract_no

print_no:

cmp byte[nod],0
je end_print

dec byte[nod]
pop dx
mov byte[temp],dl
add byte[temp],30h

mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
jmp print_no

numzero:
add word[num], 30h
mov eax, 4
mov ebx, 1
mov ecx, num
mov edx, 1
int 80h 

end_print:
popa
ret
