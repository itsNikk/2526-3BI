#!/bin/bash
if [ -z $1 ]; then
  echo "Errore: capacità massima mancante."
  exit 1
fi
max=$1

if ! [ $max -eq $max ] 2>/dev/null || [ $max -le 0 ]; then
  echo "Errore: capacità non valida."
  exit 1
fi

read -p "Livello attuale: " livello
read -p "Quantità da aggiungere: " aggiunta

for v in "$livello" "$aggiunta"; do
  if ! [ $v -eq $v ] 2>/dev/null || [ $v -lt 0 ]; then
    echo "Errore: valore non valido."
    exit 1
  fi
done

nuovo=$(( livello + aggiunta ))
if [ $nuovo -gt $max ]; then
  max_add=$(( max - livello ))
  echo "Overflow! Puoi aggiungere al massimo $max_add unità."
  echo "OVERFLOW livello=$livello aggiunta=$aggiunta max_add=$max_add" >> rifornimenti.log
else
  perc=$(( nuovo * 100 / max ))
  echo "Nuovo livello: $nuovo (${perc}%)"
  echo "OK livello=$livello +$aggiunta -> $nuovo (${perc}%)" >> rifornimenti.log
fi
