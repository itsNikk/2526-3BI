#!/bin/bash
read -a codici -p "Inserisci i codici studenti separati da spazio: "
if [ ${#codici[@]} -eq 0 ]; then echo "Errore: nessun codice inserito."; exit 1; fi
validi=0
non_validi=0
for c in "${codici[@]}"; do
    ./verifica_codice.sh $c
    if [ $? -eq 0 ]; then
        echo $c >> presenti.txt
        validi=$((validi + 1))
    else
        echo $c >> errori.txt
        non_validi=$((non_validi + 1))
    fi
done
echo "Codici validi    : $validi -> presenti.txt"
echo "Codici non validi: $non_validi -> errori.txt"
