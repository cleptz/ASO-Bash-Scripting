#!/bin/bash

################
## Author: Pablo Barroso Bastardo.
## Description: script en el que creamos una frase de bienvenida
## mediante variables.
################

greeting="Welcome"

user=$(whoami)

day=$(date +%A)

echo "$greeting back $user! Today is $day, which is the best day of the entire week!"


