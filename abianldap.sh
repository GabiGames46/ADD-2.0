#creo la variable para que tanto el bucle como el switch puedan usar de condicionante.
opcion=0

#inicio el bucle y le pongo de condicion que si la variable opcion es diferente de 4 se siga ejecutando.
while [ "$opcion" -ne 4 ]
do

    #opciones del menu.
    echo ""
    echo "--- MENU LDAP ABIAN ---"
    echo "1. Eliminar correo"
    echo "2. Modificar correo"
    echo "3. Busquedas"
    echo "4. Salir"

    #permito al usuario elegir una opcion.
    read -p "Elige una opcion: " opcion
    echo ""

    #inicio el case con un numero por opcion.
    case $opcion in
        1)
            #le permito al usuario seleccionar el usuario y la unidad organizativa en la que se encuentra.
            echo "--- ELIMINAR CORREO ---"
            read -p "Usuario (cn): " usu
            read -p "OU (Alumnado/Profesorado): " ou

            # Crear y rellenar el archivo ldif con echo
            echo "dn: cn=$usu,ou=$ou,dc=abian2026,dc=ldap" > cambio.ldif
            echo "changetype: modify" >> cambio.ldif
            echo "delete: mail" >> cambio.ldif

            #ejecuto el archivo con configuracion añadida en el y luego lo elimino para la proxima vez que se quiera ejecutar el script.
            ldapmodify -x -D "cn=admin,dc=abian2026,dc=ldap" -W -f cambio.ldif
            rm cambio.ldif
            ;;

        2)
            #le permito al usuario seleccionar usuario la unidad organizativa en la que se encuentra y el correo.
            echo "--- MODIFICAR CORREO ---"
            read -p "Usuario (cn): " usu
            read -p "OU (Alumnado/Profesorado): " ou
            read -p "Nuevo correo: " mail

            # Crear y rellenar el archivo ldif con echo
            echo "dn: cn=$usu,ou=$ou,dc=abian2026,dc=ldap" > cambio.ldif
            echo "changetype: modify" >> cambio.ldif
            echo "replace: mail" >> cambio.ldif
            echo "mail: $mail" >> cambio.ldif

            #ejecuto el archivo con la configuracion que acabamos de insertar en el y lo elimino para  la proxima ejecucion del script.
            ldapmodify -x -D "cn=admin,dc=abian2026,dc=ldap" -W -f cambio.ldif
            rm cambio.ldif
            ;;

        3)
            #le enseño al usuario las opciones de busqueda que tiene que es o mostrar todo o simplemente buscar uno.
            echo "--- BUSQUEDAS ---"
            echo "a) Buscar un usuario"
            echo "b) Listar todos"

            #dejo que pueda seleccionar la opcion que el usuario quiera.
            read -p "Opcion: " subop

            if [ "$subop" = "a" ]; then

                #en el caso de que se ejecute la primera opcion le digo que inserte el nombre del usuario luego ejecuto el siguiente comando para filtrarlo.
                read -p "Nombre del usuario: " usu
                ldapsearch -x -b "dc=abian2026,dc=ldap" "(cn=$usu)" cn mail
            elif [ "$subop" = "b" ]; then

                #en el caso de que ejecute la segunda opcion uso un comando para mostrarlos todos.
                ldapsearch -x -b "dc=abian2026,dc=ldap" "(objectClass=inetOrgPerson)" cn mail
            else

                #en el caso de que se equivoque y no ponga ni la primera ni segunda opcion el condicional lo filtrara haciendo que no salten errores.
                echo "Opcion no valida"
            fi
            ;;

        4)
            #opcion de salida del bucle
            echo "Saliendo del programa..."
            ;;

            #opcion por defecto por si se usa una opcion invalida como 27.
        *)
            echo "Opcion incorrecta"
            ;;
    esac
done
