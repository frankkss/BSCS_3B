section .data
    message db "This program computes for the average of 3 two-digit numbers (00-55)."
	frst_num db "Enter the first number: ", 10, 0
    sec_num db "Enter the second number", 10, 0
    thrd_num db "Enter the third number", 10, 0
	input_format db '%d', 0

    sum db "sum = %d", 10, 0
	avg_msg db "Average = %d", 10, 0
	quo db "quotient = %d", 10, 0

section .bss
	num1 resd 1
	num2 resd 1
	num3 resd 1
	total resd 1
	average resd 1
	remainder resd 1

section .text
	global _main
	extern _printf
	extern _scanf



_main:
    ; Display intro message
    push message 
    call _printf
    add esp,4

	; Prompt for the first number
    push frst_num
    call _printf
    add esp, 4
	push num1
	push input_format
	call _scanf
	add esp, 8


	; Prompt for the second number
    push sec_num
    call _printf
    add esp, 4
	
	
	;adding 45 and 55
	push frst_num 
    push sec_num  
    push thrd_num
  	mov eax, 45
  	mov ebx, 55
  	add eax,ebx
  	push eax
  	push sum
  	call _printf
  	add esp, 8



	ret

