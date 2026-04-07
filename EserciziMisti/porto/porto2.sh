#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Errore: parametri mancanti. Uso: ./porto2.sh [nave] [capacità_max]"
    exit 1
fi

nave="$1"
capacita=$2

if ! [ $capacita -eq $capacita ] 2>/dev/null || [ $capacita -le 0 ]; then
    echo "Errore: capacità massima non valida."
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

read -a pesi -p "Pesi dei container in tonnellate (separati da spazio): "

if [ ${#pesi[@]} -eq 0 ]; then
    echo "Errore: nessun peso inserito."
    exit 1
fi

totale=0
max=${pesi[0]}
n=${#pesi[@]}

for i in $(seq 0 $((n - 1))); do
    p=${pesi[$i]}
    if ! [ $p -eq $p ] 2>/dev/null || [ $p -le 0 ]; then
        echo "Errore: peso non valido: $p"
        exit 1
    fi
    totale=$((totale + p))
    if [ $p -gt $max ]; then
        max=$p
    fi
done

media=$((totale / n))

echo "Peso totale : $totale ton"
echo "Peso medio  : $media ton"
echo "Peso massimo: $max ton"

if [ $totale -gt $capacita ]; then
    sforamento=$((totale - capacita))
    echo "AVVISO: sovraccarico di $sforamento tonnellate."
else
    percentuale=$((totale * 100 / capacita))
    echo "Capacità utilizzata: ${percentuale}%"
fi
