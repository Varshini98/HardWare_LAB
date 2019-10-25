section .bss
	string : resb 50
	str_len : resb 1
	temp : resb 1
	count : resb 1
	max_count : resb 1

section .data
	new_line : db 10

section .text
global _start

_start:
	mov byte[str_len],0
	mov byte[count],0
	mov byte[max_count],0

	mov edi,string
    reading:
	mov eax,3
	mov ebx,0
	mov ecx,temp
	mov edx,1
	int 80h

	cmp byte[temp],10
	je end_read

	cld
	mov al,byte[temp]
	stosb
	inc byte[str_len]
	jmp reading

    end_read:
	mov al,0
	stosb

	mov esi,string
    check:
	cld
	lodsb
	cmp al,0
	je exit

	cmp al,90
	ja check

	mov ecx,esi
    loop:	
	mov dl,byte[ecx]
	add ecx,1
	
	cmp dl,0
	je check

	cmp dl,90
	jb upper

    iter2:
	jmp loop

    upper:
	push esi
	push ecx
	mov edx,ecx
	sub ecx,2
	jmp find_count
;	
;
    iter:
	
	pop ecx
	pop esi
;	
	mov dl,byte[count]
	cmp dl,byte[max_count]
	ja found_max

	jmp iter2

  found_max:
	mov byte[max_count],dl
	jmp iter2
	
;;
   find_count:
	mov byte[count],0
;	mov esi,string
;	mov ecx,string
;	movzx ebx,byte[str_len]
;	add ecx,ebx
;	sub ecx,1

    checking:
		
	cld
	lodsb
	sub esi,1
	cmp esi,ecx
	ja iter

	add esi,1

	cmp al,90
	jb checking

	mov ebx,esi
      loop1:
	mov dl,byte[ebx]

	cmp ebx,ecx
	ja found

	
	cmp al,dl
	je checking

	add ebx,1
	jmp loop1

	
    found:
	inc byte[count]
	jmp checking
	
    exit:
	add byte[max_count],30h
	mov eax,4
	mov ebx,1
	mov ecx,max_count
	mov edx,1
	int 80h

	mov eax,4
	mov ebx,1
	mov ecx,new_line
	mov edx,1
	int 80h

	mov eax,1
	mov ebx,0
	int 80h	
