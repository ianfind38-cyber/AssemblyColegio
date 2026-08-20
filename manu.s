.data
texto: .asciiz "1234"
.text
main:
    la $t0, texto  
    li $t1, 0
loop:
    lb $t2, 0($t0) 
    beq $t2, $zero, fin
    addi $t2, $t2, -48 
    mul $t1, $t1, 10 
    add $t1, $t1, $t2 
    addi $t0, $t0, 1  
    j loop
fin:
    mul $t1, $t1, 2
    move $a0, $t1
    li $v0, 1
    syscall
    li $v0, 10
    syscall

#resultado = 0

# 0 × 10 + 1 = 1
# 1 × 10 + 2 = 12
# 12 × 10 + 3 = 123
# 123 × 10 + 4 = 1234

# Código	Para qué sirve
# lb $t2, 0($t0)	Leer el carácter
# addi $t2, $t2, -48	Convertir ASCII → número
# mul $t1, $t1, 10	Preparar el número
# add $t1, $t1, $t2	Agregar el dígito

# 0($t0) → posición actual
# 1($t0) → siguiente byte
# 2($t0) → dos bytes después
# 3($t0) → tres bytes después

# $t0
#  ↓
# ┌───┬───┬───┬───┐
# │ 1 │ 2 │ 3 │ 4 │
# └───┴───┴───┴───┘
#     ↑
#     └── 1($t0)

# lb $t2, 0($t0)
#          ↑
#      desplazamiento

# Primera vuelta:  $t2 = '1'
# Segunda vuelta:  $t2 = '2'
# Tercera vuelta:  $t2 = '3'
# Cuarta vuelta:   $t2 = '4'

# Guarda la dirección de dónde estamos leyendo.

# Por ejemplo:

# "1234"


# $t0 → 1
#        ↓
#       2
#       3
#       4

# $t1 → resultado
# li $t1, 0

# Empieza en 0 y va construyendo el número.

# 0 → 1 → 12 → 123 → 1234

# Al terminar:

# $t1 = 1234

# Y después:

# mul $t1, $t1, 2

# queda:

# $t1 = 2468