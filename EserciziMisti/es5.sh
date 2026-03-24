#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Errore: specificare turno e durata."
  exit 1
fi
turno="$1"
durata="$2"
if ! [ "$durata" -eq "$durata" ] 2>/dev/null || [ "$durata" -le 0 ]; then
  echo "Errore: durata non valida."
  exit 1
fi

if [ $turno -ne 1 ] && [ $turno -ne 2 ] && [ $turno -ne 3 ]; then
    echo "Il turno può essere solo 1,2 o 3"
    exit 1
fi

read -p "Nome astronauta: " nome
if [ -z "$nome" ]; then
  echo "Errore: nome vuoto."
  exit 1
fi

inizio=$(( (turno - 1) * durata ))
fine=$(( inizio + durata ))
echo "$nome : Turno $turno: ore $inizio-$fine"
