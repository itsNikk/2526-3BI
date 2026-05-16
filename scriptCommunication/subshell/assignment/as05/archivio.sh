#!/bin/bash
read -p "Quante missioni vuoi inserire? " n
if ! [ $n -eq $n ] 2>/dev/null || [ $n -le 0 ]; then echo "Errore: numero non valido."; exit 1; fi
valide=0
scartate=0
for i in $(seq 1 $n); do
    echo "--- Missione $i ---"
    read -p "Nome: " nome
    read -p "Anno lancio: " anno
    read -p "Durata (giorni): " durata
    ./valida_missione.sh "$nome" $anno $durata
    if [ $? -eq 0 ]; then
        echo "$nome $anno $durata" >> missioni.txt
        valide=$((valide + 1))
        echo "Registrata."
    else
        echo "Dati non validi, missione scartata."
        scartate=$((scartate + 1))
    fi
done
echo ""
echo "Missioni registrate: $valide"
echo "Missioni scartate  : $scartate"
