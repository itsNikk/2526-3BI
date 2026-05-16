#!/bin/bash
# as01 — Calcolatrice con funzioni

function valida_interi() {
    local a=$1
    local b=$2
    if ! [ $a -eq $a ] 2>/dev/null || ! [ $b -eq $b ] 2>/dev/null; then
        return 1
    fi
    return 0
}

function somma() {
    local a=$1 
	local b=$2
    valida_interi $a $b
    if [ $? -ne 0 ]; then echo "Errore: valori non interi."; return 1; fi
    echo $((a + b))
}

function sottrai() {
    local a=$1 
	local b=$2
    valida_interi $a $b
    if [ $? -ne 0 ]; then echo "Errore: valori non interi."; return 1; fi
    echo $((a - b))
}

function moltiplica() {
    local a=$1 
	local b=$2
    valida_interi $a $b
    if [ $? -ne 0 ]; then echo "Errore: valori non interi."; return 1; fi
    echo $((a * b))
}

function dividi() {
    local a=$1 
	local b=$2
    valida_interi $a $b
    if [ $? -ne 0 ]; then echo "Errore: valori non interi."; return 1; fi
    if [ $b -eq 0 ]; then
        echo "Errore: divisione per zero."
        return 1
    fi
    echo $((a / b))
}

function gestisci_sigint() {
    echo ""
    read -p "Uscire dalla calcolatrice? (s/n): " r
    if [ "$r" == "s" ]; then 
		exit 0; 
	fi
}

trap gestisci_sigint SIGINT

echo "Calcolatrice — scegli operazione: +, -, *, /, fine"

while true; do
    read -p "Operazione: " op
    if [ "$op" == "fine" ]; then 
		break; 
	fi
    read -p "Primo numero : " a
    read -p "Secondo numero: " b

    if [ "$op" == "+" ]; then
        r=$(somma $a $b)
    elif [ "$op" == "-" ]; then
        r=$(sottrai $a $b)
    elif [ "$op" == "*" ]; then
        r=$(moltiplica $a $b)
    elif [ "$op" == "/" ]; then
        r=$(dividi $a $b)
    else
        echo "Operazione non valida."
        continue
    fi

    if [ $? -eq 0 ]; then
        echo "Risultato: $r"
    else
        echo "$r"
    fi
done
