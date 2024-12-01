section .data
    intro_msg db "Hi! This is Franco and Leo and we are here to help you determine the LCM and GCF for three positive two-digit numbers (1 to 99).", 10, 0
    menu db "==== LCM and GCF CALCULATOR by Franco and Leo ====",  10,  "[0] Exit", 10, "[1] LCM", 10, "[2] GCF", 10, 0
    choice_msg db "Enter choice: ", 0
    lcm_msg db "==== LCM ====", 10, 0
    gcf_msg db "==== GCF ====", 10, 0
    num_prompt db "Enter the 3 two-digit numbers (separated by space): ", 0
    result_lcm_msg db "LCM: %d", 10, 0
    result_gcf_msg db "GCF: %d", 10, 0
    error_msg db "Inputs should only be between 1 to 99. Please enter your valid inputs.", 10, 0
    invalid_choice_msg db "Entered Choice is not on the menu. Please enter a valid choice.", 10, 0
    thank_you_msg db "Thank you!", 10, 0
    num_format db "%d", 0

section .bss
    choice resd 1
    nums resd 3

section .text
    extern _printf, _scanf, _exit
    global _main

_main:
    ; Print introduction message
    push intro_msg
    call _printf
    add esp, 4

loop_start:
    ; Print menu
    push menu
    call _printf
    add esp, 4

    ; Prompt for choice
    push choice_msg
    call _printf
    add esp, 4

    ; Read choice
    push choice
    push num_format
    call _scanf
    add esp, 8

    ; Check choice and jump to corresponding section
    mov eax, [choice]
    cmp eax, 0
    je exit_program
    cmp eax, 1
    je lcm_section
    cmp eax, 2
    je gcf_section
    jmp invalid_choice

gcf_section:
    ; Print GCF message
    push gcf_msg
    call _printf
    add esp, 4
    ; Get numbers and calculate GCF
    call get_numbers
    call calculate_gcf
    jmp loop_start

lcm_section:
    ; Print LCM message
    push lcm_msg
    call _printf
    add esp, 4
    ; Get numbers and calculate LCM
    call get_numbers
    call calculate_lcm
    jmp loop_start

invalid_choice:
    ; Print invalid choice message
    push invalid_choice_msg
    call _printf
    add esp, 4
    jmp loop_start

get_numbers:
    ; Prompt for numbers
    push num_prompt
    call _printf
    add esp, 4

    ; Read three numbers
    lea ebx, [nums]
    push ebx
    push num_format
    call _scanf
    add esp, 8

    lea ebx, [nums+4]
    push ebx
    push num_format
    call _scanf
    add esp, 8

    lea ebx, [nums+8]
    push ebx
    push num_format
    call _scanf
    add esp, 8

    ; Validate numbers
    call validate_numbers
    ret

validate_numbers:
    ; Validate first number
    lea ebx, [nums]
    mov eax, [ebx]
    cmp eax, 1
    jl invalid_input
    cmp eax, 99
    jg invalid_input

    ; Validate second number
    lea ebx, [nums+4]
    mov eax, [ebx]
    cmp eax, 1
    jl invalid_input
    cmp eax, 99
    jg invalid_input

    ; Validate third number
    lea ebx, [nums+8]
    mov eax, [ebx]
    cmp eax, 1
    jl invalid_input
    cmp eax, 99
    jg invalid_input

    ret


calculate_lcm:
    ; LCM Calculation of three numbers (Pass-by-Value)
    ; LCM(a, b, c) = LCM(a, b) * c / GCF(LCM(a, b), c)
    mov eax, [nums]
    mov ebx, [nums+4]
    call compute_lcm

    mov ebx, [nums+8]
    call compute_lcm

    ; Print LCM result
    push eax
    push result_lcm_msg
    call _printf
    add esp, 8
    ret

compute_lcm:
    ; Compute LCM of two numbers
    ; LCM(a, b) = (a * b) / GCF(a, b)
    push eax
    push ebx
    mov ecx, eax
    mov edx, ebx
    call compute_gcf
    mov edi, eax
    pop ebx
    pop eax

    mul ebx
    div edi

    ret

calculate_gcf:
    ; GCF Calculation (Pass-by-Reference)
    ; GCF(a, b, c) = GCF(GCF(a, b), c)
    mov eax, [nums]
    mov ebx, [nums+4]
    call compute_gcf

    mov ebx, [nums+8]
    call compute_gcf

    ; Print GCF result
    push eax
    push result_gcf_msg
    call _printf
    add esp, 8
    ret

compute_gcf:
    ; Compute GCF of two numbers
    cmp ebx, 0
    je gcf_done

    mov edx, 0
    div ebx
    mov eax, ebx
    mov ebx, edx
    jmp compute_gcf

invalid_input:
    ; Print error message for invalid input
    push error_msg
    call _printf
    add esp, 4
    jmp get_numbers

exit_program:
    ; Print thank you message and exit
    push thank_you_msg
    call _printf
    add esp, 4
    push 0
    call _exit

gcf_done:
    ret