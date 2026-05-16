#!/bin/bash
# as02 — Gestore di una lista della spesa
# Funzioni: aggiungi_prodotto(), rimuovi_prodotto(), lista_prodotti(),
#           calcola_totale(), cerca_prodotto().
# Il file spesa.txt ha il formato "[prodotto] [prezzo_centesimi]".
# calcola_totale() cattura i prezzi con $() e li somma.
# Trap su EXIT stampa il totale finale. Trap su SIGINT chiede conferma.

spesa_file="spesa.txt"

function aggiungi_prodotto() {
    local nome="$1"
    local prezzo=$2
    if [ -z "$nome" ] || ! [ $prezzo -eq $prezzo ] 2>/dev/null || [ $prezzo -le 0 ]; then
        echo "Errore: nome o prezzo non validi."
        return 1
    fi
    echo "$nome $prezzo" >> "$spesa_file"
    echo "Aggiunto: $nome (${prezzo}cent)"
}

function rimuovi_prodotto() {
    local nome="$1"
    if [ -z "$nome" ] || [ ! -f "$spesa_file" ]; then
        echo "Errore: prodotto o file mancante."
        return 1
    fi
    local tmp="spesa_tmp.txt"
    grep -v "^$nome " "$spesa_file" > "$tmp"
    mv "$tmp" "$spesa_file"
    echo "Rimosso: $nome"
}

function lista_prodotti() {
    if [ ! -f "$spesa_file" ] || [ ! -s "$spesa_file" ]; then
        echo "Lista vuota."
        return 0
    fi
    echo "=== LISTA SPESA ==="
    cat "$spesa_file"
    echo "==================="
}

function calcola_totale() {
    if [ ! -f "$spesa_file" ]; then 
		echo 0; 
		return 0; 
	fi
    local tot=0
    for p in $(cut -d' ' -f2 "$spesa_file"); do
        tot=$((tot + p))
    done
    echo $tot
}

function cerca_prodotto() {
    local query="$1"
    if [ -z "$query" ]; then return 1; fi
    risultati=$(grep "$query" "$spesa_file" 2>/dev/null)
    if [ -z "$risultati" ]; then echo "Non trovato."; else echo "$risultati"; fi
}

function gestisci_exit() {
    local tot
    tot=$(calcola_totale)
    echo ""
    echo "Totale spesa: ${tot} centesimi"
}

function gestisci_sigint() {
    echo ""
    read -p "Uscire? (s/n): " r
    if [ "$r" == "s" ]; then exit 0; fi
}

trap gestisci_exit EXIT
trap gestisci_sigint SIGINT

echo "Lista spesa — comandi: aggiungi, rimuovi, lista, cerca, totale, fine"

while true; do
    read -p "> " cmd
    if [ "$cmd" == "fine" ]; then break
    elif [ "$cmd" == "lista" ]; then lista_prodotti
    elif [ "$cmd" == "totale" ]; then
        t=$(calcola_totale); echo "Totale: ${t}cent"
    elif [ "$cmd" == "aggiungi" ]; then
        read -p "Prodotto: " nome
        read -p "Prezzo (centesimi): " prezzo
        aggiungi_prodotto "$nome" $prezzo
    elif [ "$cmd" == "rimuovi" ]; then
        read -p "Prodotto da rimuovere: " nome
        rimuovi_prodotto "$nome"
    elif [ "$cmd" == "cerca" ]; then
        read -p "Cerca: " q
        cerca_prodotto "$q"
    else
        echo "Comando non riconosciuto."
    fi
done
