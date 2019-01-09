#!/bin/bash


fichero="index"
extension=".html"
ruta="/var/www/html/"
my_file=$ruta$fichero$extension

echo $my_file
cat $my_file
