#!/bin/bash
# as03 — Statistiche su file di numeri
# Funzioni: leggi_numeri() che legge un file e stampa i valori su stdout,
#           minimo(), massimo(), media(), conta() — tutte ricevono i numeri
#           come argomenti ($@) e stampano il risultato.
# Il main riceve il file come $1, carica i numeri con $() e chiama
# tutte le funzioni. Trap su EXIT stampa un riepilogo.

function leggi_numeri() {
    local file="$1"
    if [ ! -f "$file" ]; then
        echo "Errore: file non trovato." >&2
        return 1
    fi
    cat "$file"
}

function conta() {
    echo $#
}

function minimo() {
    local min=$1
    for n in "$@"; do
        if [ $n -lt $min ]; then min=$n; fi
    done
    echo $min
}

function massimo() {
    local max=$1
    for n in "$@"; do
        if [ $n -gt $max ]; then max=$n; fi
    done
    echo $max
}

function media() {
    local count=$#
    if [ $count -eq 0 ]; then echo 0; return 0; fi
    local somma=0
    for n in "$@"; do somma=$((somma + n)); done
    echo $((somma / count))
}

riepilogo_finale=""

function gestisci_exit() {
    echo ""
    echo "=== RIEPILOGO FINALE ==="
    echo "$riepilogo_finale"
    echo "========================"
}

trap gestisci_exit EXIT

if [ -z "$1" ] || [ ! -f "$1" ]; then
    echo "Errore: file mancante. Uso: ./as03.sh [file]"
    exit 1
fi

numeri=$(leggi_numeri "$1")
if [ $? -ne 0 ]; then exit 1; fi

n=$(conta $numeri)
min=$(minimo $numeri)
max=$(massimo $numeri)
med=$(media $numeri)

riepilogo_finale="File: $1 | Valori: $n | Min: $min | Max: $max | Media: $med"

echo "Valori letti: $n"
echo "Minimo      : $min"
echo "Massimo     : $max"
echo "Media       : $med"
