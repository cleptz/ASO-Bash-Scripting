#!/bin/bash

#####################################
# author: Pablo Barroso Bastardo
# Description: script que automatiza el proceso de conectarse a un servidor ldap
#
#
#####################################


ip=192.168.86.157

bash="dc=paloma,dc=es"

ldapsearch -x -H ldap://$ip -b $bash

