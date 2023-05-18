; This is a comment
; myhello.s

global main
extern puts

section .text

main:
    mov rdi, message
    call puts
    ret

message:
    db 'Hello, Word!', 10, 0
