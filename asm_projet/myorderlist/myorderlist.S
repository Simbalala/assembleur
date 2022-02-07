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
    mov r9, rdi
    mov r15, rsi
    ; dec r15
    push rdi
    push rdx
    

loop_array:
    pop rdx
    pop rdi
    cmp rdx, r15
    jge load_eof
    mov rax, [r9 + 8 * rdx]
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
    jge load_eof

loader:
    call load_comma
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
    mov rdi, rev_buf
    mov dword [rdi], 10
    call print_buffer
    jmp exit


print_buffer:
    mov     rdi, rev_buf        
    xor     rcx, rcx            
    not     rcx                 
    xor     al, al              
    cld                         
    repnz   scasb               
    not     rcx                 
    dec     rcx                 
    mov     rdx, rcx        

    ; write string to stdout
    mov     rsi, rev_buf        
    mov     rax, 1              
    mov     rdi, rax           
    syscall                     

    ; exit 
    xor     rdi,rdi             
    mov     rax, 60
    ret

exit:
    syscall
    ret
    