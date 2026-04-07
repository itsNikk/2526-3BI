#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro numero astronauti mancante."
    exit 1
fi

n=$1

if ! [ $n -eq $n ] 2>/dev/null || [ $n -le 0 ]; then
    echo "Errore: numero astronauti non valido."
    exit 1
fi

read -a nomi -p "Nomi astronauti (separati da spazio): "
read -a tempi -p "Tempi in secondi (separati da spazio): "

if [ ${#nomi[@]} -ne $n ] || [ ${#tempi[@]} -ne $n ]; then
    echo "Errore: il numero di nomi o tempi non corrisponde a $n."
    exit 1
fi

min_tempo=${tempi[0]}
min_nome=${nomi[0]}

for i in $(seq 0 $((n - 1))); do
    t=${tempi[$i]}
    if ! [ $t -eq $t ] 2>/dev/null || [ $t -le 0 ]; then
        echo "Errore: tempo non valido per '${nomi[$i]}'."
        exit 1
    fi
    if [ $t -lt $min_tempo ]; then
        min_tempo=$t
        min_nome=${nomi[$i]}
    fi
done

echo "Il più veloce è $min_nome con ${min_tempo}s"
echo ""
for i in $(seq 0 $((n - 1))); do
    echo "  ${nomi[$i]}: ${tempi[$i]}s"
done
