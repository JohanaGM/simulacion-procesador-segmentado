.data
numbers: .word 0, 0, 0
result: .word 0

.text
.globl main

main:
    # Pedir al usuario que ingrese los números
    li $t0, 0 # Inicializamos el índice del array en 0
    la $t1, numbers # Cargamos la dirección base del array
    
input_loop:
    # Mostrar mensaje para ingresar número
    li $v0, 4
    la $a0, input_message
    syscall
    
    # Leer el número ingresado
    li $v0, 5
    syscall
    move $t2, $v0
    
    # Guardar el número en el array
    sw $t2, 0($t1)
    
    # Incrementar el índice
    addi $t0, $t0, 1
    
    # Chequear si se han ingresado tres números
    bne $t0, 3, input_loop
    
    # Llamar a la función que encuentra el mayor
    la $a0, numbers
    jal find_max
    
    # Imprimir el resultado
    li $v0, 4
    la $a0, output_message
    syscall
    
    li $v0, 1
    lw $a0, result
    syscall
    
    # Terminar programa
    li $v0, 10
    syscall

# Función para encontrar el número mayor
find_max:
    lw $t3, 0($a0) # Cargar el primer número
    lw $t4, 4($a0) # Cargar el segundo número
    bgt $t3, $t4, check_third # Saltar a check_third si el primer número es mayor
    
    move $t3, $t4 # Si el segundo número es mayor, actualizar el candidato a mayor
    j check_third # Saltar a check_third
    
check_third:
    lw $t4, 8($a0) # Cargar el tercer número
    bgt $t3, $t4, store_result # Saltar a store_result si el candidato a mayor es mayor
    
    move $t3, $t4 # Si el tercer número es mayor, actualizar el candidato a mayor
    
store_result:
    sw $t3, result # Guardar el resultado en la variable 'result'
    jr $ra # Volver a la llamada

.data
    input_message: .asciiz "Ingrese un número: "
    output_message: .asciiz "El número mayor es: "