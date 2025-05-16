;Bitwise Operations Tool
;Fuctionality:
;   · AND operation on two integers
;   · OR operation on two integers
;   · XOR operation on two integers
;   · Left shift an integer

section .data
    pro1 db "|===================================================================================|", 10, \
            '|  Hi! This is Group 8 and this program will help you to perform Bitwise.           |', 10, \
            "|===================================================================================|", 10, 0
    pro2 db "|===================================================================================|", 10, \
            "|                    B I T W I S E  O P E R A T I O N  T O O L S                    |", 10, \
            "|===================================================================================|", 10, \
            "|     [1] AND Operation Tool                                                        |", 10, \
            "|     [2] OR Operation Tool                                                         |", 10, \
            "|     [3] XOR Operation Tool                                                        |", 10, \
            "|     [4] LEFT SHIFT Operation Tool                                                 |", 10, \
            "|     [5] Exit                                                                      |", 10, \
            "|===================================================================================|", 10, \
            "|===================================================================================|", 10, 0
    pro8 db "|===================================================================================|", 10, \
            "|                          Thank you for using our program!                         |", 10, \
            "|===================================================================================|", 10, 0
    ;Error Handling:
    err1 db "|     Invalid choice. Please enter only numbers (1-5)                               |", 10, 0
    err2 db '|     Input should only be between -1000 to 1000. Please enter again a valid input. |', 10, 0
    err3 db '|     You can not shift by more bits than 16-bits.                                  |', 10, 0
    err4 db '|     You can not shift by negative bits.                                           |', 10, 0
    ;Title
    ti1 db  "|===================================================================================|", 10, \
            "|                         A N D  O P E R A T I O N  T O O L                         |", 10, \
            "|===================================================================================|", 10, 0
    ti2 db  "|===================================================================================|", 10, \
            "|                          O R  O P E R A T I O N  T O O L                          |", 10, \
            "|===================================================================================|", 10, 0
    ti3 db  "|===================================================================================|", 10, \
            "|                         X O R  O P E R A T I O N  T O O L                         |", 10, \
            "|===================================================================================|", 10, 0
    ti4 db  "|===================================================================================|", 10, \
            "|          L E F T  S H I F T  O P E R A T I O N  T O O L  ( 1 6 - b i t)           |", 10, \
            "|===================================================================================|", 10, 0
    ;User Input
    prompt1 db "|     Enter the first number: ", 0
    prompt2 db "|     Enter the second number: ", 0
    prompt3 db "|     Please select an option in the box above: ", 0
    prompt4 db "|     Enter the number of bits to shift: ", 0
    choice_input db '%d', 0
    num1_input db '%d', 0
    num2_input db '%d', 0
    ;Bitwise Operations
    andRes db  "|     AND Result: %d",10, 0
    orRes db   "|     OR Result: %d",10 ,0
    xorRes db  "|     XOR Result: %d",10, 0
    lsRes db   "|     LEFT SHIFT Result: %d",10, 0

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


    push prompt3
    call _printf
    add esp, 4


    push choice
    push choice_input
    call _scanf
    add esp, 4


    mov eax, [choice]
    cmp eax, 1
    je and_operation
    cmp eax, 2
    je or_operation
    cmp eax, 3
    je xor_operation
    cmp eax, 4
    je left_shift_operation
    cmp eax, 5
    je exit
    cmp eax, 6
    jg errormain

    
errormain:
    push err1
    call _printf
    add esp, 4
    jmp main_loop


error_and:
    push err2
    call _printf
    add esp, 4
    jmp and_operation


error_or:
    push err2
    call _printf
    add esp, 4
    jmp or_operation


error_xor:
    push err2
    call _printf
    add esp, 4
    jmp xor_operation
error_ls1:
    push err2
    call _printf
    add esp, 4
    jmp left_shift_operation

error_ls2:
    push err3
    call _printf
    add esp, 4
    jmp left_shift_operation

error_ls3:
    push err4
    call _printf
    add esp, 4
    jmp left_shift_operation


and_operation:
    push ti1
    call _printf
    add esp, 4
    push prompt1
    call _printf
    add esp, 4
    
    push num1 
    push num1_input
    call _scanf
    mov eax, [num1]
    cmp eax, 1000
    jg error_and
    cmp eax, -1000
    jl error_and
    add esp, 4

    push prompt2
    call _printf
    add esp, 4

    push num2
    push num2_input
    call _scanf
    mov eax, [num2]
    cmp eax, 1000
    jg error_and
    cmp eax, -1000
    jl error_and
    add esp,4
    

    mov eax, [num1]
    and eax, [num2]
    
    push eax
    push andRes
    call _printf
    add esp,8
    jmp main_loop




or_operation:
    push ti2
    call _printf
    add esp, 4


    push prompt1
    call _printf
    add esp, 4
    
    push num1 
    push num1_input
    call _scanf
    mov eax, [num1]
    cmp eax, 1000
    jg error_or
    cmp eax, -1000
    jl error_or
    add esp, 4


    push prompt2
    call _printf
    add esp, 4


    push num2
    push num2_input
    call _scanf
    mov eax, [num2]
    cmp eax, 1000
    jg error_or
    cmp eax, -1000
    jl error_or
    add esp,4


    mov eax, [num1]
    or eax, [num2]


    push eax
    push orRes
    call _printf
    add esp,8
    jmp main_loop


xor_operation:
    push ti3
    call _printf
    add esp, 4


    push prompt1
    call _printf
    add esp, 4
    
    push num1 
    push num1_input
    call _scanf
    mov eax, [num1]
    cmp eax, 1000
    jg error_xor
    cmp eax, -1000
    jl error_xor
    add esp, 8


    push prompt2
    call _printf
    add esp, 4


    push num2
    push num2_input
    call _scanf
    mov eax, [num2]
    cmp eax, 1000
    jg error_xor
    cmp eax, -1000
    jl error_xor
    add esp,8


    mov eax, [num1]
    xor eax, [num2]


    push eax 
    push xorRes 
    call _printf
    add esp, 8
    jmp main_loop


left_shift_operation: 
    push ti4
    call _printf
    add esp, 4


    push prompt1
    call _printf
    add esp, 4
    
    push num1 
    push num1_input
    call _scanf
    mov eax, [num1]
    cmp eax, 1000
    jg error_ls1
    cmp eax, -1000
    jl error_ls1
    add esp, 8


    push prompt4
    call _printf
    add esp, 4


    push num2
    push num2_input
    call _scanf
    mov eax, [num2]
    cmp eax, 16
    jg error_ls2
    cmp eax, 0
    jl error_ls3
    add esp,8


    mov eax, [num1]
    mov cl, [num2]
    shl eax, cl

    push eax
    push lsRes
    call _printf
    add esp, 8
    jmp main_loop




exit:
    push pro8
    call _printf
    add esp, 4
    ret

