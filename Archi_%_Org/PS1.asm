global  _main ; Declare the _main symbol as global
extern  _printf ; Declare the _printf function
section .text ; Specify the code in the .text section
_main: push message ; Push the address of the message
       call _printf ; _printf functions called to print msg.
       add esp, 4 ; adjust stack pointer by 4 bytes
message: db 'Hello, World', 10, 0 ; The string message is defined
