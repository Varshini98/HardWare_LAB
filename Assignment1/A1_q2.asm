global _start
_start:

	
	mov edx,1
	mov ecx,num
	mov ebx,0
	mov eax,3
	int 80h
	
	
	mov byte[i],0
	mov byte[sum], 0
	sub byte[num],30h
	
	
loop:
	mov al,byte[num]
	cmp byte[i],al 
	jna if

	else:
	mov bl,10
	mov al,byte[sum]
	div bl
	mov byte[sum],al
	mov byte[d],ah
	
	add byte[sum],30h 
	add byte[d],30h
	
	mov edx,1
	mov ecx,sum
	mov ebx,1
	mov eax,4
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,d
	mov edx,1
	int 80h
	
	jmp exit
	
	
	if:
	mov al, byte[i]
	add byte[sum], al
	
	inc byte[i] 
	jmp loop 
	
	
	
	
	exit:
		mov eax,1
		mov ebx,0
		int 80h
	
section .bss
	num: resb 1 
	i: resb 1
	sum: resb 1
	d: resb 1
