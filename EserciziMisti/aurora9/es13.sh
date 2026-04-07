#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro nome deposito mancante."
    exit 1
fi

deposito="$1"

read -a articoli -p "Nomi articoli (separati da spazio): "
read -a quantita -p "Quantità corrispondenti (separati da spazio): "

if [ ${#articoli[@]} -ne ${#quantita[@]} ]; then
    echo "Errore: il numero di articoli e quantità non coincide."
    exit 1
fi

n=${#articoli[@]}
totale=0

for i in $(seq 0 $((n - 1))); do
    q=${quantita[$i]}
    if ! [ $q -eq $q ] 2>/dev/null || [ $q -le 0 ]; then
        echo "Errore: quantità non valida per '${articoli[$i]}'."
        exit 1
    fi
    echo "  ${articoli[$i]}: $q unità"
    totale=$((totale + q))
done

echo "Totale articoli in magazzino: $totale"
