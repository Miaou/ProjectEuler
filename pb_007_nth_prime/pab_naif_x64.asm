; -----
; Scans then prints the number of args...
; Should be ok using just nasm and ld, but easier to use gcc instead of ld...
; -----

global      main
extern      printf, sscanf


SECTION     .data
    sFmt:           db  "iPrime: %d", 0x0A, 0 ; 0x0A is '\n'...
    sFmtScanf:      db  "%ld", 0
    sErrNoPrime:    db  "Il faut donner l'indice du nombre à trouver", 0x0A, 0
SECTION     .bss
    iPrime:         resw    4

SECTION     .text


main:

  get_nth_prime:
    dec     rdi
    jz     no_prime

    ;add     rsi, 8                      ; argv++
    mov     rdi, [rsi+8]
    mov     rsi, sFmtScanf
    mov     rdx, iPrime
    mov     rcx, 0
    mov     al, 0
    call    sscanf
    test    rax, rax
    jz      no_prime

    mov     rsi, [iPrime]
    mov     rdi, sFmt
    mov     al, 0                       ; x86_64 ABI: varags should specify the number of vector args in al...
    call    printf
    ret

  no_prime:
    mov     rdi, sErrNoPrime
    mov     al, 0
    call    printf
    ret
