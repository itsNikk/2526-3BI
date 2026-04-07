#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro nome sistema mancante."
    exit 1
fi

sistema="$1"

read -s -p "Inserisci la password: " pass1
echo
read -s -p "Conferma la password: " pass2
echo

if [ -z "$pass1" ]; then
    echo "Errore: la password non può essere vuota."
    exit 1
fi

if [ "$pass1" != "$pass2" ]; then
    echo "Errore: le password non coincidono."
    exit 1
fi

echo "$sistema: password impostata" >> passwords.log
echo "Password impostata correttamente."
