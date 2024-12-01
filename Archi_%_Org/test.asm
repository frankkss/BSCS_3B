section .data
    msg1: db 0Ah,"Enter a number"
    size1: equ $-msg1
    msg2: db 0Ah,"the sum= "
    size2: equ $-msg2
    newline: db 0Ah

section .bss
    num: resw 1
    sum: resw 1
    digit1: resb 1
    digit0: resb 1
    digit2: resb 1
    temp: resb 1
    counter:resb 1
    count: resb 1

section .text
    global _start
    _start:

    mov byte[counter],0
    mov byte[sum],0

    read_and_add:
    call read_num ;; Instead of the code for reading a number,
 ;; we just call the subprogram

    call add

    ;loop condition checking
    inc byte[counter]
    cmp byte[counter],10
    jl read_and_add

    mov ax, word[sum]
    mov word[num], ax
    call print_num ;; Instead of the code for printing a number,
    ;; we just call the subprogram

    ;exit
    mov eax,1
    mov ebx,0
    int 80h

    ;sub-program add to add a number to the existing sum
    add:
    mov ax,word[num]
    add word[sum],ax
    ret
    
     ;;subprogram to print a number

    print_num:
    mov byte[count],0
    pusha
    extract_no:
    cmp word[num], 0
    je print_no
    inc byte[count]
    mov dx, 0
    mov ax, word[num]
    mov bx, 10
    div bx
    push dx
    mov word[num], ax
    jmp extract_no
    print_no:
    cmp byte[count], 0
    je end_print
    dec byte[count]
    pop dx
    mov byte[temp], dl
    add byte[temp], 30h
    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
    jmp print_no

    end_print:
    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,1
    int 80h

     ;;The memory location ’newline’ should be declared with the ASCII key for
    ;;new line in section.data.

    popa
    ret

    ;; subprogram for inputting a number
    read_num:
    ;;push all the used registers into the stackusing pusha
    pusha
    ;;store an initial value 0 to variable ’num’
    mov word[num], 0
    loop_read:
    ;; read a digit
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
    ;;check if the read digit is the end of number,i.e, the enter-key whose ASCII key is 10
    cmp byte[temp], 10
    je end_read
    mov ax, word[num]
    mov bx, 10
    mul bx
    mov bl, byte[temp]
    sub bl, 30h
    mov bh, 0
    add ax, bx
    mov word[num], ax
    jmp loop_read
    end_read:
    ;;pop all the used registers from the stackusing popa
    popa
    ret
