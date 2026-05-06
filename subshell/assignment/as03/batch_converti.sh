#!/bin/bash
if [ -z "$1" ] || [ ! -f "$1" ]; then echo "Errore: file input mancante."; exit 1; fi
ok=0
errori=0
while read riga; do
    v=$(echo "$riga" | cut -d' ' -f1)
    da=$(echo "$riga" | cut -d' ' -f2)
    a=$(echo "$riga" | cut -d' ' -f3)
    risultato=$(./converti.sh $v "$da" "$a")
    if [ $? -eq 0 ]; then
        echo "$v $da = $risultato $a" >> convertiti.txt
        ok=$((ok + 1))
    else
        echo "Errore su riga: $riga" >> errori_conversione.txt
        errori=$((errori + 1))
    fi
done < "$1"
echo "Conversioni riuscite: $ok"
echo "Errori              : $errori"
