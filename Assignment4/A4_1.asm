section .data
a_cnt: db 0
e_cnt: db 0
i_cnt: db 0
o_cnt: db 0
u_cnt: db 0
string_len: db 0
msg1: db "Enter a string : "
size1: equ $-msg1
msg_a: db 10 , "No of a : "
size_a: equ $-msg_a
msg_e: db 10, "No of e : "
size_e: equ $-msg_e
msg_i: db 10, "No of i : "
size_i: equ $-msg_i
msg_o: db 10, "No of o : "
size_o: equ $-msg_o
msg_u: db 10, "No of u : "
size_u: equ $-msg_u
blank: db 10

section .bss
string: resb 50
temp: resb 1

section .data
global _start
_start:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,size1
int 80h
mov ebx,string

reading:
push ebx
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1

int 80h
pop ebx
cmp byte[temp], 10
je end_reading
inc byte[string_len]
mov al,byte[temp]
mov byte[ebx], al
inc ebx
jmp reading

end_reading:
mov byte[ebx], 0
mov ebx, string

counting:
mov al, byte[ebx]
cmp al, 0
je end_counting
cmp al,'a'
je inc_a
cmp al,'e'
je inc_e
cmp al,'i'
je inc_i
cmp al, 'o'
je inc_o
cmp al,'u'
je inc_u
cmp al,'A'
je inc_a
cmp al,'E'
je inc_e
cmp al,'I'
je inc_i
cmp al,'O'
je inc_o
cmp al,'U'
je inc_u

next:
inc ebx
jmp counting
end_counting:

;Printing the no of a
mov eax, 4
mov ebx, 1
mov ecx, msg_a
mov edx, size_a
int 80h
add byte[a_cnt], 30h
mov eax, 4
mov ebx, 1
mov ecx, a_cnt
mov edx, 1
int 80h

;Printing the no of e
mov eax, 4
mov ebx, 1
mov ecx, msg_e
mov edx, size_e
int 80h
add byte[e_cnt], 30h
mov eax, 4
mov ebx, 1
mov ecx,e_cnt
mov edx,1
int 80h

;Printing the no of i
mov eax, 4
mov ebx, 1
mov ecx, msg_i
mov edx, size_i
int 80h
add byte[i_cnt], 30h
mov eax, 4
mov ebx, 1
mov ecx, i_cnt
mov edx, 1
int 80h

;Printing the no of o
mov eax, 4
mov ebx, 1
mov ecx, msg_o
mov edx, size_o
int 80h
add byte[o_cnt], 30h
mov eax, 4
mov ebx, 1
mov ecx, o_cnt
mov edx, 1
int 80h

;Printing the no of u
mov eax, 4
mov ebx, 1
mov ecx, msg_u
mov edx, size_u
int 80h
add byte[u_cnt], 30h
mov eax, 4
mov ebx, 1
mov ecx, u_cnt
mov edx, 1
int 80h

call NEWLINE

exit:
mov eax, 1
mov ebx, 0
int 80h

inc_a:
inc byte[a_cnt]
jmp next

inc_e:
inc byte[e_cnt]
jmp next

inc_i:
inc byte[i_cnt]
jmp next

inc_o:
inc byte[o_cnt]
jmp next

inc_u:
inc byte[u_cnt]
jmp next

NEWLINE:
	mov ecx,blank
	mov edx,1
	mov eax,4
	mov ebx,1
	int 80h
	ret
