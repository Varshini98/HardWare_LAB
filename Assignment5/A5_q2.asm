section .data
str: db "Enter String: "	;palindromes in sub string
strl:equ $-str
new:db "Yes: "
newl:equ $-new
space:db ' '
len:equ 1
notpali:db "No palindromes "
notpalil: equ $-notpali

section .bss
string: resb 100
temp:resb 1
count:resb 1
starter:resb 1
index:resb 1
max:resb 1
caps:resb 1
cap2:resb 1
i:resb 1
j:resb 1
size:resb 1
ele:resb 1
num:resw 1
nod:resb 1
is:resb 1
js:resb 1
half:resb 1

section .text
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,str
mov edx,strl
int 80h

mov edi,string
cld
mov byte[size],0

pusha
reading:    ;READING

mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je endread

inc byte[size]
mov al,byte[temp]
stosb
jmp reading

endread:
mov al,0
stosb
popa
mov al,byte[size]

mov byte[i],0
mov al,byte[i]
inc al
mov byte[j],al

checking:
i_loop:
mov cl,byte[size]
dec cl
cmp byte[i],cl
je notp
j_loop:
mov cl,byte[size]
cmp byte[j],cl
je next_i

palicheck:		;PALI?
mov al,byte[j]
mov byte[js],al
mov bl,byte[i]
mov byte[is],bl
sub al,bl
inc al
mov byte[count],al
mov bl,2
div bl
mov byte[half],al

pa:
mov ebx,string

movzx eax,byte[is]
mov dl,byte[ebx+eax]

movzx eax,byte[js]
mov cl,byte[ebx+eax]

cmp dl,cl
jne not
inc byte[is]
dec byte[js]
dec byte[half]
cmp byte[half],0
jne pa

palin:          ;YES
pusha
mov eax,4
mov ebx,1
mov ecx,new
mov edx,newl
int 80h
popa
pusha
mov ebx,string
movzx eax,byte[i]
pri:
mov cl,byte[ebx+eax]
mov byte[temp],cl
pusha
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
popa
inc eax
dec byte[count]
cmp byte[count],0
jne pri
popa
jmp exit

not:
inc byte[j]
jmp j_loop

next_i:
inc byte[i]
mov al,byte[i]
inc al
mov byte[j],al
jmp i_loop
notp:
mov eax,4
mov ebx,1
mov ecx,notpali
mov edx,notpalil
int 80h

exit:

mov eax,1
mov ebx,0
int 80h

