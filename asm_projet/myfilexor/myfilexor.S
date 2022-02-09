extern _ft_strlen
extern _ft_strcpy
extern malloc

%define SYS_EXIT 60
%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define STDOUT 1

%define BUFFER_SIZE 4096


section .data
    fd dw 0

section .bss
    file_buffer resb BUFFER_SIZE

section .text
    global  myfilexor

myfilexor:
    mov r9, rsi
    mov r13, rdi
    mov rdi, BUFFER_SIZE

  ; Ouvre le fichier
    mov rdi, r13
    mov rax, SYS_OPEN
    mov rsi, 0
    syscall
    mov [fd], rax
    

_read_write:
  ; Lit le fichier dans un buffer
    mov rax, SYS_READ
    mov rdi, [fd]
    mov rsi, file_buffer
    mov rdx, BUFFER_SIZE
    syscall

  ; Si on a atteint la fin du fichier, on quitte
    cmp rax, 0
    je _exit

    mov r10, file_buffer
    jmp loop_filexor

loop_filexor:
    movzx r12, byte [r10]
    test r12, r12
    je _exit

    xor [r10], r9
    inc r10
    jmp loop_filexor


_exit:
  ; Ferme le fichier
  mov rax, SYS_CLOSE
  mov rdi, fd
  syscall

  ; Quitte
  mov rax, file_buffer
  mov rdi, 0
  ret

  
