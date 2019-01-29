#!/bin/bash -x





echo "Introduzca el nombre del dominio (example es)"
read dominio term
rootdn="cn=admin,dc=$dominio,dc=$term"

#Funcion para crear unidades organizativas

function crear_ou {
	clear
	fichero="/home/pablo/script/auto.ldif"
	nombre="s"

	echo "Introduzca el nombre de la unidad organizativa"
	read nombre

	until [ $nombre = "f" ]; do
	
		echo -e "dn: "ou=$nombre,dc=$dominio,dc=$term"
	objectClass: organizationalUnit
	ou: $nombre \n" >> $fichero
		echo "Introduzca el nombre de la unidad organizativa"
		read nombre
	done
	credenciales="cn=admin,dc=pablo,dc=es"
	ldapadd -D "$credenciales" -W -f "$fichero"

	ldapsearch -x -b "dc=$dominio,dc=$term" objectClass=organizationalUnit

	> $fichero
}

#Funcion para borrar unidades organizativas

function borrar_ou {
	clear
	ldapsearch -x -b "dc=$dominio,dc=$term" objectClass=organizationalUnit|grep dn:
	echo "Introduzca el nombre de la unidad organizativa"
	read nombre
	credenciales="cn=admin,dc=pablo,dc=es"
	pass="Valladolid2018"
	until [ $nombre = "f" ]; do
	
		ldapsearch -x -b "dc=$dominio,dc=$term" ou=$nombre
		echo "¿Realmente desea eliminar esa OU?: si/no"
		read respuesta
		if [ $respuesta = "si" ]; then
			ldapdelete -x -D "$credenciales" -w "$pass" ou=$nombre,dc=$dominio,dc=$term
		fi
			echo "Introduzca el nombre de la unidad organizativa"
			read nombre
	done
}


function crear_usuario {
	clear
	sudo touch "/home/pablo/script/NuevoUser.ldif"
	pathldif="/home/pablo/script/NuevoUser.ldif"
	echo "Introduzca el nombre de usuario"
	read usuario
	echo "Introduzca el apellido del usuario"
	read apellido
	listar_ou
	echo "Introduzca el nombre de la OU a la que se debe añadir el usuario"
	read ou
	echo "Introduzca el nombre con el que desea que se muestre el usuario"
	read mostrar
	ult=`ldapsearch -xLLL -b "dc=$dominio,dc=$term" |grep uidNumber |cut -d: -f2 |tail -1`
	nuevo_uid=`expr $ult + 1`
	echo "dn: cn=$usuario, ou=$ou,dc=$dominio,dc=$term" > $pathldif
	echo "objectClass: inetOrgPerson" >> $pathldif
	echo "objectClass: posixAccount" >> $pathldif
	echo "objectClass: shadowAccount" >> $pathldif
	echo "uid: $usuario" >> $pathldif
	echo "sn: $apellido" >> $pathldif
	echo "givenName: $usuario" >> $pathldif
	echo "displayName: $mostrar" >> $pathldif
	echo "uidNumber : $nuevo_uid" >> $pathldif
	echo "gidNumber: 10010" >> $pathldif
	echo "gecos: $mostrar" >> $pathldif
	echo "loginShell: /bin/bash" >> $pathldif
	echo "homeDirectory: /home/$usuario" >> $pathldif
	sudo ldapadd -c -x -D $rootdn -W -f $pathldif #> /dev/null 2>&1
	if [ ! $? -eq "0" ];then
			echo "Este usuario ya existe"
		else
			echo "El usuario $mostrar se ha creado correctamente"
	fi
	sleep 2
}

function borrar_usuario {
	clear
	ldapsearch -x -b "dc=pablo,dc=es" objectClass=inetOrgPerson|grep -e dn: -e cn:
	echo "Introduzca el nombre del usuario que desea borrar"
	read user
	echo "Introduzca la OU a la que pertenece este usuario"
	read ou
	ldapdelete -x -D $rootdn -W  cn=$user,ou=$ou,dc=$dominio,dc=$term
	echo "Usuario $user eliminado"

}

function listar_ou {
	clear
	ldapsearch -x -b "dc=$dominio,dc=$term" objectClass=organizationalUnit|grep dn:
}

function menu {
	echo "1 - Crear OU
	2 - Borrar OU
	3 - Crear usuario
	4 - Borrar usuario
	5 - Listar OU
	6 - Finalizar"
}




menu
echo "Introduzca el numero de su eleccion."
read eleccion
while [ $eleccion != 6 ];do
	if [ \( $eleccion -gt 0 \) -a \( $eleccion -le 6 \) ];then
		case $eleccion in
		1)
			crear_ou
		;;
		2)
			borrar_ou
		;;
		3)
			crear_usuario
		;;
		4)
			borrar_usuario
		;;
		5)
			listar_ou
		;;
		6)
			echo "Adios."
			exit
		;;
		esac

	else
		echo "Ha elegido una opcion no valida."
	fi
menu
	echo "Introduzca el numero de su eleccion."
	read eleccion
done








