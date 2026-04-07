#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro nome medico mancante."
    exit 1
fi

medico="$1"
data=$(date '+%Y-%m-%d')
logfile="vitali_$data.log"

read -a nomi -p "Nomi membri equipaggio (separati da spazio): "
read -a freq -p "Frequenze cardiache (separati da spazio): "

if [ ${#nomi[@]} -ne ${#freq[@]} ]; then
    echo "Errore: il numero di nomi e frequenze non coincide."
    exit 1
fi

n=${#nomi[@]}
normali=0
anomalie=0

for i in $(seq 0 $((n - 1))); do
    f=${freq[$i]}
    if ! [ $f -eq $f ] 2>/dev/null || [ $f -le 0 ]; then
        echo "Errore: frequenza non valida per ${nomi[$i]}."
        exit 1
    fi
    if [ $f -lt 60 ]; then
        stato="bradicardia"
        anomalie=$((anomalie + 1))
    elif [ $f -le 100 ]; then
        stato="normale"
        normali=$((normali + 1))
    else
        stato="tachicardia"
        anomalie=$((anomalie + 1))
    fi
    riga="${nomi[$i]}: $f bpm - $stato"
    echo "$riga"
    echo "$riga" >> "$logfile"
done

echo ""
echo "Riepilogo - Medico: $medico"
echo "Normali : $normali"
echo "Anomalie: $anomalie"
