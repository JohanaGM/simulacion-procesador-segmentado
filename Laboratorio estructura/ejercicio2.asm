.data

prompt1: .asciiz "Ingresa el primer nùmero:"
prompt2: .asciiz "Ingresa el segundo nùmero:"
prompt3: .asciiz "Ingresa el tercer nùmero:"
result_msg: .asciiz "El numero menor es:"

array: .space 12

.text
main:
    #solicitar al usuario que ingrese los numeros 
    li $v0, 4            #cargar el codigo del sistema para imprimir cadena
    la $a0, prompt1      #cargar la direccion de la cadena de prompt1
    syscall              # llamar al sistema
    
    li $v0, 5             # cargar el codigo del sistema para leer un entero 
    syscall              # llamar al sistema
    sb $v0, array        #almacenar el primer numero en el array
    
    li $v0, 4            # Cargar el código del sistema para imprimir cadena
    la $a0, prompt2      # Cargar la dirección de la cadena de prompt2
    syscall              # Llamar al sistema 
    
    li $v0,5             # cargar el codigo del sistema para leer un entero 
    syscall              # llamar al sistema
    sb $v0, array+4       #almacenar el segundo numero en el array
    
    li $v0, 4            #cargar el codigo del sistema para imprimir cadena
    la $a0, prompt3      #cargar la direccion de la cadena de prompt3
    syscall              # llamar al sistema
    
    li $v0,5             # cargar el codigo del sistema para leer un entero 
    syscall              # llamar al sistema
    sb $v0, array+8       #almacenar el tercer numero en el array
    
    #Encontrar el numero menor 
    
    lb $t0, array        #cargar el primer numero en $t0
    lb $t1, array+4      #cargar el segundo numero en $t1
    lb $t2, array+8      #cargar el tercer numero en $t2
    
    move $t3, $t0        # Inicializar $t3 con el primer numero 
    bgt $t1, $t3, menor  # comprobar si el segundo numero es menor
    move $t3, $t1        # si es menor, actualizar $t3
    menor:
        bgt $t2, $t3, fin  # comprobar si el tercer numero es menor 
        move $t3, $t2     # si es menor, actualizar en $t3
    fin:
        
    #finalizar el programa
    
    li $v0, 4              #cargar el codigo del sistema para imprimir cadena
    la $a0, result_msg     #cargar la direccion de la cadena result_msg
    syscall                # llamar al sistema
    
    li $v0, 1            # Cargar el código del sistema para imprimir un entero
    move $a0, $t3        # Cargar el número menor en $a0
    syscall              # Llamar al sistema

    li $v0, 10           # Cargar el código del sistema para salir del programa
    syscall              # Llamar al sistema