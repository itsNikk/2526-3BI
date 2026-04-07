#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro codice modulo mancante."
    exit 1
fi

modulo="$1"

read -s -p "ID tecnico: " id
echo

if [ -z "$id" ]; then
    echo "Errore: ID tecnico non può essere vuoto."
    exit 1
fi

read -n 1 -p "Livello ispezione (1=rapida, 2=standard, 3=approfondita): " livello
echo

if [ "$livello" == "1" ]; then
    descrizione="rapida"
elif [ "$livello" == "2" ]; then
    descrizione="standard"
elif [ "$livello" == "3" ]; then
    descrizione="approfondita"
else
    echo "Errore: livello non valido."
    exit 1
fi

echo "Modulo $modulo - ispezione $descrizione avviata da tecnico $id"
