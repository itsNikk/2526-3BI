#!/bin/bash

read -p "Nome responsabile di turno: " responsabile

if [ -z "$responsabile" ]; then
    echo "Errore: nome responsabile non può essere vuoto."
    exit 1
fi

for f in sensori.log eventi.log; do
    if [ ! -f "$f" ]; then
        echo "Errore: file $f non trovato."
        exit 1
    fi
done

data=$(date '+%Y-%m-%d %H:%M:%S')
righe_sensori=$(wc -l < sensori.log)
crit_sensori=$(grep -c "CRIT" sensori.log)
righe_eventi=$(wc -l < eventi.log)
crit_eventi=$(grep -c "CRIT" eventi.log)
totale_crit=$((crit_sensori + crit_eventi))

echo "=== REPORT GIORNALIERO ==="                              > report_giornaliero.txt
echo "Data/ora    : $data"                                    >> report_giornaliero.txt
echo "Responsabile: $responsabile"                            >> report_giornaliero.txt
echo ""                                                       >> report_giornaliero.txt
echo "sensori.log : $righe_sensori righe, $crit_sensori critici" >> report_giornaliero.txt
echo "eventi.log  : $righe_eventi righe, $crit_eventi critici"   >> report_giornaliero.txt
echo ""                                                       >> report_giornaliero.txt
echo "Totale errori critici: $totale_crit"                    >> report_giornaliero.txt
echo "=========================="                             >> report_giornaliero.txt

cat report_giornaliero.txt
