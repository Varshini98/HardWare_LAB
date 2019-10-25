section .data
a: db '0',0Ah
b: db '1',0Ah
i: db '2',0Ah
section .bss
c: resb 1



section .text
global _start
_start:

mov eax,4
mov ebx,1
mov ecx,a
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,b
mov edx,1
int 80h
        
	mov al, 0
	mov bl, 0
	mov byte[c],0
	sub byte[a],30h
	sub byte[b],30h
	
	for:
	
        mov al,byte[a]
	mov bl, byte[b]
	add al ,bl
        mov byte[c],al
	add byte[c],30h
	

	mov eax,4
	mov ebx,1
	mov ecx,c
	mov edx,1
	int 80h
 
        sub byte[c],30h
	mov bl, byte[b]
        mov byte[a],bl

        mov cl,byte[c]
	mov byte[b], cl
	inc byte[i]
	mov cl, byte[i]
	cmp cl, '5'
	jb for



mov eax, 1
mov ebx, 0
int 80h

