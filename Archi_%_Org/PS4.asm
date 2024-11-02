section .data
    pro1 db 'Hi! This is Leo Tagum and Franco Aurellano and we are here to help you perform operations for 2 signed two-digit numbers (-99 to 99).', 10, 0
    pro2 db ' ==== SIMPLE CALCULATOR by Leo and Franco ====', 10, 0
    pro3 db  '[0] Exit',10, 0
    pro4 db '[1] Add', 10, 0
    pro5 db '[2] Subtract', 10, 0 
    pro6 db '[3] Multiply', 10, 0
    pro7 db '[4] Divide', 10, 0 
    ;error handeling:
    err db 'Please enter numbers (1-5)', 10, 0
    err2 db 'Please enter (-99 to 99) onlly', 10, 0
    ;useer input
    prompt1 db 'Enter your first number', 10, 0
    prompt2 db 'Enter your second number', 10,0
    prompt3 db 'Enter your 1-4', 10,0
    choice_input db '%d', 0
    num1_input db '%d', 0
    num2_input db '%d', 0
    ;Opperation
    sum db "sum = %d", 10, 0
    diff db "difference = %d", 10 ,0
    prod db "product = %d", 10, 0
    quo db "qoutient = ", 10, 0
    out_div db "%s%i", 10,"%s%i", 10, 0
    rem db "remainder: ", 10 , 0
section .bss
    num1 resb 100 
    num2 resb 100
    choice resb 1
    val1 resw 1
    val2 resw 1
    userinput resb 100
    result_v resw 1
section .text
    global _main
    extern _printf
    extern _scanf
_main:
    push pro1
    call _printf
    add esp, 4
main_loop:
    push pro2
    call _printf
    add esp, 4
    push pro3
    call _printf
    add esp, 4
    push pro4
    call _printf
    add esp, 4
    push pro5
    call _printf
    add esp, 4
    push pro6
    call _printf
    add esp, 4
    push pro7
    call _printf
    add esp, 4

    push prompt3
    call _printf
    add esp, 4

    push choice
    push choice_input
    call _scanf
    add esp, 4

    mov eax, [choice]
    cmp eax, 0
    je exit
    cmp eax, 1
    je addi
    cmp eax, 2
    je subt
    cmp eax, 3
    je multi
    cmp eax, 4
    je divi
    cmp eax, 5
    jg errormain
errormain:
    push err
    call _printf
    add esp, 4
    jmp main_loop

error_add:
    push err2
    call _printf
    add esp, 4
    jmp addi

error_sub:
    push err2
    call _printf
    add esp, 4
    jmp subt

error_mul:
    push err2
    call _printf
    add esp, 4
    jmp multi
error_div:
    push err2
    call _printf
    add esp, 4
    jmp divi
addi:
    push prompt1
    call _printf
    add esp, 4
    
    push num1 
    push num1_input
    call _scanf
    mov eax, [num1]
    cmp eax, 99
    jg error_add
    cmp eax, -99
    jl error_add
    add esp, 4


    push prompt2
    call _printf
    add esp, 4

    push num2
    push num2_input
    call _scanf
    mov eax, [num2]
    cmp eax, 99
    jg error_add
    cmp eax, -99
    jl error_add
    add esp,4
    



    mov eax, [num1]
    add eax, [num2]
    
    push eax
    push sum
    call _printf
    add esp,8
    jmp main_loop

    

subt:
    push prompt1
    call _printf
    add esp, 4
    
    push num1 
    push num1_input
    call _scanf
    mov eax, [num1]
    cmp eax, 99
    jg error_sub
    cmp eax, -99
    jl error_sub
    add esp, 4

    push prompt2
    call _printf
    add esp, 4

    push num2
    push num2_input
    call _scanf
    mov eax, [num2]
    cmp eax, 99
    jg error_sub
    cmp eax, -99
    jl error_sub
    add esp,4

    mov eax, [num1]
    sub eax, [num2]

    push eax
    push diff
    call _printf
    add esp,8
    jmp main_loop

multi:
    push prompt1
    call _printf
    add esp, 4
    
    push num1 
    push num1_input
    call _scanf
    mov eax, [num1]
    cmp eax, 99
    jg error_mul
    cmp eax, -99
    jl error_mul
    add esp, 8

    push prompt2
    call _printf
    add esp, 4

    push num2
    push num2_input
    call _scanf
    mov eax, [num2]
    cmp eax, 99
    jg error_mul
    cmp eax, -99
    jl error_mul
    add esp,8

    mov eax, [num1]
    mov ebx, [num2]

    mul ebx 
    push eax 
    push prod 
    call _printf
    add esp, 8
    jmp main_loop

divi: 
    push prompt1
    call _printf
    add esp, 4
    
    push num1 
    push num1_input
    call _scanf
    mov eax, [num1]
    cmp eax, 99
    jg error_div
    cmp eax, -99
    jl error_div
    add esp, 8

    push prompt2
    call _printf
    add esp, 4

    push num2
    push num2_input
    call _scanf
    mov eax, [num2]
    cmp eax, 99
    jg error_div
    cmp eax, -99
    jl error_div
    add esp,8

    mov eax, [num1]
    mov ebx, [num2]  
    mov edx, 0

    div ebx 

    push edx
    push rem
    push eax  
    push quo
    push out_div
    call _printf
    add esp, 20
    jmp main_loop
exit:
    ret