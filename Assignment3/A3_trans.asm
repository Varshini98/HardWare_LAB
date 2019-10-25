section .data
	msg1: db "ENTER THE ROW SIZE :"
	size1: equ $-msg1
	msg2:db "ENTER THE COLUMN SIZE :"
	size2:equ $-msg2
	msg3:db "ENTER AN ELEMENT :"
	size3:equ $-msg3
	msg4:db "THE MATRIX IS :",0Ah
	size4:equ $-msg4
	msg5:db "THE TRANSPOSE IS :",0Ah
	size5:equ $-msg5
	nw: db 0Ah
	s: db 32
	k: db 1

section .bss
	row: resb 1
	col: resb 1
	n: resb 1
	array: resb 50
	d1: resb 1
	d0: resb 1
	temp: resb 1
	temp1: resb 1
	i: resb 1
	j: resb 1
section .text
global _start
_start:
  mov eax, 4
  mov ebx, 1
  mov ecx, msg1
  mov edx, size1
  int 80h

  mov eax, 3
  mov ebx, 0
  mov ecx,row
  mov edx, 1
  int 80h

  mov eax,3
  mov ebx,0
  mov ecx,temp1
  mov edx,1
  int 80h

  mov eax, 4
  mov ebx, 1
  mov ecx, msg2
  mov edx, size2
  int 80h

  mov eax, 3
  mov ebx, 0
  mov ecx,col
  mov edx, 1
  int 80h

  mov eax,3
  mov ebx,0
  mov ecx,temp1
  mov edx,1
  int 80h

  sub byte[row], 30h
  sub byte[col], 30h 
  mov al,byte[row]
  mov bl,byte[col]
  mul bl
  mov byte[n],al
  mov byte[temp],al
  mov ebx,array
reading:
push ebx
  mov eax, 4
  mov ebx, 1
  mov ecx, msg3
  mov edx,size3
  int 80h
  
  mov eax, 3
  mov ebx, 0
  mov ecx, d1
  mov edx, 1
  int 80h
  mov eax, 3
  mov ebx, 0
  mov ecx, d0
  mov edx,1
  int 80h

 mov eax, 3
 mov ebx, 0
 mov ecx, temp1
 mov edx, 1
 int 80h

  sub byte[d1], 30h
  sub byte[d0], 30h  
  mov al, byte[d1]
  mov dl, 10
  mul dl
  add al, byte[d0]

  pop ebx
  mov byte[ebx], al
  add ebx, 1
  sub byte[temp],1
  cmp byte[temp], 0
  jg reading

  mov eax, 4
  mov ebx, 1
  mov ecx, msg4
  mov edx, size4
  int 80h


mov ebx,array
mov al,byte[col]
mov byte[i],al
mov al,byte[row]
mov byte[j],al


display:
push ebx
mov al,byte[ebx]
  mov cl, 10
  div cl
  mov byte[d1], al
  mov byte[d0], ah
  add byte[d0], 30h
  add byte[d1], 30h

  mov eax, 4
  mov ebx, 1
  mov ecx, d1
  mov edx, 1
  int 80h

  mov eax, 4
  mov ebx, 1
  mov ecx, d0
  mov edx, 1
  int 80h

  mov eax, 4
  mov ebx, 1
  mov ecx, s
  mov edx, 1
  int 80h
pop ebx
add ebx,1
dec byte[i]
cmp byte[i],0


jg display
push ebx
  mov eax, 4
  mov ebx, 1
  mov ecx, nw
  mov edx, 1
  int 80h
pop ebx
mov al,byte[col]
mov byte[i],al
dec byte[j]
cmp byte[j],0
jg display
	

  mov eax, 4
  mov ebx, 1
  mov ecx, msg5
  mov edx, size5
  int 80h


mov ebx,array
mov al,byte[col]
mov byte[i],al
mov al,byte[row]
mov byte[j],al




displayt:
push ebx
mov al,byte[ebx]
  mov cl, 10
  div cl
  mov byte[d1], al
  mov byte[d0], ah
  add byte[d0], 30h
  add byte[d1], 30h

  mov eax, 4
  mov ebx, 1
  mov ecx, d1
  mov edx, 1
  int 80h

  mov eax, 4
  mov ebx, 1
  mov ecx, d0
  mov edx, 1
  int 80h

  mov eax, 4
  mov ebx, 1
  mov ecx, s
  mov edx, 1
  int 80h

pop ebx
movzx eax,byte[col]
add ebx,eax
dec byte[j]
cmp byte[j],0
jg displayt

mov ebx,array
movzx eax,byte[k]
add ebx,eax
inc byte[k]
push ebx
  mov eax, 4
  mov ebx, 1
  mov ecx, nw
  mov edx, 1
  int 80h
pop ebx
mov al,byte[row]
mov byte[j],al
dec byte[i]
cmp byte[i],0
jg displayt







exit:
mov eax,1
mov ebx,0
int 80h
