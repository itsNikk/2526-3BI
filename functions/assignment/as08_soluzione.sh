#!/bin/bash
# as08 — Sistema di punteggi videogioco
# Funzioni: aggiungi_punteggio() riceve nome e punti e salva in scores.txt,
#           classifica() stampa i primi 5 in ordine decrescente,
#           punteggio_massimo() stampa il record assoluto,
#           media_punteggi() stampa la media di tutti i punteggi,
#           personal_best() riceve un nome e stampa il suo miglior punteggio.
# Trap su EXIT mostra la classifica finale. Trap su SIGINT chiede conferma.

scores_file="scores.txt"

function aggiungi_punteggio() {
    local nome="$1"
    local punti=$2
    if [ -z "$nome" ] || ! [ $punti -eq $punti ] 2>/dev/null || [ $punti -lt 0 ]; then
        echo "Errore: dati non validi."
        return 1
    fi
    echo "$punti $nome" >> "$scores_file"
    echo "Punteggio registrato: $nome — $punti punti"
}

function classifica() {
    if [ ! -f "$scores_file" ]; then 
		echo "Nessun punteggio."; 
		return 0; 
	fi
    echo "< TOP 5 >"
    sort -rn "$scores_file" | head -5
    echo "___ ___ ___ ___ ___"
}

function punteggio_massimo() {
    if [ ! -f "$scores_file" ]; then echo 0; return 0; fi
    sort -rn "$scores_file" | head -1
}

function media_punteggi() {
    if [ ! -f "$scores_file" ]; then echo 0; return 0; fi
    local tot=0
    local count=0
    for p in $(cut -d' ' -f1 "$scores_file"); do
        tot=$((tot + p))
        count=$((count + 1))
    done
    if [ $count -eq 0 ]; then echo 0; return 0; fi
    echo $((tot / count))
}

function personal_best() {
    local nome="$1"
    if [ -z "$nome" ] || [ ! -f "$scores_file" ]; then echo 0; return 0; fi
    grep " $nome$" "$scores_file" | sort -rn | head -1 | cut -d' ' -f1
}

function gestisci_exit() {
    echo ""
    echo "Sessione terminata."
    classifica
}

function gestisci_sigint() {
    echo ""
    read -p "Uscire? (s/n): " r
    if [ "$r" == "s" ]; then exit 0; fi
}

trap gestisci_exit EXIT
trap gestisci_sigint SIGINT

echo "Punteggi — comandi: aggiungi, classifica, record, media, personal, fine"

while true; do
    read -p "> " cmd
    if [ "$cmd" == "fine" ]; then break
    elif [ "$cmd" == "classifica" ]; then classifica
    elif [ "$cmd" == "record" ]; then
        echo "Record: $(punteggio_massimo)"
    elif [ "$cmd" == "media" ]; then
        echo "Media: $(media_punteggi) punti"
    elif [ "$cmd" == "aggiungi" ]; then
        read -p "Nome: " nome
        read -p "Punti: " punti
        aggiungi_punteggio "$nome" $punti
    elif [ "$cmd" == "personal" ]; then
        read -p "Nome: " nome
        echo "Personal best di $nome: $(personal_best "$nome")"
    else
        echo "Comando non riconosciuto."
    fi
done
