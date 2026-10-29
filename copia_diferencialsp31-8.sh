  GNU nano 8.7.1                                      copia_diferencial.sh                                               
#!/bin/bash
# Obtener el número de semana actual del año (ej: 44)
NUM_SEMANA=$(date +%V)

# Realizar la copia empaquetando y comprimiendo /home
tar -czf /bacabian/CopDifSem-$NUM_SEMANA.tar.gz /home
