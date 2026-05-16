#!/bin/bash
read -a sensori -p "Nomi dei sensori (separati da spazio): "
if [ ${#sensori[@]} -eq 0 ]; then echo "Errore: nessun sensore inserito."; exit 1; fi
n=${#sensori[@]}
somma=0
min=""
max=""
for i in $(seq 0 $((n - 1))); do
    nome=${sensori[$i]}
    valore=$(./leggi_sensore.sh "$nome")
    if [ $? -ne 0 ]; then echo "Errore lettura sensore $nome."; exit 1; fi
    echo "Sensore $nome: ${valore}grC"
    somma=$((somma + valore))
    if [ -z "$min" ] || [ $valore -lt $min ]; then min=$valore; fi
    if [ -z "$max" ] || [ $valore -gt $max ]; then max=$valore; fi
done
media=$((somma / n))
echo ""
echo "Min: ${min}grC | Max: ${max}grC | Media: ${media}grC"
