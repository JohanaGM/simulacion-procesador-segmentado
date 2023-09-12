.data
prompt1: .asciiz "Ingrese el número de términos de la serie Fibonacci: "
newline: .asciiz "\n"
result: .asciiz "La serie Fibonacci es: "

.text
.globl main

main:
    # Imprimir prompt1
    li $v0, 4
    la $a0, prompt1
    syscall

    # Leer el número de términos
    li $v0, 5
    syscall
    move $s0, $v0   # $s0 guarda el número de términos

    # Inicializar los primeros dos términos de la serie
    li $t0, 0       # F(0)
    li $t1, 1       # F(1)

    # Imprimir los primeros dos términos
    li $v0, 1
    move $a0, $t0
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    # Calcular y imprimir el resto de la serie
    move $s1, $s0   # $s1 guarda el contador de términos restantes

fibonacci_loop:
    # Calcular el siguiente término
    add $t2, $t0, $t1   # $t2 = $t0 + $t1
    move $t0, $t1       # $t0 = $t1
    move $t1, $t2       # $t1 = $t2

    # Imprimir el término calculado
    li $v0, 4
    la $a0, result
    syscall
    li $v0, 1
    move $a0, $t2
    syscall

    # Decrementar el contador de términos restantes
    subi $s1, $s1, 1

    # Verificar si quedan términos por calcular
    bnez $s1, fibonacci_loop

    # Terminar programa
    li $v0, 10
    syscall