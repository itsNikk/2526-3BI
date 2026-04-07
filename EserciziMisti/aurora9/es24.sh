#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro file mancante."
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Errore: file non trovato."
    exit 1
fi

info=0
warn=0
crit=0
sconosciute=0

while read riga; do
    tipo=$(echo "$riga" | cut -d' ' -f1)
    if [ "$tipo" == "INFO" ]; then
        info=$((info + 1))
    elif [ "$tipo" == "WARN" ]; then
        warn=$((warn + 1))
    elif [ "$tipo" == "CRIT" ]; then
        crit=$((crit + 1))
    else
        sconosciute=$((sconosciute + 1))
    fi
done < "$1"

echo "INFO       : $info"  > report_tipi.txt
echo "WARN       : $warn"  >> report_tipi.txt
echo "CRIT       : $crit"  >> report_tipi.txt
echo "Sconosciute: $sconosciute" >> report_tipi.txt

cat report_tipi.txt
