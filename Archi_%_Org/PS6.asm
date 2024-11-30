section .data
    intro     db 'Hi! We are Angela, Robert, Franco and Aron. This program is intended to sort ', 13, 10
                db 'numbers and words or change all the vowels to a number.', 13, 10, 13, 0
    menu        db '==== Assembly Program by Angela, Robert, Franco and Aron ====', 13, 10
                db '[0] Exit', 13, 10
                db '[1] Number', 13, 10
                db '[2] Word', 13, 10, 0
    
    array_len  equ 5
    word_len   equ 20
    
    format_int     db '%d', 0 
    format_str     db '%s', 0
    format_char    db '%c', 0
    newline     db 13, 10, 0
    
    msg_choice   db 'Enter choice: ', 0
    msg_items    db 'Enter up to 5 items:', 13, 10, 0
    msg_sort     db 'Sort by [1] Ascending or [2] Descending: ', 0
    msg_vowels   db 'Do you want to change the vowels? (Y/N): ', 0

    sorted_header   db 'Sorted items:', 13, 10, 0
    changed_header  db 'Changed vowels:', 13, 10, 0
    goodbye         db 'Thank you!', 13, 10, 0
    
    num_error_msg   db 'Error: Invalid input. Please enter only numbers.', 13, 10, 0
    word_error_msg  db 'Error: Invalid input. Please enter only words.', 13, 10, 0
    
    vowels          db 'aeiouAEIOU', 0
    vowel_nums      db '12345', 0

section .bss
    choice      resd 1
    sort_order  resd 1
    vowel_choice resb 2
    numbers     resd array_len
    words       resb word_len * array_len
    temp_word   resb word_len
    temp        resd 1

section .text
    global _main
    extern _printf, _scanf, _gets, _strcmp, _strlen, _exit, _getch, _getchar

_main:
    push intro
    call _printf
    add esp, 4

main_loop:
    push menu
    call _printf
    add esp, 4

    push msg_choice
    call _printf
    add esp, 4

    push choice
    push format_int
    call _scanf
    add esp, 8
    
    cmp eax, 1
    jne invalid_choice
    
    mov eax, [choice]
    cmp eax, 0
    je exit_program
    cmp eax, 1
    je number_mode
    cmp eax, 2
    je word_mode

invalid_choice:
    call _getch
    jmp main_loop

number_mode:    
    call get_numbers
    test eax, eax
    jz main_loop
    
    call get_sort_order
    test eax, eax
    jz main_loop
    
    call sort_numbers
    call display_numbers
    jmp main_loop

get_numbers:
    xor ebx, ebx

.start:
    push msg_items
    call _printf
    add esp, 4

.input_loop:
    cmp ebx, array_len
    jge .validate

    lea eax, [numbers + ebx*4]
    push eax
    push format_int
    call _scanf
    add esp, 8

    cmp eax, 1
    jne .invalid_input

    inc ebx
    jmp .input_loop

.validate:
    xor ebx, ebx

.validate_loop:
    cmp ebx, array_len
    jge .done

    lea eax, [numbers + ebx*4]
    mov eax, [eax]
    test eax, eax
    js .invalid_input

    inc ebx
    jmp .validate_loop

.invalid_input:
    push num_error_msg
    call _printf
    add esp, 4

.clear_buffer:
    call _getchar
    cmp al, 10
    jne .clear_buffer

    xor ebx, ebx
    jmp .start

.done:
    mov eax, 1
    ret

word_mode:
    call get_words
    test eax, eax
    jz main_loop
    
    call get_sort_order
    test eax, eax
    jz main_loop
    
    call sort_words
    call display_words
    
    push msg_vowels
    call _printf
    add esp, 4
    
    push vowel_choice
    push format_str
    call _scanf
    add esp, 8
    
    cmp eax, 1
    jne main_loop
    
    mov al, [vowel_choice]
    or al, 32
    cmp al, 'y'
    je do_vowel_conversion
    
    jmp main_loop

get_words:
    xor ebx, ebx
    
.start:
    push msg_items
    call _printf
    add esp, 4
    
.input_loop:
    cmp ebx, array_len
    jge .validate
    
    mov eax, ebx
    imul eax, word_len
    lea edi, [words + eax]
    
    push edi
    push format_str
    call _scanf
    add esp, 8
    
    cmp eax, 1
    jne .invalid_input
    
    inc ebx
    jmp .input_loop
    
.validate:
    xor ebx, ebx
    
.validate_loop:
    cmp ebx, array_len
    jge .done
    
    mov eax, ebx
    imul eax, word_len
    lea edi, [words + eax]
    
    push edi
    call validate_word
    add esp, 4
    
    test eax, eax
    jz .invalid_input
    
    inc ebx
    jmp .validate_loop
    
.invalid_input:
    push word_error_msg
    call _printf
    add esp, 4
    
.clear_buffer:
    call _getchar
    cmp al, 10
    jne .clear_buffer
    
    xor ebx, ebx
    jmp .start
    
.done:
    mov eax, 1
    ret

get_sort_order:
    push msg_sort
    call _printf
    add esp, 4
    
    push sort_order
    push format_int
    call _scanf
    add esp, 8
    
    mov eax, 1
    ret

