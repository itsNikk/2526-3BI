#!/bin/bash
# as04 — Simulatore conto bancario
# Funzioni: deposita(), preleva(), saldo(), estratto_conto().
# Lo stato e' in variabili globali (saldo_corrente, movimenti[]).
# deposita() e preleva() validano i valori e aggiornano lo stato.
# estratto_conto() stampa tutti i movimenti con data e tipo.
# Trap su EXIT stampa il saldo finale. Trap su SIGINT chiede conferma.

saldo_corrente=0
movimenti=()

function deposita() {
    local importo=$1
    if ! [ $importo -eq $importo ] 2>/dev/null || [ $importo -le 0 ]; then
        echo "Errore: importo non valido."
        return 1
    fi
    saldo_corrente=$((saldo_corrente + importo))
    movimenti[${#movimenti[@]}]="$(date '+%H:%M:%S') DEPOSITO +${importo} -> saldo: $saldo_corrente"
    echo "Depositati ${importo}. Saldo: $saldo_corrente"
}

function preleva() {
    local importo=$1
    if ! [ $importo -eq $importo ] 2>/dev/null || [ $importo -le 0 ]; then
        echo "Errore: importo non valido."
        return 1
    fi
    if [ $importo -gt $saldo_corrente ]; then
        echo "Errore: saldo insufficiente (saldo: $saldo_corrente)."
        return 1
    fi
    saldo_corrente=$((saldo_corrente - importo))
    movimenti[${#movimenti[@]}]="$(date '+%H:%M:%S') PRELIEVO -${importo} -> saldo: $saldo_corrente"
    echo "Prelevati ${importo}. Saldo: $saldo_corrente"
}

function saldo() {
    echo $saldo_corrente
}

function estratto_conto() {
    if [ ${#movimenti[@]} -eq 0 ]; then
        echo "Nessun movimento registrato."
        return 0
    fi
    echo "ESTRATTO CONTO"
    for m in "${movimenti[@]}"; do
        echo "  $m"
    done
    echo "___ ___ ___ ___ ___"
}

function gestisci_exit() {
    echo ""
    echo "Sessione terminata. Saldo finale: $(saldo)"
}

function gestisci_sigint() {
    echo ""
    read -p "Uscire dal conto? (s/n): " r
    if [ "$r" == "s" ]; then exit 0; fi
}

trap gestisci_exit EXIT
trap gestisci_sigint SIGINT

echo "Conto bancario — comandi: deposita, preleva, saldo, estratto, fine"

while true; do
    read -p "> " cmd
    if [ "$cmd" == "fine" ]; then break
    elif [ "$cmd" == "saldo" ]; then
        echo "Saldo attuale: $(saldo)"
    elif [ "$cmd" == "estratto" ]; then
        estratto_conto
    elif [ "$cmd" == "deposita" ]; then
        read -p "Importo: " imp
        deposita $imp
    elif [ "$cmd" == "preleva" ]; then
        read -p "Importo: " imp
        preleva $imp
    else
        echo "Comando non riconosciuto."
    fi
done
