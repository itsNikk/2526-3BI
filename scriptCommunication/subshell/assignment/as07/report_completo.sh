#!/bin/bash
for f in vendite.dat costi.dat margini.dat; do
    if [ ! -f "$f" ]; then echo "Errore: file $f non trovato."; exit 1; fi
done
data=$(date)
echo "REPORT AZIENDALE - $data" > report_finale.txt
echo ""                        >> report_finale.txt
for entry in "Vendite vendite.dat" "Costi costi.dat" "Margini margini.dat"; do
    titolo=$(echo "$entry" | cut -d' ' -f1)
    file=$(echo "$entry" | cut -d' ' -f2)
    sezione=$(./genera_sezione.sh "$titolo" "$file")
    if [ $? -ne 0 ]; then echo "Errore nella sezione $titolo."; exit 1; fi
    echo "$sezione" >> report_finale.txt
done
cat report_finale.txt
echo "Report salvato in report_finale.txt"
