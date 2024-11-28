section .data
    display0 db "|=======================================================================|", 10, 0
    display1 db "|           T A S K  M A N A G E M E N T  S Y S T E M                   |", 10, 0
    display2 db "|=======================================================================|", 10, 0
    display3 db "|           [1] Add a new task                                          |", 10, 0
    display4 db "|           [2] Display all tasks                                       |", 10, 0
    display5 db "|           [3] Mark task as completed                                  |", 10, 0
    display6 db "|           [4] Delete a task                                           |", 10, 0
    display7 db "|           [5] Exit                                                    |", 10, 0
    display8 db "|=======================================================================|", 10, 0
    ;User Input
    prompt1  db "|           Please select an option in the box above: ", 0
    display9 db "|=======================================================================|", 10, 0

    num_format db "%d", 0
    ;Error Handling
    errorMessage db "|===========Invalid choice. Please try again.===========================|", 10, 0

    ;Title
    title1 db "================= ADD A NEW TASK ==================", 10, 0
    title2 db "================ DISPLAY ALL TASKS ================", 10, 0
    title3 db "================ MARK TASK AS COMPLETED ===========", 10, 0
    title4 db "================ DELETE A TASK ====================", 10, 0

section .bss
    choice resd 1
    str: resb 50

section .text
    extern _printf, _scanf, _exit
    global _main

_main:
    ; Print introduction message
    push display0
    call _printf
    add esp, 4
    push display1
    call _printf
    add esp, 4
    push display2
    call _printf
    add esp, 4
    push display3
    call _printf
    add esp, 4
    push display4
    call _printf
    add esp, 4
    push display5
    call _printf
    add esp, 4
    push display6
    call _printf
    add esp, 4
    push display7
    call _printf
    add esp, 4
    push display8
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
    je add_task
    cmp eax, 2
    je display_task
    cmp eax, 3
    je mark_task
    cmp eax, 4
    je delete_task
    cmp eax, 5
    je exit_program
    jmp invalid_choice


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
    call _printf
    add esp, 4
    push 0
    call _exit

add_task:
    push title1
    call _printf
    add esp, 4
    ; Add task code here
    ;jmp _main

display_task:
    push title2
    call _printf
    add esp, 4
    ; Display task code here
    ;jmp _main

mark_task:
    push title3
    call _printf
    add esp, 4
    ; Mark task code here
    ;jmp _main

delete_task:
    push title4
    call _printf
    add esp, 4
    ; Delete task code here
    ;jmp _main