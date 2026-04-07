#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro file mancante."
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Errore: file non trovato."
    exit 1
fi

arr=()

while read val; do
    if ! [ $val -eq $val ] 2>/dev/null; then
        echo "Errore: valore non intero: $val"
        exit 1
    fi
    arr[${#arr[@]}]=$val
done < "$1"

read -p "Soglia di filtro: " soglia

if ! [ $soglia -eq $soglia ] 2>/dev/null; then
    echo "Errore: soglia non numerica."
    exit 1
fi

n=${#arr[@]}

for i in $(seq 0 $((n - 1))); do
    if [ ${arr[$i]} -gt $soglia ]; then
        echo "  [$i] ${arr[$i]}"
    fi
done

read -n 1 -p "Salvare i risultati filtrati in filtrati.txt? (s/n): " risposta
echo

if [ "$risposta" == "s" ]; then
    for i in $(seq 0 $((n - 1))); do
        if [ ${arr[$i]} -gt $soglia ]; then
            echo ${arr[$i]} >> filtrati.txt
        fi
    done
    tot=$(wc -l < filtrati.txt)
    echo "Salvato. Totale righe in filtrati.txt: $tot"
elif [ "$risposta" == "n" ]; then
    echo "Nessun salvataggio effettuato."
else
    echo "Errore: risposta non valida."
    exit 1
fi
