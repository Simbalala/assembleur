global fibonnaci

segment .text

fibonnaci:
    mov rcx, rdi
    xor rax, rax
    mov r8, 0
    mov r9, 1

    add rax, r9
    cmp rcx, -1
    jl else

then:
    cmp rcx, 0
    jne loop_fibo
    mov rax, 0
    ret

else:
    mov rax, -1
    ret

loop_fibo:
    mov r8, r9
    mov r9, rax
    mov rax, r8
    add rax, rcx
    dec rcx

    cmp rcx, 0
    jge loop_fibo

return:
    ret

