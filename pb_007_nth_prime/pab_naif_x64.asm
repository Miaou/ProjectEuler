; -----
; Scans then prints the number of args...
; Should be ok using just nasm and ld, but easier to use gcc instead of ld...
; -----

global      main
extern      printf, sscanf


SECTION     .data
    sFmt:           db  "pab_naif_asm64(%lld) = %lld", 0x0A, 0 ; 0x0A is '\n'...
    sFmtScanf:      db  "%ld", 0
    sErrNoPrime:    db  "Il faut donner l'indice du nombre à trouver", 0x0A, 0
SECTION     .bss
    iPrime:         resw    1
    root:           resq    1

SECTION     .text


main:

  get_nth_prime:
    push    rbx
    dec     rdi
    jz      no_prime

    ;add     rsi, 8                      ; argv++
    mov     rdi, [rsi+8]
    mov     rsi, sFmtScanf
    mov     rdx, iPrime
    mov     rcx, 0
    mov     al, 0
    call    sscanf
    test    rax, rax
    jz      no_prime
    mov     r10, [iPrime]

  ; rcx: i principal
  ; rdx:rax: pour la division
  ; rbx: j
  ; r8: iPrime
  ; r9: root
  ;; r10: bPrime
  ; r10: iPrime Origine
  f_naive:
    mov     r8, [iPrime]
    ; si iPrime < 2, on renvoie 2
    mov     rcx, 2
    cmp     r8, 2
    jb      show_result

    mov     rcx, 2
   loop_i:
    cmp     r8, 1
    jb      show_result
    mov     [root], rcx
    fild    qword [root]
    fsqrt
    fistp   qword [root]
    mov     r9, [root]

    mov     rbx, 2
   loop_j:
    mov     rax, rcx
    cqo
    div     rbx
    test    rdx, rdx
    jz      not_prime
    inc     rbx
    cmp     rbx, r9
    jbe     loop_j
   
   ;prime:
    dec     r8
    cmp     r8, 1
    jz      show_result
   not_prime:
    inc     rcx
    jmp     loop_i

  show_result:
    mov     rdi, sFmt
    mov     rsi, r10
    mov     rdx, rcx
    mov     al, 0                       ; x86_64 ABI: varags should specify the number of vector args in al...
    call    printf
    jmp     end

  no_prime:
    mov     rdi, sErrNoPrime
    mov     al, 0
    call    printf

  end:
    pop     rbx
    xor     rax, rax
    ret
