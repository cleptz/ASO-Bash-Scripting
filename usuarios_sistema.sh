#!/bin/bash -x

####
##
##
###

path="/var/www/html/"

sudo mkdir /etc/skel/Escritorio
sudo cp /usr/share/applications/sublime_text.desktop /etc/skel/Escritorio/sublime_text.desktop
sudo cp /usr/share/applications/brackets.desktop /etc/skel/Escritorio/brackets.desktop

echo "¿Quiere crear un usuario?: si/no"
read pregunta

while [ $pregunta = "si" ];do



echo "¿Como se va a llamar tu usuario?"
read user

sudo useradd $user -m -d $path$user
echo "Introduzca una contraseña"
sudo passwd $user
echo "¿Quiere crear un usuario?: si/no"
read pregunta
done

sudo rm -R /etc/skel/Escritorio
