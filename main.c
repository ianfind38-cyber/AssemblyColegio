#include <stdio.h>

int char_count(char *s, char c) {
    int count = 0;
    while (*s != '\0') {
        if (*s == c) {
            count++;
        }
        s++;
    }
    return count;
}

int main() {
    // Creamos un espacio en memoria (arreglo) para guardar la palabra del usuario
    // Puede almacenar palabras de hasta 49 letras (+1 del '\0')
    char palabra[50]; 
    char letra;
    
    printf("Ingrese una palabra: ");
    scanf("%s", palabra); // %49s evita que el usuario escriba de más y rompa el programa

    printf("Ingrese el caracter a buscar: ");
    scanf(" %c", &letra); // El espacio antes de %c es clave para limpiar el "Enter" anterior

    // 3. Ejecutar la función con los datos ingresados
    int resultado = char_count(palabra, letra);
    
    // 4. Mostrar el resultado por pantalla
    printf("La letra %c aparece %d veces en la palabra \"%s\".\n", letra, resultado, palabra);
    
    return 0;
}
