section .bss
num:resw 2
nod:resb 2
temp:resb 2
matrix1:resw 200
m:resw 2
n:resw 2
i:resw 2
j:resw 2
k:resw 2

section .data
msg1:db 'Enter row:'
msg_size1:equ $-msg1
msg2:db 'Enter the elements:',0Ah
msg_size2:equ $-msg2
msg3:db 'Enter columns :'
msg_size3:equ $-msg3
tab:db 9
new_line:db 10
space: db 32
zero:db '0',0Ah
l:equ $-zero

section .text
global _start

_start:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,msg_size1
int 80h

mov ecx,0

call read_num
mov cx,word[num]
mov word[m],cx

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,msg_size3
int 80h

mov ecx,0
call read_num
mov cx,word[num]
mov word[n],cx

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,msg_size2
int 80h


read_matrix:
mov eax,0
mov ebx,matrix1
mov word[i],0
mov word[j],0

i_loop:
mov word[j],0

j_loop:

call read_num
mov dx,word[num]
mov word[ebx+ 2*eax],dx

inc eax
inc word[j]
mov cx,word[j]
cmp cx,word[n]
jb j_loop


inc word[i]
mov cx,word[i]
cmp cx,word[m]
jb i_loop


print_matrix:
 
mov ebx,matrix1

mov word[i],0
mov word[j],0
mov word[k],0


loopi:
movzx eax,word[j]
mov dx,word[ebx+2*eax]
mov word[num],dx
call print_num

pusha
mov eax,4
mov ebx,1
mov ecx,space
mov edx,1
int 80h
popa

inc word[j]
inc word[k]
mov dx,word[k]
cmp dx,word[n]
jb loopi

inc word[i]
mov dx,word[i]
cmp dx,word[m]
je exit

mov cx,word[n]
add word[j],cx
dec word[j]
mov word[k],0

loopj:
movzx eax,word[j]
mov dx,word[ebx+2*eax]
mov word[num],dx
call print_num

pusha
mov eax,4
mov ebx,1
mov ecx,space
mov edx,1
int 80h
popa

dec word[j]
inc word[k]
mov dx,word[k]
cmp dx,word[n]
jb loopj


inc word[i]
mov dx,word[m]
cmp word[i],dx
je exit


mov dx,word[n]
add word[j],dx
inc word[j]
mov word[k],0
jmp loopi


exit:
mov eax,1
mov ebx,0
int 80h

read_num:
 pusha
 mov word[num],0

 loop_read:
 mov eax,3
 mov ebx,0
 mov ecx,temp
 mov edx,1
 int 80h
  
 cmp byte[temp],32
 je end_read

 cmp byte[temp],10
 je end_read

 mov ax,word[num]
 mov bx,10
 mul bx
 mov bl,byte[temp]
 sub bl,30h
 mov bh,0
 add ax,bx
 mov word[num],ax

 jmp loop_read

 end_read:
 popa
 ret

 

print_num:
pusha
 cmp word[num],0
 jne extract_no
   mov eax,4
   mov ebx,1
   mov ecx,zero
   mov edx,l
   int 80h
   jmp end_print

 extract_no:
   cmp word[num],0
   je print_no
    
    inc byte[nod]
    mov dx,0
    mov ax,word[num]
    mov bx,10
    div bx
    push dx
   
   mov word[num],ax
   jmp extract_no
  
 print_no:
   cmp byte[nod],0
   je end_print

   dec byte[nod]
    pop dx

   mov byte[temp],dl
   add byte[temp],30h

   mov eax,4
   mov ebx,1
   mov ecx,temp
   mov edx,1
   int 80h
   
   jmp print_no
end_print:
popa
ret

