section .bss
    buf resb 64
    rev_buf resb 64
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



; write list

write_list:
    mov r15, rsi
    dec r15
    push rdi
    push rdx
    

loop_array:
    pop rdx
    pop rdi
    cmp rdx, r15
    jge load_eof
    mov rax, [rdi + 8 * rdx]
    mov r11, 0
    mov rdi, buf
    inc rdx
    push rdi
    push rdx


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
    dec r11
    mov rdi, buf
    mov rsi, rev_buf

    mov rax, rdi            ; move end of buf for reverse 
    add rax, r11
    mov rdi, rax

reverse:
    movzx r8, byte [rdi]           ; swap value to reverse_buf
    mov [rsi], r8
    dec rdi
    inc rsi
    dec r11
    cmp r11, -1
    jg reverse
    call print_buffer
    pop rdx
    pop rdi
    cmp rdx, r15
    push rdi
    push rdx
    jge loader

loader:
    call load_comma
    pop rdx
    pop rdi
    mov rax, [rdi + 8 * rdx]
    ret
    jmp loop_array

load_comma:
    mov rdi, rev_buf
    mov dword [rdi], ','
    inc rdi
    mov dword [rdi], ' '
    call print_buffer
    ret


load_eof:
    mov rax, buf
    ret
    mov rdi, rev_buf
    mov dword [rdi], 10
    call print_buffer
    jmp exit


print_buffer:
    mov     rdi, rev_buf        ; string1 to destination index
    xor     rcx, rcx            ; zero rcx
    not     rcx                 ; set rcx = -1
    xor     al, al              ; zero the al register (initialize to NUL)
    cld                         ; clear the direction flag
    repnz   scasb               ; get the string length (dec rcx through NUL)
    not     rcx                 ; rev all bits of negative results in absolute value
    dec     rcx                 ; -1 to skip the null-terminator, rcx contains length
    mov     rdx, rcx            ; put length in rdx

    ; write string to stdout
    mov     rsi, rev_buf        ; string1 to source index
    mov     rax, 1              ; set write to command
    mov     rdi, rax            ; set destination index to rax (stdout)
    syscall                     ; call kernel

    ; exit 
    xor     rdi,rdi             ; zero rdi (rdi hold return value)
    mov     rax, 60           ; set syscall number to 60 (0x3c hex)
    ret

exit:
    syscall
    ret
    