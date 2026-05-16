#!/bin/bash
# as06 — Gioco indovina il numero
# Funzioni: genera_numero() stampa un numero casuale tra 1 e 100,
#           valida_tentativo() riceve tentativo e segreto, stampa
#           "troppo alto", "troppo basso" o "esatto" e restituisce
#           0 se esatto, 1 altrimenti.
#           aggiorna_record() riceve il numero di tentativi e aggiorna
#           record.txt se e' un nuovo record.
# Trap su EXIT stampa il risultato finale. Trap su SIGINT abbandona la partita.

record_file="record.txt"
partita_in_corso=1
tentativi=0
segreto=0

function genera_numero() {
    echo $((RANDOM % 100 + 1))
}

function valida_tentativo() {
    local tentativo=$1
    local segreto=$2
    if ! [ $tentativo -eq $tentativo ] 2>/dev/null; then
        echo "Inserisci un numero valido."
        return 1
    fi
    if [ $tentativo -lt $segreto ]; then
        echo "Troppo basso!"
        return 1
    elif [ $tentativo -gt $segreto ]; then
        echo "Troppo alto!"
        return 1
    else
        echo "Esatto!"
        return 0
    fi
}

function aggiorna_record() {
    local tent=$1
    if [ ! -f "$record_file" ]; then
        echo $tent > "$record_file"
        echo "Nuovo record: $tent tentativi!"
        return 0
    fi
    local attuale
    attuale=$(cat "$record_file")
    if [ $tent -lt $attuale ]; then
        echo $tent > "$record_file"
        echo "Nuovo record! Prima: $attuale, ora: $tent tentativi."
    else
        echo "Record attuale: $attuale tentativi. Il tuo: $tent."
    fi
}

function gestisci_exit() {
    echo ""
    if [ $partita_in_corso -eq 1 ]; then
        echo "Partita abbandonata. Il numero era: $segreto"
    fi
}

function gestisci_sigint() {
    echo ""
    echo "Hai abbandonato la partita."
    partita_in_corso=0
    exit 0
}

trap gestisci_exit EXIT
trap gestisci_sigint SIGINT

segreto=$(genera_numero)
echo "Ho pensato un numero tra 1 e 100. Indovina!"

while true; do
    read -p "Tentativo $((tentativi + 1)): " tentativo
    tentativi=$((tentativi + 1))

    valida_tentativo $tentativo $segreto
    if [ $? -eq 0 ]; then
        partita_in_corso=0
        echo "Trovato in $tentativi tentativi!"
        aggiorna_record $tentativi
        break
    fi
done
