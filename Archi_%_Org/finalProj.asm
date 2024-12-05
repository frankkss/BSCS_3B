;Bitwise Operations Tool
;Functionality:
;   · AND operation on two integers
;   · OR operation on two integers
;   · XOR operation on two integers
;   · Left shift an integer

section .data
    ; Program introduction and menu
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
    ; Error messages
    err1 db "|     Invalid choice. Please enter only numbers (1-5)                               |", 10, 0
    err2 db '|     Input should only be between -1000 to 1000. Please enter again a valid input. |', 10, 0
    err3 db '|     You can not shift by more bits than 16-bits.                                  |', 10, 0
    err4 db '|     You can not shift by negative bits.                                           |', 10, 0
    err5 db "|     Please enter a valid integer.                                                 |", 10, 0
    ; Titles for each operation
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
    ; User input prompts
    prompt1 db "|     Enter the first number: ", 0
    prompt2 db "|     Enter the second number: ", 0
    prompt3 db "|     Please select an option in the box above: ", 0
    prompt4 db "|     Enter the number of bits to shift: ", 0
    choice_input db '%d', 0
    num1_input db '%d', 0
    num2_input db '%d', 0
    ; Bitwise operation results
    andRes db  "|     AND Result: %d",10, 0
    orRes db   "|     OR Result: %d",10 ,0
    xorRes db  "|     XOR Result: %d",10, 0
    lsRes db   "|     LEFT SHIFT Result: %d",10, 0

section .bss
    ; Variables to store user inputs and results
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
    extern _getchar
    
_main:
    ; Print program introduction
    push pro1
    call _printf
    add esp, 4

main_loop:
    ; Print main menu
    push pro2
    call _printf
    add esp, 4

    ; Prompt user for choice
    push prompt3
    call _printf
    add esp, 4

    ; Get user choice
    push choice
    push choice_input
    call _scanf
    add esp, 4

    call clear_input_buffer

    ; Check user choice and jump to corresponding operation
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



clear_input_buffer:
    call _getchar
    cmp al, 10    ; Check for newline (Enter key)
    jne errormain   ; Repeat until newline is found
    

errormain:
    ; Handle invalid choice
    push err1
    call _printf
    add esp, 4
    jmp main_loop

and_clear_input_buffer:
    call _getchar
    cmp al, 10    ; Check for newline (Enter key)
    jne error_and1   ; Repeat until newline is found
    ret

or_clear_input_buffer:
    call _getchar
    cmp al, 10    ; Check for newline (Enter key)
    jne error_or1   ; Repeat until newline is found
    ret

xor_clear_input_buffer:
    call _getchar
    cmp al, 10    ; Check for newline (Enter key)
    jne error_xor1   ; Repeat until newline is found
    ret

left_shift_clear_input_buffer:
    call _getchar
    cmp al, 10    ; Check for newline (Enter key)
    jne error_ls4   ; Repeat until newline is found
    ret


error_and:
    ; Handle invalid input for AND operation
    push err2
    call _printf
    add esp, 4
    jmp and_operation

error_and1:
    ; Handle invalid input for AND operation
    push err5
    call _printf
    add esp, 4
    jmp and_operation

error_or:
    ; Handle invalid input for OR operation
    push err2
    call _printf
    add esp, 4
    jmp or_operation

error_or1:
    ; Handle invalid input for OR operation
    push err5
    call _printf
    add esp, 4
    jmp or_operation

error_xor:
    ; Handle invalid input for XOR operation
    push err2
    call _printf
    add esp, 4
    jmp xor_operation

error_xor1:
    ; Handle invalid input for XOR operation
    push err5
    call _printf
    add esp, 4
    jmp xor_operation

error_ls1:
    ; Handle invalid input for left shift operation
    push err2
    call _printf
    add esp, 4
    jmp left_shift_operation

error_ls2:
    ; Handle shift by more than 16 bits
    push err3
    call _printf
    add esp, 4
    jmp left_shift_operation

error_ls3:
    ; Handle negative shift
    push err4
    call _printf
    add esp, 4
    jmp left_shift_operation

error_ls4:
    ; Handle invalid input for left shift operation
    push err5
    call _printf
    add esp, 4
    jmp left_shift_operation

and_operation:
    ; Perform AND operation
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

    call and_clear_input_buffer

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
    
    call and_clear_input_buffer

    mov eax, [num1]
    and eax, [num2]
    
    push eax
    push andRes
    call _printf
    add esp,8
    jmp main_loop

or_operation:
    ; Perform OR operation
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

    call or_clear_input_buffer

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

    call or_clear_input_buffer

    mov eax, [num1]
    or eax, [num2]

    push eax
    push orRes
    call _printf
    add esp,8
    jmp main_loop

xor_operation:
    ; Perform XOR operation
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

    call xor_clear_input_buffer

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

    call xor_clear_input_buffer

    mov eax, [num1]
    xor eax, [num2]

    push eax 
    push xorRes 
    call _printf
    add esp, 8
    jmp main_loop

left_shift_operation: 
    ; Perform left shift operation
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

    call left_shift_clear_input_buffer

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

    call left_shift_clear_input_buffer

    mov eax, [num1]
    mov cl, [num2]
    shl eax, cl

    push eax
    push lsRes
    call _printf
    add esp, 8
    jmp main_loop

exit:
    ; Exit the program
    push pro8
    call _printf
    add esp, 4
    ret

