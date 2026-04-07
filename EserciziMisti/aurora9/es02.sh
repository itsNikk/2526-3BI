#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro tipo missione mancante."
    exit 1
fi

tipo="$1"

read -p "Distanza in km: " distanza
read -p "Consumo per km: " consumo

if ! [ $distanza -eq $distanza ] 2>/dev/null; then
    echo "Errore: distanza non numerica."
    exit 1
fi

if ! [ $consumo -eq $consumo ] 2>/dev/null; then
    echo "Errore: consumo non numerico."
    exit 1
fi

if [ $distanza -le 0 ] || [ $consumo -le 0 ]; then
    echo "Errore: i valori devono essere positivi."
    exit 1
fi

carburante=$((distanza * consumo))

if [ "$tipo" == "lunga" ]; then
    carburante=$((carburante * 120 / 100))
fi

echo "$tipo ${distanza}km → ${carburante}L" >> log_carburante.txt
echo "Carburante necessario: ${carburante}L"
