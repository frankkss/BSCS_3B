;To-Do List Manager
;Add a new task to the list
;Display all tasks
;Mark a task as completed
;Delete a task

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
    prompt1  db "|           Please select an option in the box above: ", 10, 0
    display9 db "|=======================================================================|", 10, 0

    ;Error Handling
    error db "Invalid choice. Please try again.", 10, 0

    ;Title
    title1 db "================= ADD A NEW TASK ==================", 10, 0
    title2 db "================ DISPLAY ALL TASKS ================", 10, 0
    title3 db "================ MARK TASK AS COMPLETED ===========", 10, 0
    title4 db "================ DELETE A TASK ====================", 10, 0




section .bss
    choice resb 1

section .text
    global _main
    extern _printf
    extern _scanf

;test for display
_main:
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
    push prompt1
    call _printf
    add esp, 4
    push display9
    call _printf
    add esp, 4




