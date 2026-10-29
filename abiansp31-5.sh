#!/bin/bash

# Nombre del archivo de informe que se va a generar
INFORME="informe_errores.txt"

# Crear o vaciar el archivo de informe al comenzar
> "$INFORME"

echo "Analizando los registros en /var/log..."

# Recorrer todos los elementos dentro de /var/log
for archivo in /var/log/*; do
    # Comprobar si es un archivo regular (excluyendo carpetas)
    if [ -f "$archivo" ]; then
        
        # Buscar líneas que contengan "error" o "fail" (ignorando mayúsculas/minúsculas)
        coincidencias=$(grep -i -E "error|fail" "$archivo" 2>/dev/null)
        
        # Si se encuentran coincidencias, se añaden al informe con separación visual
        if [ -n "$coincidencias" ]; then
            echo "==================================================" >> "$INFORME"
            echo "FICHERO DE ORIGEN: $archivo" >> "$INFORME"
            echo "==================================================" >> "$INFORME"
            echo "$coincidencias" >> "$INFORME"
            echo -e "\n" >> "$INFORME"
        fi
        
    fi
done

echo "¡Informe generado con éxito! Revisa el fichero: $INFORME"
