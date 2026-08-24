.data
    msg_prueba: .asciiz "Holamundo en mips"
.text
.globl main
main:
    la $a0, msg_prueba
    jal wc
    move $a0, $v0
    li $v0, 1
    syscall
    li $v0, 10
    syscall
wc:
    li $v0, 0
    li $t2, 32
loop:
    lb $t0, 0($a0)
    beqz $t0, fin_wc
    addi $a0, $a0, 1
    beq $t0, $t2, loop
    lb $t1, 0($a0)
    beq $t1, $t2, sumar
    bnez $t1, loop
sumar:
    addi $v0, $v0, 1
    j loop
fin_wc:
    addi $v0, $v0, -1
    jr $ra
