#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro capacità mancante."
    exit 1
fi

capacita=$1

if ! [ $capacita -eq $capacita ] 2>/dev/null || [ $capacita -le 0 ]; then
    echo "Errore: capacità non valida."
    exit 1
fi

read -p "Livello attuale: " livello
read -p "Quantità da aggiungere: " aggiunta

if ! [ $livello -eq $livello ] 2>/dev/null || [ $livello -lt 0 ]; then
    echo "Errore: livello non valido."
    exit 1
fi

if ! [ $aggiunta -eq $aggiunta ] 2>/dev/null || [ $aggiunta -lt 0 ]; then
    echo "Errore: quantità non valida."
    exit 1
fi

somma=$((livello + aggiunta))

if [ $somma -gt $capacita ]; then
    max_aggiungibile=$((capacita - livello))
    echo "Attenzione: sovraccarico. Puoi aggiungere al massimo $max_aggiungibile unità."
    echo "$(date '+%Y-%m-%d %H:%M:%S') OVERFLOW livello=$livello aggiunta=$aggiunta max=$max_aggiungibile" >> rifornimenti.log
else
    percentuale=$((somma * 100 / capacita))
    echo "Nuovo livello: $somma (${percentuale}% della capacità)"
    echo "$(date '+%Y-%m-%d %H:%M:%S') OK livello=$somma percentuale=${percentuale}%" >> rifornimenti.log
fi
