;Bitwise Operations Tool
;Fuctionality:
;   · AND operation on two integers
;   · OR operation on two integers
;   · XOR operation on two integers
;   · Left shift an integer

section .data
    display0 db "|=======================================================================|", 10, \
                "|           B I T W I S E  O P E R A T I O N  T O O L S                 |", 10, \
                "|=======================================================================|", 10, \
                "|           [1] AND Operation Tool                                      |", 10, \
                "|           [2] OR Operation Tool                                       |", 10, \
                "|           [3] XOR Operation Tool                                      |", 10, \
                "|           [4] LEFT SHIFT Operation Tool                               |", 10, \
                "|           [5] Exit                                                    |", 10, \
                "|=======================================================================|", 10, 0
    ;User Input
    prompt1  db "|           Please select an option in the box above: ", 0
    display9 db "|=======================================================================|", 10, 0

    num_format db "%d", 0
    ;Error Handling
    errorMessage db "|===========Invalid choice. Please try again.===========================|", 10, 0

    ;Title
    title1 db   "|=======================================================================|", 10, \
                "|           A N D  O P E R A T I O N  T O O L                           |", 10, \
                "|=======================================================================|", 10, 0
    title2 db   "|=======================================================================|", 10, \
                "|           O R  O P E R A T I O N  T O O L                             |", 10, \
                "|=======================================================================|", 10, 0
    title3 db   "|=======================================================================|", 10, \
                "|           X O R  O P E R A T I O N  T O O L                           |", 10, \
                "|=======================================================================|", 10, 0
    title4 db   "|=======================================================================|", 10, \
                "|           L E F T  S H I F T  O P E R A T I O N  T O O L              |", 10, \
                "|=======================================================================|", 10, 0

    ;prompts
    prompt2 db "|           Enter the first number: ", 0
    prompt3 db "|           Enter the second number: ", 0
    prompt4 db "|           Enter the number of bits to shift: ", 0
    invalid_input_msg DB "Invalid input. Please enter a valid choice ('Y' or 'N' only)", 10, 0
    continue_prompt db "|           Do you want to continue? (y/n): ", 0

    ;Result
    result db "|           Result: ", 0

    ;thank You message
    thankYou db "|=======================================================================|", 10, \
                "|========== Thank you for using the tool! ==============================|", 10, \
                "|=======================================================================|", 10, 0
    


section .bss
    choice resd 1
    str: resb 50
    results resb 1
    continue resb 2

section .text
    extern _printf, _scanf, _exit
    global _main

_main:
    ; Print introduction message
    push display0
    call _printf
    add esp, 4

loop_start:

    ; Prompt for choice
    push prompt1
    call _printf
    add esp, 4

    ; Read choice
    push choice
    push num_format
    call _scanf
    add esp, 8

    ; Check choice and jump to corresponding section
    mov eax, [choice]
    cmp eax, 1
    je and_operation
    cmp eax, 2
    je or_operation
    cmp eax, 3
    je xor_operation
    cmp eax, 4
    je left_shift
    cmp eax, 5
    je exit_program
    jmp invalid_choice


and_operation:
    ; Print AND operation title
    push display9
    push title1
    call _printf
    add esp, 8

    ; Prompt for first number
    push display9
    push prompt2
    call _printf
    add esp, 8

    ; Read first number
    push str
    push num_format
    call _scanf
    add esp, 8

    ; Prompt for second number
    push display9
    push prompt3
    call _printf
    add esp, 8

    ; Read second number
    push str
    push num_format
    call _scanf
    add esp, 8

    ; Perform AND operation on the two numbers
    mov eax, [str]
    mov ebx, [str+4]
    and eax, ebx
    mov [result], eax
    


    ; Print result
    push display9
    push result 
    push eax
    call _printf
    add esp, 12
    
    ; ask user if they want to continue


or_operation:
    ; Print OR operation title
    push display9
    push title2
    call _printf
    add esp, 8

    ; Prompt for first number
    push display9
    push prompt2
    call _printf
    add esp, 8

    ; Read first number
    push str
    push num_format
    call _scanf
    add esp, 8

    ; Prompt for second number
    push display9
    push prompt3
    call _printf
    add esp, 8

    ; Read second number
    push str
    push num_format
    call _scanf
    add esp, 8

    ; Perform OR operation
    mov    al, 5             ;getting 5 in the al
    mov    bl, 3             ;getting 3 in the bl
    or     al, bl            ;or al and bl registers, result should be 7
    add    al, byte '0'      ;converting decimal to ascii

    mov    [results],  al ; store the result
    mov    eax, 4 ; system call for sys_write
    mov    ebx, 1 ; file descriptor (stdout)
    mov    ecx, results ; address of the string
    mov    edx, 1  ; length of the string
    int    0x80 ; call kernel


    ;print result
    push display9
    push results
    call _printf
    add esp, 4
    jmp _main


xor_operation:
    ; Print XOR operation title
    push display9
    push title3
    call _printf
    add esp, 8

    ; Prompt for first number
    push display9
    push prompt2
    call _printf
    add esp, 8

    ; Read first number
    push str
    push num_format
    call _scanf
    add esp, 8

    ; Prompt for second number
    push display9
    push prompt3
    call _printf
    add esp, 8

    ; Read second number
    push str
    push num_format
    call _scanf
    add esp, 8

    ; Perform XOR operation
    mov eax, [str]
    mov ebx, [str+4]
    xor eax, ebx

left_shift:
    ; Print LEFT SHIFT operation title
    push display9
    push title4
    call _printf
    add esp, 8

    ; Prompt for number
    push display9
    push prompt2
    call _printf
    add esp, 8

    ; Read number
    push str
    push num_format
    call _scanf
    add esp, 8

    ; Prompt for number of bits to shift
    push display9
    push prompt4
    call _printf
    add esp, 8

    ; Read number of bits to shift
    push str
    push num_format
    call _scanf
    add esp, 8

    ; Perform left shift operation
    mov eax, [str]
    mov cl, [str+4]
    shl eax, cl

    ; Print result
    push display9
    push result
    push eax
    call _printf
    add esp, 12
    jmp _main





continue_loop:
    CMP byte [continue], 'y'
    JE loop_start
    CMP byte [continue], 'Y'
    JE  loop_start
    CMP byte [continue], 'n'
    JE exit_program
    CMP byte [continue], 'N'
    JE exit_program

    call error_str
    JMP continue_loop


error_str:                   ; Display an error message if invalid input is entered by the user
    push invalid_input_msg
    call _printf
    add ESP, 4
    ret

invalid_choice:
    ; Print error message for invalid input
    push display9
    push errorMessage
    call _printf
    add esp, 8
    jmp loop_start

exit_program:
    ; Exit the program
    push display9
    push thankYou
    call _printf
    add esp, 8
    push 0
    call _exit


