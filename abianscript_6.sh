#!/bin/bash
#variable de inicio por parametro.
nivel="$1"

#case de seleccion de nivel de seguridad que lo que hace es darle el valor correspondiente a la variable p.
case "$nivel" in

	emergente) p="emerg" ;;
	alerta) p="alert" ;;
	critico) p="crit" ;;
	error) p="err" ;;
	advertencia) p="warning" ;;
	noticia) p="notice" ;;
	informacion) p="info" ;;
	depuracion) p="debug" ;;
#opcion default por si acaso se introduce un valor inesperado
	*)
	  echo "opcion invalida"
	  echo "ejemplo de uso: $0 <nivel_de_severidad>"
	  echo "Ejemplo: $0 error"
	  echo "Niveles disponibles: emergente, alerta, critico, error, advertencia, noticia, informacion, depuracion"
	  exit 1
	  ;;
esac

#comando de ejecucion que usa la variable p para seleccionar el nivel de severidad y selecciona el año y mes actuales
#para delimitar por fecha los archivos que selecciona crea un archivo en nuestro directorio y ya por ultimo cuenta
#lineas y las muestra
journalctl -p "$p" --since "$(date +%Y-%m)-01" | tee ~/logs_"$nivel".txt | wc -l
