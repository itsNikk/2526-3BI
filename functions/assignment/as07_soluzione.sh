#!/bin/bash
# as07 — Gestore di turni di lavoro
# Funzioni: aggiungi_turno() riceve nome e ore e aggiorna turni.txt,
#           calcola_ore_totali() legge turni.txt e stampa il totale ore,
#           ore_per_persona() riceve un nome e stampa le sue ore totali,
#           turno_piu_lungo() stampa chi ha lavorato piu' ore.
# Trap su EXIT stampa le statistiche finali. Trap su SIGTERM salva e termina.

turni_file="turni.txt"

function aggiungi_turno() {
    local nome="$1"
    local ore=$2
    if [ -z "$nome" ] || ! [ $ore -eq $ore ] 2>/dev/null || [ $ore -le 0 ] || [ $ore -gt 24 ]; then
        echo "Errore: dati turno non validi."
        return 1
    fi
    echo "$nome $ore" >> "$turni_file"
    echo "Turno registrato: $nome — ${ore}h"
}

function calcola_ore_totali() {
    if [ ! -f "$turni_file" ]; then echo 0; return 0; fi
    local tot=0
    for ore in $(cut -d' ' -f2 "$turni_file"); do
        tot=$((tot + ore))
    done
    echo $tot
}

function ore_per_persona() {
    local nome="$1"
    if [ -z "$nome" ] || [ ! -f "$turni_file" ]; then echo 0; return 0; fi
    local tot=0
    while read riga; do
        n=$(echo "$riga" | cut -d' ' -f1)
        o=$(echo "$riga" | cut -d' ' -f2)
        if [ "$n" == "$nome" ]; then
            tot=$((tot + o))
        fi
    done < "$turni_file"
    echo $tot
}

function turno_piu_lungo() {
    if [ ! -f "$turni_file" ]; then echo "Nessun turno registrato."; return 0; fi
    local max_ore=0
    local max_nome=""
    while read riga; do
        n=$(echo "$riga" | cut -d' ' -f1)
        o=$(echo "$riga" | cut -d' ' -f2)
        if [ $o -gt $max_ore ]; then
            max_ore=$o
            max_nome="$n"
        fi
    done < "$turni_file"
    echo "$max_nome ($max_ore ore)"
}

function gestisci_exit() {
    echo ""
    local tot
    tot=$(calcola_ore_totali)
    echo "=== STATISTICHE FINALI ==="
    echo "Ore totali lavorate: $tot"
    echo "Turno piu' lungo   : $(turno_piu_lungo)"
    echo "=========================="
}

function gestisci_sigterm() {
    echo "SIGTERM ricevuto. Salvataggio e uscita."
    exit 0
}

trap gestisci_exit EXIT
trap gestisci_sigterm SIGTERM

echo "Gestione turni — comandi: aggiungi, totale, persona, massimo, fine"

while true; do
    read -p "> " cmd
    if [ "$cmd" == "fine" ]; then break
    elif [ "$cmd" == "totale" ]; then
        echo "Ore totali: $(calcola_ore_totali)"
    elif [ "$cmd" == "massimo" ]; then
        echo "Turno piu' lungo: $(turno_piu_lungo)"
    elif [ "$cmd" == "aggiungi" ]; then
        read -p "Nome: " nome
        read -p "Ore: " ore
        aggiungi_turno "$nome" $ore
    elif [ "$cmd" == "persona" ]; then
        read -p "Nome: " nome
        echo "Ore di $nome: $(ore_per_persona "$nome")"
    else
        echo "Comando non riconosciuto."
    fi
done
