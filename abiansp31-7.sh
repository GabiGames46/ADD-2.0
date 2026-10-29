#!/bin/bash

# Fichero de registro propio donde se guardarán las alertas
FICHERO_LOG="/home/abian/Escritorio/scripts/registro_disco.log"

# Umbral de aviso (puedes bajarlo temporalmente a 5 o 10 para probar)
UMBRAL=80

# Obtener fecha y hora actual
FECHA_HORA=$(date "+%Y-%m-%d %H:%M:%S")

# Leer el comando df omitiendo la cabecera y procesar partición por partición
df -P | awk 'NR > 1 {print $6, $5}' | while read -r particion porcentaje; do
    # Limpiar el símbolo '%' del porcentaje (ej: "85%" pasa a ser "85")
    valor_uso=${porcentaje%\%*}
    
    # Comprobar si supera el umbral establecido
    if [ "$valor_uso" -ge "$UMBRAL" ]; then
        echo "[$FECHA_HORA] ALERTA: La partición '$particion' está al ${valor_uso}% de uso." >> "$FICHERO_LOG"
    fi
done
