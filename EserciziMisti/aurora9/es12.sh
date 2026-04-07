#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro numero rilevazioni mancante."
    exit 1
fi

atteso=$1

if ! [ $atteso -eq $atteso ] 2>/dev/null || [ $atteso -le 0 ]; then
    echo "Errore: numero atteso non valido."
    exit 1
fi

read -a valori -p "Inserisci $atteso valori di pressione separati da spazio: "

if [ ${#valori[@]} -ne $atteso ]; then
    echo "Errore: attesi $atteso valori, inseriti ${#valori[@]}."
    exit 1
fi

somma=0
max=${valori[0]}

for i in $(seq 0 $((atteso - 1))); do
    v=${valori[$i]}
    if ! [ $v -eq $v ] 2>/dev/null; then
        echo "Errore: '$v' non è un intero."
        exit 1
    fi
    somma=$((somma + v))
    if [ $v -gt $max ]; then
        max=$v
    fi
done

media=$((somma / atteso))
echo "Somma: $somma"
echo "Media: $media"
echo "Massimo: $max"
