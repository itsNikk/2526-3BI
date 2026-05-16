#!/bin/bash

# es08 — Funzioni + trap + file: agenda personale
# Un'agenda testuale con funzioni per aggiungere, cercare e listare contatti.
# La trap su EXIT salva automaticamente, su SIGINT chiede conferma.

agenda_file="agenda.txt"

function aggiungi_contatto() {
    local nome="$1"
    local telefono="$2"
    if [ -z "$nome" ] || [ -z "$telefono" ]; then
        echo "Errore: nome e telefono richiesti."
        return 1
    fi
    if [ ${#nome} -lt 2 ]; then
        echo "Errore: nome troppo corto."
        return 1
    fi
    echo "$nome $telefono" >> "$agenda_file"
    echo "Contatto aggiunto: $nome ($telefono)"
}

function cerca_contatto() {
    local query="$1"
    if [ -z "$query" ]; then
        echo "Errore: termine di ricerca mancante."
        return 1
    fi
    if [ ! -f "$agenda_file" ]; then
        echo "Agenda vuota."
        return 0
    fi
    local risultati
    risultati=$(grep "$query" "$agenda_file")
    if [ -z "$risultati" ]; then
        echo "Nessun contatto trovato per '$query'."
    else
        echo "$risultati"
    fi
}

function lista_contatti() {
    if [ ! -f "$agenda_file" ] || [ ! -s "$agenda_file" ]; then
        echo "Agenda vuota."
        return 0
    fi
    local count
    count=$(wc -l < "$agenda_file")
    echo "=== AGENDA ($count contatti) ==="
    cat "$agenda_file"
    echo "================================"
}

function conta_contatti() {
    if [ ! -f "$agenda_file" ]; then
        echo 0
        return 0
    fi
    wc -l < "$agenda_file"
}

function gestisci_sigint() {
    echo ""
    read -p "Uscire senza salvare? I dati sono gia' su file. (s/n): " risposta
    if [ "$risposta" == "s" ]; then
        exit 0
    fi
}

function gestisci_exit() {
    local tot
    tot=$(conta_contatti)
    echo ""
    echo "Sessione terminata. Contatti in agenda: $tot"
}

trap gestisci_sigint SIGINT
trap gestisci_exit EXIT

echo "Agenda personale — comandi: aggiungi, cerca, lista, fine"

while true; do
    read -p "> " cmd

    if [ "$cmd" == "fine" ]; then
        break
    elif [ "$cmd" == "lista" ]; then
        lista_contatti
    elif [ "$cmd" == "aggiungi" ]; then
        read -p "Nome: " nome
        read -p "Telefono: " tel
        aggiungi_contatto "$nome" "$tel"
    elif [ "$cmd" == "cerca" ]; then
        read -p "Cerca: " query
        cerca_contatto "$query"
    else
        echo "Comando non riconosciuto."
    fi
done
