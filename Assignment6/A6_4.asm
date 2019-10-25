
section .bss
i:resb 1
sum: resw 1
number: resw 1
nod: resb 1
dig: resb 1
digit1: resb 1
digit0: resb 1
num: resb 1
n: resb 1

section .data
msg1: db 'Enter the number ',0Ah
len1: equ $ -msg1
msg2: db 'hi'
len2: equ $ -msg2

section .text
global _start
_start:
mov word[sum],1

reading: 
        
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,len1
	int 80h
        
        call read_num
       
        

call findsum

mov ax,word[sum]
mov word[number],ax

call print_num
exit:
mov eax,1
mov ebx,0
int 80h




read_num:

pusha
mov word[num],0
loop:

mov eax,3
mov ebx,0
mov ecx,dig
mov edx,1
int 80h

cmp byte[dig],10
je end
sub byte[dig],30h
mov al,byte[num]
mov bl,10
mul bl
add al,byte[dig]
mov byte[num],al
jmp loop


end:
popa
ret



print_num:
pusha
cmp word[number],0
je printzero
loop5:
	cmp word[number], 0
	je print_no
	inc byte[nod]
	mov dx, 0
	mov ax, word[number]
	mov bx, 10
	div bx
	push dx
	mov word[number], ax
	jmp loop5

	print_no:

	cmp byte[nod], 0
	je end_print
	dec byte[nod]
	pop dx
	mov byte[dig], dl
	add byte[dig], 30h
mov eax,4
mov ebx,1
mov ecx,dig
mov edx,1
int 80h


jmp print_no

end_print:
popa
ret

printzero:
add word[number],30h
mov eax,4
mov ebx,1
mov ecx,number
mov edx,1
int 80h
jmp end_print



findsum:
cmp byte[num],0
jne factorial
ret

factorial:
mov al,byte[num]
mov ah,0
mov ebx,dword[sum]
mul ebx
mov dword[sum],eax

sub byte[num],1
call findsum

ret







;;read string
	;mov ecx,enter
	;mov edx,len_enter
	;call WRITE
	
	;mov ebx,str
	;call READSTRING
	
	;mov ecx,result
	;mov edx,len_result
	;call WRITE
	
	;mov ebx,str
	;call CAPITAL

	;cmp eax,0
	;je no_caps

	;mov ecx,eax
	;mov edx,1
	;call WRITE
	;call NEWLINE
	;jmp exit
;no_caps:
	;mov ecx,no
	;mov edx,lenno
	;call WRITE 
	;call NEWLINE
;exit:
	;mov eax,1
	;mov ebx,0
	;int 80h
;;SUBROUTINES
	
;CAPITAL:
	;cmp BYTE[ebx],0
	;jne next1
	;mov eax,0
	;jmp capital_finding_done
;next1:
	;cmp BYTE[ebx],'A'
	;jb next
	;cmp BYTE[ebx],'Z'
	;ja next
	;mov eax,ebx
	;jmp capital_finding_done
	
;next:
	;inc ebx
	;call CAPITAL
;capital_finding_done:
	;ret

;WRITE:
	;mov eax,4
	;mov ebx,1
	;int 80h
	;ret
;READ:
	;mov eax,3
	;mov ebx,0
	;int 80h
	;ret
;NEWLINE:
	;mov ecx,blank
	;mov edx,1
	;call WRITE
	;ret
;READSTRING:
	;mov BYTE[str_len],0
;read_character:
	;push ebx
	;mov ecx,char
	;mov edx,1
	;call READ
	;pop  ebx
	
	;cmp BYTE[char],10
	;jne carry_on
	;mov BYTE[ebx],0
	;ret
;carry_on:	
	;inc BYTE[str_len]
	;mov al,BYTE[char]
	;mov BYTE[ebx],al
	;add ebx,1
	;jmp read_character
	
;SHIFT:
	;dec BYTE[str_len]
	
	;mov al,BYTE[temp]
	;mov BYTE[temp1],al
;process:
	;cmp BYTE[temp1],0
	;jne do 
	;ret
;do:
	;mov al,BYTE[ebx+1]
	;mov BYTE[ebx],al
	;inc ebx
	;dec BYTE[temp1]
	;jmp process
