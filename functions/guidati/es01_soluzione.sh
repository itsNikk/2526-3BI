#!/bin/bash

# es01 — Prima funzione: saluto personalizzato
# Scrivi una funzione saluta() che riceve un nome come parametro
# e stampa "Ciao, [nome]! Benvenuto.". Se il nome e' vuoto
# stampa un errore e restituisce 1.
# Il main chiede il nome con read e chiama la funzione.

function saluta() {
    local nome="$1"
    if [ -z "$nome" ]; then
        echo "Errore: nome vuoto."
        return 1
    fi
    echo "Ciao, $nome! Benvenuto."
    return 0
}

read -p "Nome: " nome
saluta "$nome"
if [ $? -ne 0 ]; then
    echo "Saluto fallito."
    exit 1
fi
