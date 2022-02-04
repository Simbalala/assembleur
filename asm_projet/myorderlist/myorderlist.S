section .bss
    buffer resb 64
    digitSpace resb 100
    digitSpacePos resb 8

section .text
    global orderlist


swap:
    mov r8, [rdi + 8 * rdx]
    mov r9, [rdi + 8 * (rdx + 1)]
    mov [rdi + 8 * rdx], r9
    mov [rdi + 8 * (rdx + 1)], r8
    inc rdx
    jmp loop_2

swap_2:
    mov rdi, buffer
    mov r8, [rdi + r14]
    mov r9, [rdi + r11]
    mov [rdi + r14], r9
    mov [rdi + r11], r8
    inc r14
    dec r11
    jmp print_buffer

orderlist:
    xor rax, rax
    mov rcx, 0
    mov rdx, 0

orderlist_loop:
    cmp rcx, rsi
    jg write_list
    inc rcx
    mov rdx, 0
    jmp loop_2

loop_2:
    mov r10, rsi
    sub r10, rcx
    sub r10,1
    cmp rdx, r10
    jg orderlist_loop
    
    mov r8, [rdi + 8 * rdx]
    mov r9, [rdi + 8 * (rdx + 1)]
    cmp r8, r9
    jg swap
    inc rdx
    jmp loop_2


write_list:
    mov rax, 45
    mov r11, 0
    mov rdi, buffer

itoa:
    cmp rax, 0
    je reverse_init
    mov rdx, 0
    mov rcx, 10
    div rcx
    
    push rax
    mov rax, rdx
    add rax, '0'
    mov [rdi], rax
    inc rdi
    pop rax
    inc r11
    jmp itoa
   
reverse_init:
    mov r14, 0
    sub r11, 1
 

reverse:
    cmp r14, r11
    jmp swap_2
    ; jmp print_buffer

; format_buffer:


print_buffer:
    mov     rdi, buffer        ; string1 to destination index
    xor     rcx, rcx            ; zero rcx
    not     rcx                 ; set rcx = -1
    xor     al,al               ; zero the al register (initialize to NUL)
    cld                         ; clear the direction flag
    repnz   scasb               ; get the string length (dec rcx through NUL)
    not     rcx                 ; rev all bits of negative results in absolute value
    dec     rcx                 ; -1 to skip the null-terminator, rcx contains length
    mov     rdx, rcx            ; put length in rdx

    ; write string to stdout
    mov     rsi, buffer        ; string1 to source index
    mov     rax, 1              ; set write to command
    mov     rdi,rax             ; set destination index to rax (stdout)
    syscall                     ; call kernel

    ; exit 
    xor     rdi,rdi             ; zero rdi (rdi hold return value)
    mov     rax, 60           ; set syscall number to 60 (0x3c hex)

exit:
    syscall
    ret
    