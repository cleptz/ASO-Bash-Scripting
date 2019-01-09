#!/bin/bash

##############
## Author: Pablo Barroso Bastardo
## Description: script que almacena una serie de variables
## para obtener la fecha y distintos datos acerca de la fecha.
##############


fecha= $date
hora=$(date +%T)
dia_semana=$(date +%A)
dia=$(date +%d)
mes=$(date +%B)
year=$(date +%Y)
hora2=$(date +%I)
minuto=$(date +%M)
segundo=$(date +%S)

echo $fecha
echo $hora
echo $dia_semana
echo $dia
echo $mes
echo $year
echo $hora2
echo $minuto
echo $segundo

