#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Errore: parametri mancanti. Uso: ./es28.sh [comandante] [budget]"
    exit 1
fi

comandante="$1"
budget=$2
logfile="missione_${comandante}.log"

if ! [ $budget -eq $budget ] 2>/dev/null || [ $budget -le 0 ]; then
    echo "Errore: budget non valido."
    exit 1
fi

budget_iniziale=$budget
soglia=$((budget_iniziale * 20 / 100))

read -a fasi -p "Nomi delle fasi della missione (separati da spazio): "

if [ ${#fasi[@]} -eq 0 ]; then
    echo "Errore: nessuna fase inserita."
    exit 1
fi

fase_esaurita=""

for fase in "${fasi[@]}"; do
    read -p "Consumo per la fase '$fase': " consumo
    if ! [ $consumo -eq $consumo ] 2>/dev/null || [ $consumo -le 0 ]; then
        echo "Errore: consumo non valido."
        exit 1
    fi
    budget=$((budget - consumo))
    echo "Fase $fase: -$consumo → budget residuo: $budget"
    echo "Fase $fase: -$consumo → budget residuo: $budget" >> "$logfile"
    if [ $budget -le 0 ]; then
        fase_esaurita="$fase"
        break
    fi
    if [ $budget -lt $soglia ]; then
        echo "AVVISO: budget sotto il 20% del valore iniziale."
    fi
done

echo ""
if [ -n "$fase_esaurita" ]; then
    echo "Budget esaurito durante la fase: $fase_esaurita"
else
    percentuale=$((budget * 100 / budget_iniziale))
    echo "Missione completata. Energia residua: $budget (${percentuale}% del budget iniziale)"
fi
