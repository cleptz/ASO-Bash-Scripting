#!/bin/bash
################
## Author: Pablo Barroso Bastardo.
## Description: script en el que asignamos una ruta para un fichero 
## mediante variables.
################

fichero="index"
extension=".html"
ruta="/var/www/html/"
my_file=$ruta$fichero$extension

echo $my_file
cat $my_file
