#!/bin/bash

# Directorio donde se almacenan las copias
DIRECTORIO="/bacabian"

# Buscar y eliminar solo los ficheros que comiencen por CopDifSem- y tengan más de 30 días de antigüedad
find "$DIRECTORIO" -name "CopDifSem-*.tar.gz" -mtime +30 -exec rm -f {} \;#!/bin/bash
# Eliminar solo los ficheros que comiencen por CopDifSem- en la carpeta de respaldos
rm -f /bacabian/CopDifSem-*.tar.gz
