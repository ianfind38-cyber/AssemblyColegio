.data
s:   .space 100
msg: .asciiz "Palabra: "
ok:  .asciiz "\nEs palindrome"
no:  .asciiz "\nNo es palindrome"
ct:  .asciiz "\nCantidad: " 
.text
main:
    # Pedir y leer palabra
    li $v0,4
    la $a0,msg
    syscall
    li $v0,8
    la $a0,s
    li $a1,100
    syscall
    # Mostrar palabra ingresada
    li $v0,4
    la $a0,s
    syscall
    # $t0 = posición actual
    # $t1 = cantidad de caracteres
    la $t0,s
    li $t1,0
contar:
    lb $t2,0($t0)          # leer carácter
    beq $t2,10,preparar    # ENTER → terminar
    beq $t2,0,preparar     # fin → terminar
    addi $t1,$t1,1         # contador++
    addi $t0,$t0,1         # siguiente carácter
    j contar
preparar:
    # $t0 = primero
    # $t2 = último
    la $t0,s
    add $t2,$t0,$t1
    addi $t2,$t2,-1
comparar:
    bge $t0,$t2,es         # llegamos al medio
    lb $t3,0($t0)          # carácter primero
    lb $t4,0($t2)          # carácter último
    bne $t3,$t4,noes       # si son distintos → no
    addi $t0,$t0,1         # avanzar primero
    addi $t2,$t2,-1        # retroceder último
    j comparar
es:
    la $a0,ok
    j mostrar
noes:
    la $a0,no
mostrar:
    li $v0,4
    syscall                # mostrar resultado
    la $a0,ct
    li $v0,4
    syscall                # "Cantidad:"
    move $a0,$t1
    li $v0,1
    syscall                # mostrar cantidad
    li $v0,10
    syscall                # terminar   