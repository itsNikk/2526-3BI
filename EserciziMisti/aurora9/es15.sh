#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro soglia mancante."
    exit 1
fi

soglia=$1

if ! [ $soglia -eq $soglia ] 2>/dev/null || [ $soglia -le 0 ]; then
    echo "Errore: soglia non valida."
    exit 1
fi

read -a letture -p "Inserisci le letture dei sensori (separati da spazio): "

if [ ${#letture[@]} -eq 0 ]; then
    echo "Errore: nessun valore inserito."
    exit 1
fi

anomalie=0
n=${#letture[@]}

for i in $(seq 0 $((n - 1))); do
    v=${letture[$i]}
    if ! [ $v -eq $v ] 2>/dev/null; then
        echo "Errore: '$v' non è un intero."
        exit 1
    fi
    if [ $v -lt 0 ]; then
        assoluto=$((-v))
    else
        assoluto=$v
    fi
    if [ $assoluto -gt $soglia ]; then
        echo "Anomalia rilevata: valore $v all'indice $i"
        echo "$i: $v" >> anomalie.log
        anomalie=$((anomalie + 1))
    fi
done

echo "Totale anomalie: $anomalie"
