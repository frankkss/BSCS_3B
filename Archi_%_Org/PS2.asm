section .data
    ;Prompting user 
    prompt_name db 'Hi! Whats is your name?: ', 0
    prompt_age db 'How old are you?: ', 0
    prompt_address db 'Where do you live?: ', 0
    input_format_name db '%s', 0
    input_format_age db '%s', 0
    input_format_address db '%s', 0
    message db 'Nice to meet you, %s, %s, who lives at %s', 10, 0  ; Define the message string

section .bss
    userName resb 100    ; Buffer to store user input
    userAge resd 1
    userAddress resb 100

section .text
    global _main
    extern _printf
    extern _scanf
    
_main:
    ; Display a name prompt
    push prompt_name
    call _printf
    add esp, 4

    ; Read user name
    push userName
    push input_format_name
    call _scanf
    add esp, 8
    
    ; Display age prompt
    push prompt_age
    call _printf
    add esp, 4

    ; Read user age
    push userAge
    push input_format_age
    call _scanf
    add esp, 8

    ; Display address prompt
    push prompt_address
    call _printf
    add esp, 4

    ; Read user address
    push userAddress
    push input_format_address
    call _scanf
    add esp, 8

    ; Display the entered text
    push userAddress
    push userAge
    push userName
    push message
    call _printf
    add esp, 16

    ret
