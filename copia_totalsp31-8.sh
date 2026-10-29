#!/bin/bash
# Obtener el mes en nombre completo y el año completo (ej: octubre-2026)
MES_ANIO=$(date +%B-%Y | tr '[:upper:]' '[:lower:]')

# Realizar la copia de seguridad total de /home
tar -czf /bacabian/CopTot-$MES_ANIO.tar.gz /home
