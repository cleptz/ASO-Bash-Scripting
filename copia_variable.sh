#!/bin/bash


usuario=$(whoami)
fecha=$(date +%Y-%m-%d_%H%M%S)
entrada=/home/$usuario
salida=/tmp/${usuario}_home_$fecha.tar.gz

tar -czf $salida $entrada
echo "Copia de seguridad de $entrada realizada con éxito. Se ha alojado en $salida"
ls -l $salida

