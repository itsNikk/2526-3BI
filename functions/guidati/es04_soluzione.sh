#!/bin/bash

# es04 — Funzione di validazione con return
# Scrivi una funzione valida_voto() che riceve un numero
# e restituisce 0 se e' un voto valido (intero tra 1 e 10),
# 1 altrimenti. Non stampa nulla.
# Scrivi una funzione giudizio() che riceve un voto valido
# e stampa il giudizio corrispondente.
# Il main chiede un voto, lo valida, e se valido stampa il giudizio.

function valida_voto() {
    local v=$1
    if ! [ $v -eq $v ] 2>/dev/null; then 
		return 1; 
	fi
    if [ $v -lt 1 ] || [ $v -gt 10 ]; then 
		return 1; 
	fi
    return 0
}

function giudizio() {
    local v=$1
    if [ $v -le 4 ]; then
        echo "gravemente insufficiente"
    elif [ $v -le 5 ]; then
        echo "insufficiente"
    elif [ $v -eq 6 ]; then
        echo "sufficiente"
    elif [ $v -eq 7 ]; then
        echo "discreto"
    elif [ $v -eq 8 ]; then
        echo "buono"
    elif [ $v -eq 9 ]; then
        echo "ottimo"
    else
        echo "eccellente"
    fi
}

read -p "Voto: " voto

valida_voto $voto
if [ $? -ne 0 ]; then
    echo "Errore: voto non valido (1-10)."
    exit 1
fi

g=$(giudizio $voto)
echo "Voto $voto: $g"
