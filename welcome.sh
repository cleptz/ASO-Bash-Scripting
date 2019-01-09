#!/bin/bash

greeting="Welcome"

user=$(whoami)

day=$(date +%A)

echo "$greeting back $user! Today is $day, which is the best day of the entire week!"


