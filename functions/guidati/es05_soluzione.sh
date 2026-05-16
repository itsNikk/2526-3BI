#!/bin/bash

# es05 — Funzione con array e ciclo
# Scrivi una funzione somma_array() che riceve una lista di numeri
# come argomenti ($@) e stampa la loro somma.
# Scrivi una funzione media_array() che usa somma_array() con $()
# per calcolare la media intera.
# Il main chiede una lista di numeri con read -a e chiama entrambe.

function somma_array() {
    local somma=0
    for n in "$@"; do
        if ! [ $n -eq $n ] 2>/dev/null; then
            echo "Errore: '$n' non e' un intero." >&2
            return 1
        fi
        somma=$((somma + n))
    done
    echo $somma
}

function media_array() {
    local count=$#
    if [ $count -eq 0 ]; then
        echo "Errore: nessun valore." >&2
        return 1
    fi
    local somma
    somma=$(somma_array "$@")
    if [ $? -ne 0 ]; then return 1; fi
    echo $((somma / count))
}

read -a numeri -p "Inserisci una lista di numeri separati da spazio: "

if [ ${#numeri[@]} -eq 0 ]; then
    echo "Errore: nessun numero inserito."
    exit 1
fi

somma=$(somma_array "${numeri[@]}")
if [ $? -ne 0 ]; then
    echo "$somma"
    exit 1
fi

media=$(media_array "${numeri[@]}")
if [ $? -ne 0 ]; then
    echo "$media"
    exit 1
fi

echo "Somma: $somma"
echo "Media: $media"
