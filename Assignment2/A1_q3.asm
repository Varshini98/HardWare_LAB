section .data
	msg1: db 'Enter the size of the array: '
	length1: equ $-msg1
	
	msg2: db 'Enter the element: '
	length2: equ $-msg2

	el: db 0Ah
	le: equ $-el

        hi: db 'hi',0Ah
        l: equ $-hi

	

section .bss
        i: resb 1
	j: resb 1
	k: resb 1
	t: resb 1
	n: resb 1
	s: resb 1
	b: resb 1
	a: resb 1
	array: resb 100
	dig1: resb 1
	dig2: resb 1
	junk: resb 1
        temp: resd 1


section .text
	global _start:
	_start:

        
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,length1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,dig1
	mov edx,1
	int 80h


	mov eax,3
	mov ebx,0
	mov ecx,dig2
	mov edx,1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h
	
       	sub byte[dig1],30h
       	sub byte[dig2],30h
   

	mov al,byte[dig1]
	mov bl,10
	mul bl
	add al,byte[dig2]
	mov byte[n],al
	mov byte[t],al
	mov byte[s],al

;INPUTED SIZE OF ARRAY



;INPUTING ARRAY


	mov ebx,array
	
reading:

        push ebx

	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,length2
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,dig1
	mov edx,1
	int 80h


	mov eax,3
	mov ebx,0
	mov ecx,dig2
	mov edx,1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h
	
       	sub byte[dig1],30h
       	sub byte[dig2],30h
   

	mov al,byte[dig1]
	mov bl,10
	mul bl
	add al,byte[dig2]

        pop ebx
	mov byte[ebx],al
	add ebx,1
        dec byte[t]
        cmp byte[t],0
	jg reading
        



sub byte[n],1
	
mov byte[i],0

loop1:
	mov ebx,array	
	mov byte[j],0

	loop2:
		mov al,byte[ebx]
	        mov byte[a],al
		add ebx,1
                mov cl,byte[ebx]
		mov byte[b],cl


		cmp al,cl
		jb swap

		
		
		inc byte[j]
		mov cl,byte[j]
		cmp cl,byte[n]
		jb loop2
	        jmp continue
		swap:
		
		
		mov al,byte[a]
		mov cl,byte[b]
                 
		mov byte[ebx],al
		sub ebx,1
		mov byte[ebx],cl
		
	        continue:
		add ebx,1
		inc byte[j]
		mov cl,byte[j]
		cmp cl,byte[n]
		jb loop2




inc byte[i]
mov al,byte[i]
cmp al,byte[n]
jbe loop1

mov byte[i],0
mov ebx,array
printing:
        push ebx
	mov al,byte[ebx]
        mov bl,10
	div bl
	mov [dig1],al
	mov [dig2],ah

	add byte[dig1],30h
	add byte[dig2],30h

	mov eax,4
	mov ebx,1
	mov ecx,dig1
        mov edx,1
	int 80h

	mov eax,4
	mov ebx,1
	mov ecx,dig2
        mov edx,1
	int 80h

	mov eax,4
	mov ebx,1
	mov ecx,el
	mov edx,le
	int 80h
	
pop ebx
add ebx,1
inc byte[i]
mov al,byte[n]
cmp byte[i],al
jbe printing





        exit:
	mov eax,1
	mov ebx,0
	int 80h
