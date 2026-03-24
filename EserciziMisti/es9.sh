#!/bin/bash

if [ -z $1 ]; then
  echo "Errore: codice modulo mancante."
  exit 1
fi
modulo=$1
read -s -p "ID tecnico: " id_tecnico
echo

if [ -z $id_tecnico ]; then
  echo "Errore: ID vuoto."
  exit 1
fi
read -n 1 -p "Livello ispezione (1=rapida, 2=standard, 3=approfondita): " livello
echo

if [ $livello -eq 1 ]; then
    desc="rapida"
elif [ $livello -eq 2 ]; then
    desc="standard"
elif [ $livello -eq 3 ]; then
    desc="approfondita"
else
    echo "ERROR: livello non valido."
    exit 1
fi

echo "Modulo $modulo: ispezione $desc avviata da tecnico $id_tecnico"
