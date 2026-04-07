#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Errore: parametri mancanti. Uso: ./porto3.sh [nave] [file_log]"
    exit 1
fi

nave="$1"
logfile="$2"

if [ ! -f "$logfile" ]; then
    echo "Errore: file $logfile non trovato."
    exit 1
fi

read -p "Numero di container a bordo: " container
read -p "Città di destinazione: " destinazione

if ! [ $container -eq $container ] 2>/dev/null || [ $container -le 0 ]; then
    echo "Errore: numero di container non valido."
    exit 1
fi

if [ -z "$destinazione" ]; then
    echo "Errore: la destinazione non può essere vuota."
    exit 1
fi

riga="Nave $nave - $container container - destinazione: $destinazione"
echo "$riga"
echo "$riga" >> arrivi.log

in_porto=0
in_transito=0
partito=0
altro=0

while read riga_log; do
    stato=$(echo "$riga_log" | cut -d' ' -f4)
    if [ "$stato" == "IN_PORTO" ]; then
        in_porto=$((in_porto + 1))
    elif [ "$stato" == "IN_TRANSITO" ]; then
        in_transito=$((in_transito + 1))
    elif [ "$stato" == "PARTITO" ]; then
        partito=$((partito + 1))
    else
        altro=$((altro + 1))
    fi
done < "$logfile"

totale=$((in_porto + in_transito + partito + altro))

echo "=== RIEPILOGO STATI ==="  > riepilogo_stati.txt
echo "IN_PORTO   : $in_porto"   >> riepilogo_stati.txt
echo "IN_TRANSITO: $in_transito" >> riepilogo_stati.txt
echo "PARTITO    : $partito"     >> riepilogo_stati.txt
echo "Altro      : $altro"       >> riepilogo_stati.txt
echo "Totale     : $totale"      >> riepilogo_stati.txt
echo "======================="   >> riepilogo_stati.txt

cat riepilogo_stati.txt
