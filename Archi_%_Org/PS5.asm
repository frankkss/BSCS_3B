section .data
    pro1 db 'Hi! This is Franco and Leo and we are here to help you determine the LCM and GCF for three positive two-digit numbers (1 to 99).', 10, 0
    pro2 db '==== LCM and GCF CALCULATOR by Franco and Leo ====', 10, 0
    pro3 db '[0] Exit ', 10, 0
    pro4 db '[1] LCM', 10, 0
    pro5 db '[2] GCF',10, 0
    pro6 db 'Thank you!', 10, 0
    ; Error Handling
    err db 'Entered Choice is not on the menu. Please enter a valid choice.', 10, 0
    err1 db 'Inputs should only be between 1 to 99. Please enter your valid inputs.', 10, 0
    ; Title
    lcm_title db "==== GCF ====", 10, 0
    gcf_title db "==== LCM ====", 10, 0
    ; User Input
    prompt1 db 'Enter choice: ',0
    prompt2 db 'Enter the 3 two-digit numbers (Separated by space): ', 10, 0
    choice_input db '%d', 0 ; Change format specifier to integer
    num1_input db '%d', 0 ; Change format specifier to integer
    num2_input db '%d', 0 ; Change format specifier to integer
    num3_input db '%d', 0 ; Change format specifier to integer
    ; Operation
    lcm db "LCM = %d", 10, 0
    gcf db "GCF = %d", 10, 0

section .bss
    num1 resb 100; Buffer to store user input
    num2 resb 100; Buffer to store user input
    num3 resb 100; Buffer to store user input
    choice resb 1
    val1 resw 1; Reserve space for an integer
    val2 resw 1
    userinput resb 100; Buffer to store user input
    result_v res
section .text
    global _main
    extern _printf
    extern _scanf

_main:
    push pro1; Display intro message
    call _printf
    add esp, 4; Prompt for the first number

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

    push prompt1 ; Display choice prompt
    call _printf
    add esp, 4

    push choice ; Read user choice
    push choice_input
    call _scanf
    add esp, 4 ; not sure if this is correct

    mov eax, [choice]; Check user choice
    cmp eax, 0 ; Exit
    je exit ; Jump to exit
    cmp eax, 1 ; LCM
    je lcm ; Jump to LCM
    cmp eax, 2 ; GCF
    je gcf ; Jump to GCF
    cmp eax, 3 ; Error Handling
    jg errormain ; Jump to error handling (not sure if this is correct)

errormain:
    push err ; Display error message
    call _printf
    add esp, 4
    jmp main_loop ; Jump back to main loop

error_lcm:
    push err1 ; Display error message
    call _printf
    add esp, 4
    jmp least_common_multiple ; Jump back to LCM

error_gcf:
    push err1
    call _printf
    add esp, 4
    jmp greatest_common_factor

greatest_common_factor:
    push gcf_title
    call _printf
    add esp, 4
    push prompt2
    call _printf
    add esp, 4




least_common_multiple:
    push lcm_title
    call _printf
    add esp, 4
    push prompt2
    call _printf
    add esp, 4



    

exit:
    push pro6
    call _printf
    add esp, 4
    ret