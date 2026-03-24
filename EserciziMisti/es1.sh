#!/bin/bash

#Non è l'unica soluzione possibile...
if [ -z $1 ]; then
    echo "Reparto obbligatorio"
    echo "Utilizzo script: $0 <nomeReparto>"
    exit 1
fi

reparto=$1

read -p "Inserire nome astronauta: " nome
read -p "Inserire età astronauta: " eta

if [ -z $nome ]
then
    echo "Nome vuoto, non ammissibile"
    exit 1
fi

#Non è l'unica soluzione...
#1)
#if [[ $eta == *[!0-9]* ]] || [ $eta -lt 0 ]; then
#    echo "Età deve essere un numero maggiore di zero ($eta)"
#    exit 1
#fi

#2) Interessante... perchè?
if ! [ $eta -eq $eta ] 2>/dev/null || [ $eta -le 0 ]; then
    echo "Età non valida. Deve essere un numero maggiore di zero ($eta)"
    exit 1
fi

echo "Benvenuto $nome nel reparto $reparto. Anni di servizio $((40-$eta))"