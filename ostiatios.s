.data
    msg1: .asciiz "papoi"
    letra: .byte 'p'
.text
.globl main
main: 
    la $a0, msg1
    lb $a1, letra   
    jal char_count
    move $a0, $v0
    li $v0, 1
    syscall
    li $v0, 10
    syscall

char_count:
    li $v0, 0
loop:
    lb $t0, 0($a0)
    beqz $t0, fin_loop
    bne $t0, $a1, no_es_igual
    addi $v0, $v0, 1

no_es_igual:
    addi $a0, $a0, 1
    j loop
fin_loop:
    jr $ra
