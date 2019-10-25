;to implement the given recursive function

section .data
msg1: db 'enter value of i:',0Ah
len1: equ $-msg1
new: db 10
blank: db 10
space: db 32

section .bss
num: resw 1
i: resw 1
sum: resw 1
nod:resb 1
dig: resb 1

section .text
global _start
_start:

mov byte[nod],0

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

call read_num

mov ax,word[num]
mov word[i],ax

call fibonacci

mov ax,word[sum]
mov word[num],ax

call print_num

mov eax,4
mov ebx,1
mov ecx,new
mov edx,1
int 80h

mov eax,1
mov ebx,0
int 80h

;end pgm

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

cmp word[num],0
je print_zero

loop_print:

cmp word[num],0
je print_no
inc byte[nod]
mov dx,0
mov ax,word[num]
mov bx,10
div bx
push dx
mov word[num],ax
jmp loop_print

print_no:
cmp byte[nod],0
je end_print
dec byte[nod]
pop dx
mov byte[dig],dl
add byte[dig],30h

mov eax,4
mov ebx,1
mov ecx,dig
mov edx,1
int 80h

jmp print_no
end_print:
popa
ret

print_zero:

add word[num],30h
mov eax,4
mov ebx,1
mov ecx,num
mov edx,1
int 80h
jmp end_print

fibonacci:
pusha
cmp word[i],0
je zero

cmp word[i],1
je one

;mov ax,word[i]
dec word[i]
mov ax,word[i]
call fibonacci
mov dx,word[sum]
mov word[i],ax
dec word[i]
call fibonacci
add word[sum],dx
jmp exit

zero:
mov word[sum],0
jmp exit

one:
mov word[sum],1

exit:
popa
ret










;mov ecx,enter1
;mov edx,len_enter1
;call WRITE
	
;call GETANYNUMBER
;mov eax,DWORD[number]
;mov DWORD[num1],eax
	
;mov ecx,enter2
;mov edx,len_enter2
;call WRITE
	
;call GETANYNUMBER
;mov eax,DWORD[number]
;mov DWORD[num2],eax
	
;mov ecx,result
;mov edx,len_result
;call WRITE
	
;mov ebx,DWORD[num1]
;mov ecx,DWORD[num2]
;call GCD
	
	;;;;;result is in ebx
;mov eax,ebx
;call DISPLAYNUMBER
	
;call NEWLINE
	
;jmp exit	
	
;exit:
	;mov eax,1
	;mov ebx,0
	;int 80h
	
	;;ebx-first number
	;;ecx-second number
	;;ebx-return value-GCD
;GCD:
	;cmp ebx,ecx
	;je got_GCD
	;jb exchange_recursive_call
	;ja subtract_recursive_call
;exchange_recursive_call:
	;cmp ebx,0
	;je got_GCD

	;mov edx,ebx
	;mov ebx,ecx
	;mov ecx,edx
	;call GCD
	;ret
;subtract_recursive_call:
	;cmp ecx,0
	;jne do
	;mov ebx,0
	;jmp got_GCD
	;do:	
		;sub ebx,ecx
		;call GCD
;got_GCD:
	;ret


	;;result in number
;GETANYNUMBER:
	;mov DWORD[number],0
  ;getnumber:
	;mov ecx,digit
	;mov edx,1
	;call READ

	;cmp BYTE[digit],10                 ;is digit=newline
	;jne carryon
	;ret			   	   ;got the n digit number
  ;carryon:				   ;to change number from ascii
	;sub byte[digit],30h
	;mov eax,DWORD[number]
	;mov ebx,10
	;mul ebx
	
	;movzx ebx,byte[digit]
	;add eax,ebx
	;mov DWORD[number],eax
	;jmp getnumber

	;;eax-number to be displayed
;DISPLAYNUMBER:
  	;mov BYTE[stringlen], 0
  	;mov ebx, string
  	;add ebx, 9           ;pointing to end of string
   ;convert_number:
	;mov edx, 0
  	;mov ecx, 10
  	;div ecx
  
 	;mov BYTE[ebx], dl
	;add BYTE[ebx], 48  ;coverting the got digit to ascii equivalent
  
  	;inc BYTE[stringlen]
  	;cmp eax, 0
  	;je convert_done
  	;dec ebx
  	;jmp convert_number
  ;convert_done:
  	;mov ecx, ebx
  	;movzx edx, BYTE[stringlen]
  	;call WRITE
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
	;rett
