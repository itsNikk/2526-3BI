#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro nome missione mancante."
    exit 1
fi

missione="$1"

read -n 1 -t 10 -p "Voto missione da 1 a 5: " voto
echo

if [ -z "$voto" ]; then
    echo "$missione: nessun voto" >> missioni_voti.log
    echo "Nessun voto registrato."
    exit 0
fi

if ! [ $voto -eq $voto ] 2>/dev/null || [ $voto -lt 1 ] || [ $voto -gt 5 ]; then
    echo "Errore: voto non valido."
    exit 1
fi

echo "$missione: $voto stelle" >> missioni_voti.log

if [ $voto -le 2 ]; then
    echo "Missione critica."
elif [ $voto -eq 3 ]; then
    echo "Missione nella norma."
else
    echo "Missione eccellente."
fi