sort_numbers:
    mov ecx, array_len - 1
    
outer_loop:
    push ecx
    xor ebx, ebx
    
inner_loop:
    mov eax, ebx
    shl eax, 2
    lea esi, [numbers + eax]
    lea edi, [esi + 4]
    
    mov eax, [esi]
    mov edx, [edi]
    
    push ebx
    mov ebx, [sort_order]
    cmp ebx, 1
    pop ebx
    je compare_ascending
    
compare_descending:
    cmp eax, edx
    jl swap_elements
    jmp continue_inner
    
compare_ascending:
    cmp eax, edx
    jg swap_elements
    jmp continue_inner
    
swap_elements:
    mov [temp], eax
    mov eax, [edi]
    mov [esi], eax
    mov eax, [temp]
    mov [edi], eax
    
continue_inner:
    inc ebx
    mov eax, array_len
    sub eax, 1
    cmp ebx, eax
    jl inner_loop
    
    pop ecx
    loop outer_loop
    ret

sort_words:
    mov ecx, array_len - 1
    
.outer_loop:
    push ecx
    xor ebx, ebx
    
.inner_loop:
    mov eax, ebx
    imul eax, word_len
    lea esi, [words + eax]
    add eax, word_len
    lea edi, [words + eax]
    
    push edi
    push esi
    call _strcmp
    add esp, 8
    
    mov edx, [sort_order]
    cmp edx, 1
    je .check_ascending
    
.check_descending:
    cmp eax, 0
    jge .continue_inner
    jmp .swap_words
    
.check_ascending:
    cmp eax, 0
    jle .continue_inner
    
.swap_words:
    push ecx
    push esi
    push edi
    
    mov ecx, word_len
    mov esi, [esp+4]
    mov edi, temp_word
    rep movsb
    
    mov ecx, word_len
    mov esi, [esp]
    mov edi, [esp+4]
    rep movsb
    
    mov ecx, word_len
    mov esi, temp_word
    mov edi, [esp]
    rep movsb
    
    pop edi
    pop esi
    pop ecx
    
.continue_inner:
    inc ebx
    mov eax, array_len
    sub eax, 1
    cmp ebx, eax
    jl .inner_loop
    
    pop ecx
    loop .outer_loop
    ret

do_vowel_conversion:
    push changed_header
    call _printf
    add esp, 4
    
    mov esi, words
    mov ecx, array_len
    
.word_loop:
    push ecx
    
    push esi
    call convert_vowels
    add esp, 4
    
    push esi
    push format_str
    call _printf
    add esp, 8
    
    push newline
    call _printf
    add esp, 4
    
    add esi, word_len
    pop ecx
    loop .word_loop
    
    jmp main_loop

convert_vowels:
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx
    
    mov esi, [ebp+8]
    
.scan_loop:
    lodsb
    test al, al
    jz .done
    
    push esi
    mov edi, vowels
    mov ecx, 10
    mov bl, al
    repne scasb
    
    jne .next_char
    
    mov eax, 10
    sub eax, ecx
    
    cmp eax, 5
    jge .uppercase_vowel
    
    mov al, [vowel_nums + eax - 1]  ; Fix the index calculation
    dec esi
    mov [esi], al
    jmp .next_char
    
.uppercase_vowel:
    sub eax, 5
    mov al, [vowel_nums + eax ]  ; Fix the index calculation
    dec esi
    mov [esi], al
    
.next_char:
    pop esi
    jmp .scan_loop
    
.done:
    pop ebx
    pop esi
    pop edi
    pop ebp
    ret

display_numbers:
    push sorted_header
    call _printf
    add esp, 4
    
    xor ebx, ebx
    
display_loop:
    cmp ebx, array_len
    jge display_done
    
    mov eax, ebx
    shl eax, 2
    
    push dword [numbers + eax]
    push format_int
    call _printf
    add esp, 8
    
    push newline
    call _printf
    add esp, 4
    
    inc ebx
    jmp display_loop
    
display_done:
    ret

display_words:
    push sorted_header
    call _printf
    add esp, 4
    
    xor ebx, ebx
    
.display_loop:
    cmp ebx, array_len
    jge .done
    
    mov eax, ebx
    imul eax, word_len
    lea esi, [words + eax]
    
    push esi
    push format_str
    call _printf
    add esp, 8
    
    push newline
    call _printf
    add esp, 4
    
    inc ebx
    jmp .display_loop
    
.done:
    ret

exit_program:
    push goodbye
    call _printf
    add esp, 4
    
    call _getch
    
    push 0
    call _exit

validate_word:
    push ebp
    mov ebp, esp
    mov esi, [ebp+8]
    
validate_loop:
    lodsb
    test al, al
    jz validate_success
    
    cmp al, 'A'
    jl validate_fail
    cmp al, 'Z'
    jle validate_next
    cmp al, 'a'
    jl validate_fail
    cmp al, 'z'
    jg validate_fail
    
validate_next:
    jmp validate_loop
    
validate_success:
    mov eax, 1
    jmp validate_done
    
validate_fail:
    xor eax, eax
    
validate_done:
    pop ebp
    ret
