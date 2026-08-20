.data

.text
.globl main

main:
    # Punto 1: (x1,y1) = (1,2)
    # Punto 2: (x2,y2) = (4,6)

    li $a0, 1       # x1
    li $a1, 2       # y1
    li $a2, 4       # x2
    li $a3, 6       # y2

    jal D2          # llamar a D2

    # Mostrar resultado
    move $a0, $v0
    li $v0, 1
    syscall

    # Terminar
    li $v0, 10
    syscall


# --------------------------------
# D2(x1,y1,x2,y2)
# --------------------------------

D2:
    # x2 - x1
    sub $t0, $a2, $a0

    # Guardar y2 - y1
    sub $t1, $a3, $a1

    # square(x2-x1)
    move $a0, $t0
    jal square

    move $t2, $v0       # guardar primer cuadrado

    # square(y2-y1)
    move $a0, $t1
    jal square

    # sumar los dos cuadrados
    add $v0, $t2, $v0

    jr $ra


# --------------------------------
# square(x) = x * x
# --------------------------------

square:
    mul $v0, $a0, $a0
    jr $ra
# 1. Entrada de datos y "Eco" en pantallaassembly    li $v0, 4
#     la $a0, msg
#     syscall       # Imprime "Palabra: "

#     li $v0, 8
#     la $a0, s
#     li $a1, 100
#     syscall       # Abre la ventana flotante en JsSpim y lee el texto

#     li $v0, 4
#     la $a0, s
#     syscall       # Imprime la palabra guardada en la consola (el "Eco")
# Usa el código con precaución.Qué hace: Imprime el mensaje inicial, detiene el programa para que el usuario escriba la palabra en la ventana emergente de JsSpim y, inmediatamente después, vuelve a imprimir esa palabra para que quede visible en la consola de salida.2. Conteo de caracteres y limpieza del "Enter"assembly    la $t0, s     # $t0 apunta al inicio de la palabra
#     li $t1, 0     # $t1 será el contador (empieza en 0)

# contar:
#     lb $t2, 0($t0)               # Lee una letra de la memoria
#     beq $t2, 0, preparar         # Si es el fin de la cadena (\0), va a preparar
#     beq $t2, 10, corregir_enter  # Si es el salto de línea (\n), va a corregir

#     addi $t1, $t1, 1             # Suma 1 al contador de letras
#     addi $t0, $t0, 1             # Avanza a la siguiente letra de la memoria
#     j contar

# corregir_enter:
#     sb $zero, 0($t0)             # Reemplaza el '\n' por un '\0' para "recortarlo"
# Usa el código con precaución.Qué hace: Recorre la palabra letra por letra en la memoria. Si encuentra una letra válida, incrementa el contador $t1. Si encuentra un salto de línea (10 en ASCII, generado al presionar Enter), lo destruye reemplazándolo por un cero ($zero) para que no interfiera en la comparación posterior.3. Preparación de los dos punterosassemblypreparar:
#     beq $t1, 0, es               # Si la palabra está vacía, va directo a "es"
#     la $t0, s                    # $t0 vuelve a apuntar al INICIO de la palabra
#     add $t2, $t0, $t1            # Calcula la dirección del final
#     addi $t2, $t2, -1            # $t2 apunta exactamente al ÚLTIMO carácter válido
# Usa el código con precaución.Qué hace: Coloca un puntero en la primera letra ($t0) y calcula matemáticamente dónde termina la palabra usando la cantidad de letras para colocar un segundo puntero en la última letra ($t2).4. Comparación de extremos (Algoritmo del Palíndromo)assemblycomparar:
#     bge $t0, $t2, es             # Si los punteros se cruzaron o son iguales, ¡SÍ es palíndromo!
#     lb $t3, 0($t0)               # Carga la letra del inicio
#     lb $t4, 0($t2)               # Carga la letra del final

#     bne $t3, $t4, noes           # Si son letras diferentes, NO es palíndromo y sale

#     addi $t0, $t0, 1             # Mueve el puntero izquierdo un paso a la derecha
#     addi $t2, $t2, -1            # Mueve el puntero derecho un paso a la izquierda
#     j comparar
