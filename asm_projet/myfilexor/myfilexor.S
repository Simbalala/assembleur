extern malloc

%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3

%define BUFFER_SIZE 4096

section .data
    fd dw 0

section .bss
    file_buffer resb BUFFER_SIZE

section .text
    global  myfilexor

myfilexor:
    mov r14, rsi
    mov r13, rdi

    mov rdi, BUFFER_SIZE
    call malloc

    mov r15, rax
    mov rdi, BUFFER_SIZE

    mov rdi, r13
    mov rax, SYS_OPEN
    mov rsi, 0
    syscall
    mov [fd], rax
    

_read_write:
    mov rax, 0
    mov rdi, [fd]
    mov rsi, file_buffer
    mov rdx, BUFFER_SIZE
    syscall

    cmp rax, 0
    je _exit

    mov r10, file_buffer
    jmp loop_filexor

loop_filexor:
    movzx r12, byte [r10]
    test r12, r12
    je cmp_buffer_init

    xor [r10], r14
    inc r10

    jmp loop_filexor

cmp_buffer_init:
    mov r14, 0
    mov r10, file_buffer

cmp_buffer:
    movzx r12, byte [r10]
    test r12, r12
    je _exit

    mov [r15 + 1 * r14], r12
    inc r10
    inc r14
    jmp cmp_buffer


_exit:

    mov rax, SYS_CLOSE
    mov rdi, fd
    syscall

    mov rax, r15
    mov rdi, 0
    ret

  
