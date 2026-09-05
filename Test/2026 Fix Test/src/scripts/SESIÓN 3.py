# Solución 1: usar max() con key=len
palabras = ["sol", "computadora", "mesa", "teclado", "luz"]

def palabra_mas_larga_max(lista):
    return max(lista, key=len)

# Solución 2: recorrido manual comparando longitudes

def palabra_mas_larga_manual(lista):
    palabra_mas_larga = lista[0]
    for palabra in lista[1:]:
        if len(palabra) > len(palabra_mas_larga):
            palabra_mas_larga = palabra
    return palabra_mas_larga

if __name__ == "__main__":
    print("Solución 1: usando max()")
    print(f"La palabra más larga es: {palabra_mas_larga_max(palabras)}")
    print()
    print("Solución 2: usando recorrido manual")
    print(f"La palabra más larga es: {palabra_mas_larga_manual(palabras)}")
