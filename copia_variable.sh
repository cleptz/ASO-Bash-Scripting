#!/bin/bash

######################
# Author: Pablo Barroso Bastardo
# Description: Script que realiza una copia de seguridad del fichero home de un usuario 
# y cuyo nombre registra la hora en la que se ha realizado dicha copia de seguridad.
######################

usuario=$(whoami)
fecha=$(date +%Y-%m-%d_%H%M%S)
entrada=/home/$usuario
salida=/tmp/${usuario}_home_$fecha.tar.gz

tar -czf $salida $entrada
echo "Copia de seguridad de $entrada realizada con éxito. Se ha alojado en $salida"
ls -l $salida

