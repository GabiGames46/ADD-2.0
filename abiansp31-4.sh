#!/bin/bash

# Comprobar si el fichero programas.txt existe
if [ ! -f "programas.txt" ]; then
    echo "Error: No se encuentra el fichero programas.txt"
    exit 1
fi

echo "Iniciando proceso de desinstalación..."
echo "----------------------------------------"

# Leer el fichero línea por línea
while IFS= read -r programa; do
    # Omitir líneas vacías
    if [ -n "$programa" ]; then
        echo "Procesando: $programa"
        
        # Comprobar si el programa está instalado en el sistema
        if dpkg -s "$programa" &> /dev/null; then
            echo "-> Desinstalando $programa..."
            sudo apt-get remove -y "$programa"
        else
            echo "-> El programa '$programa' no está instalado. Saltando..."
        fi
        
        echo "----------------------------------------"
    fi
done < programas.txt

echo "Proceso finalizado."
