global myitoa

section .text

nneg:
    mov r8, -1
    inc rdi
    jmp loop_itoa

skip_space:
    inc rdi
    jmp loop_itoa

error:
    mov rax, -1
    ret


myitoa:
    mov rax, 0
    mov r8, 0

loop_itoa:
    movzx rsi, byte [rdi]
    test rsi, rsi
    je else        

    cmp rsi, 32
    je skip_space

    cmp rsi, 45
    je nneg

    cmp rsi, 48
    jl error

    cmp rsi, 57
    jg error
     
    sub rsi, 48
    imul rax, 10
    add rax, rsi
    
    inc rdi                 
    jmp loop_itoa

else:
    cmp r8, -1
    jne return
    imul rax, -1

return:
    ret