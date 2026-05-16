#!/bin/bash
read -p "Numero di studenti: " n
if ! [ $n -eq $n ] 2>/dev/null || [ $n -le 0 ]; then echo "Errore: numero studenti non valido."; exit 1; fi
for i in $(seq 1 $n); do
    read -p "Nome studente $i: " nome
    read -a voti -p "Voti di $nome (separati da spazio): "
    risultato=$(./calcola_media.sh "${voti[@]}")
    if [ $? -ne 0 ]; then
        echo "Errore nei voti di $nome: $risultato"
    else
        media=$(echo "$risultato" | cut -d' ' -f1)
        giudizio=$(echo "$risultato" | cut -d' ' -f2)
        echo "$nome: media=$media ($giudizio)" >> pagella.txt
        echo "Registrato: $nome - $media ($giudizio)"
    fi
done
echo ""
echo "Pagella salvata in pagella.txt"
