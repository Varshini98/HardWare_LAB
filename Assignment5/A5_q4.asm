section .data
str: db "Enter String: "	;SMallest and biggest words
strl:equ $-str
small:db "Smallest Word: "
smalll:equ $-small
big:db " Biggest Word: "
bigl: equ $-big
enter:db 10
l:equ 1


section .bss
string: resb 50
temp:resb 1
count:resb 1
starter:resb 1
max:resb 1
index:resb 1
min:resb 1

section .text
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,str
mov edx,strl
int 80h

mov ebx,string
mov byte[count],0

reading:    ;READING

pusha
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
popa

cmp byte[temp],10
je endread

inc byte[count]
mov al,byte[temp]
mov byte[ebx],al
inc ebx
jmp reading

endread:
mov byte[ebx],0

pusha
mov eax,4
mov ebx,1
mov ecx,big
mov edx,bigl
int 80h
popa

mov ebx,string
mov byte[starter],0
mov byte[count],0
mov byte[max],0
mov byte[index],0

checking:		;LARGEST WORD

mov dl,byte[ebx]
cmp dl,' '
je endcount
cmp dl,0
je endcheck

inc byte[count]
inc byte[index]
inc ebx
jmp checking

endcount:
mov cl,byte[max]
cmp cl,byte[count]
jb newmax

jmp baaki

newmax:
mov cl,byte[count]
mov byte[max],cl
mov dl,byte[index]
sub dl,cl
mov byte[starter],dl
baaki:
mov byte[count],0
inc byte[index]
inc ebx


jmp checking

endcheck:

mov cl,byte[max]
cmp cl,byte[count]
jb newmax2

jmp print
newmax2:
mov cl,byte[count]
mov byte[max],cl
mov dl,byte[index]
sub dl,cl
mov byte[starter],dl


print:
mov ebx,string
movzx eax,byte[starter]
printmax:
mov cl,byte[ebx+eax]
cmp cl,0
je endprint1
cmp cl,' '
je endprint1
mov byte[temp],cl

pusha
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
popa
inc eax
jmp printmax

endprint1:
mov ebx,string
mov byte[count],0
mov byte[index],0
mov byte[starter],0
mov cl,byte[max]
mov byte[min],cl

pusha
mov eax,4
mov ebx,1
mov ecx,enter
mov edx,1
int 80h
popa

checking2:		;SMALLEST WORD

mov dl,byte[ebx]
cmp dl,' '
je endcount2
cmp dl,0
je endcheck2

inc byte[count]
inc byte[index]
inc ebx
jmp checking2

endcount2:
mov cl,byte[min]
cmp byte[count],cl
jb newmin

jmp baaki2

newmin:
mov cl,byte[count]
mov byte[min],cl
mov dl,byte[index]
sub dl,cl
mov byte[starter],dl
baaki2:
mov byte[count],0
inc byte[index]
inc ebx
jmp checking2

endcheck2:

mov cl,byte[max]
cmp cl,byte[count]
jb newmin2
jmp print2
newmin2:
mov cl,byte[count]
mov byte[max],cl
mov dl,byte[index]
sub dl,cl
mov byte[starter],dl

print2:

pusha
mov eax,4
mov ebx,1
mov ecx,small
mov edx,smalll
int 80h
popa


mov ebx,string
movzx eax,byte[starter]
printmin:

mov cl,byte[ebx+eax]
cmp cl,0
je endprint
cmp cl,' '
je endprint
mov byte[temp],cl

pusha
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
popa
inc eax
jmp printmin


endprint:

mov eax,1
mov ebx,0
int 80h