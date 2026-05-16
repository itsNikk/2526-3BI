#!/bin/bash

# es06 — Trap su EXIT e SIGINT
# Scrivi uno script che:
# - definisce una funzione cleanup() che stampa "Pulizia in corso..."
#   e rimuove un file temporaneo temp.txt se esiste
# - definisce una funzione saluta_uscita() che stampa "Arrivederci!"
# - imposta trap su EXIT per chiamare cleanup() e saluta_uscita()
# - imposta trap su SIGINT per stampare un avviso e uscire con exit 1
# - crea temp.txt, chiede all'utente un nome con read e lo saluta

function cleanup() {
    echo "Pulizia in corso..."
    if [ -f "temp.txt" ]; then
        rm temp.txt
        echo "File temporaneo rimosso."
    fi
}

function saluta_uscita() {
    echo "Arrivederci!"
}

function gestisci_sigint() {
    echo ""
    echo "Interruzione rilevata. Uscita forzata."
    exit 1
}

trap 'cleanup; saluta_uscita' EXIT
trap gestisci_sigint SIGINT

echo "avvio" > temp.txt

read -p "Nome: " nome
echo "Ciao, $nome!"
