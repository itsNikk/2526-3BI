#!/bin/bash

# 1. prendere e controllare i parametri da CMD

if [ -z $1 ]
then
    echo "Primo parametro non inserito"
    read -p "Dammi il primo parametro: " a
else
    a=$1
fi

if [ -z $2 ]
then
    echo "Secondo parametro non inserito"
    read -p "Scrivi 2ndo param: " op
    op=$2
fi

if [ -z $3 ]
then
    echo "terzo parametro da inserire"
    echo -n "Inserisci il terzo param: "
    read b
else
    b=$3
fi

# Controllate op... e se op=s sommate a e b
#== in Java
# in bash... pensa all'inglese... equals -eq
#-ne -gt -lt
# se $op è uguale a un certo operando... allora fai qua
