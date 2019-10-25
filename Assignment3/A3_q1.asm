;to interchange the diagonals of the matrix
section .data
msg1: db 'Rows:  '
mslen1:equ $-msg1
msg2: db 'Columns: '
mslen2:equ $-msg2
msg3: db 'Not a square matrix!!!!'
mslen3:equ $-msg3
msg4: db 'Enter the number '
mslen4:equ $-msg4
new: db 0Ah
size2: equ $-new
space:db '  '
size:equ $-space

section .bss
n:resw 1
m:resw 1
matrix: resw 100
temp: resd 1
dig: resb 1
count: resd 1
i: resd 1
j: resd 1
junk: resw 1
num: resw 1
dig2:resb 1


section .text
global _start:
_start:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,mslen1
int 80h
;check whether mov ecx,0 is required b4 all calls
call GETno
mov cx,word[num]
mov word[m],cx

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,mslen2
int 80h

call GETno
mov cx,word[num]
mov word[n],cx

mov ax,word[m]
cmp ax,word[n]
jne NOTSQ

cmp ax,0
je checkn


matrixREAD:
mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,mslen4
int 80h

mov ebx,matrix
mov eax,0
mov byte[i],0

i_loop:
mov byte[j],0

j_loop:
push ebx
push eax
call GETno
pop eax
pop ebx

mov cx,word[num]
mov word[ebx +eax*2],cx
inc eax
inc byte[j]
mov cl,byte[j]
cmp cl,byte[n]
jb j_loop
inc byte[i]
mov cl,byte[i]
cmp cl,byte[m]
jb i_loop

mov eax,0
mov ebx,matrix
mov byte[i],0
mov cx,word[n]
mov word[count],cx
i_loop3:
push ebx
push eax
;mov bl,byte[i]
;mov ah,0
;mov al,byte[n]
;mul bl
;mov word[count],ax		;count=i*n
mov al,byte[n]
movzx ax,al
mov word[temp],ax
movzx bx,byte[i]
sub word[temp],bx
dec word[temp]			;temp contains n-i-1
pop eax
pop ebx
add eax,dword[i]
mov cx,word[ebx + 2*eax]
sub eax,dword[i]
add eax,dword[temp]

mov dx,word[ebx + 2*eax]
mov word[ebx + 2*eax],cx
sub eax,dword[temp]

add eax,dword[i]
mov word[ebx + 2*eax],dx
sub eax,dword[i]
add eax,dword[count]

inc byte[i]

mov cl,byte[i]
cmp cl,byte[m]
jb i_loop3

		

;to print the matirx
mov ebx,matrix
mov eax,0
mov byte[i],0

i_loop2:
mov byte[j],0
j_loop2:
mov cx,word[ebx +eax*2]
mov word[num],cx
push ebx
push eax
cmp byte[num],0
je print0
call printnum
PR:
pop eax
pop ebx
inc eax
inc byte[j]
mov cl,byte[j]
cmp cl,byte[n]
jb j_loop2
push ebx
push eax
mov eax,4
mov ebx,1
mov ecx,new
mov edx,size2
int 80h
pop eax
pop ebx
inc byte[i]
mov cl,byte[i]
cmp cl,byte[m]
jb i_loop2
jmp exit


NOTSQ:
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,mslen3
int 80h
jmp exit

checkn:
mov al,byte[n]
cmp al,0
je exit
jmp matrixREAD

exit:
mov eax,1
mov ebx,0
int 80h

printnum:
mov byte[count],0
loop2:
mov ax,word[num]
cmp ax,0
je print
mov dx,0
mov bx,10
div bx
mov word[num],ax
push dx
inc byte[count]
jmp loop2

print:
cmp byte[count],0
je printdone
dec byte[count]
pop dx
mov byte[temp],dl
add byte[temp],30h

mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
jmp print

printdone:
mov eax,4
mov ebx,1
mov ecx,space
mov edx,size
int 80h
ret

print0:
add byte[num],30h
mov eax,4
mov ebx,1
mov ecx,num
mov edx,1
int 80h
mov eax,4
mov ebx,1
mov ecx,space
mov edx,size
int 80h
jmp PR 

GETno:
mov word[num],0
loopread:
mov eax,3
mov ebx,0
mov ecx,dig
mov edx,1
int 80h
cmp byte[dig],10
je readdone
mov ax,word[num]
mov bx,10
mul bx
mov word[num],ax
sub byte[dig],30h
movzx ax,byte[dig]
add word[num],ax
jmp loopread

readdone:
ret





