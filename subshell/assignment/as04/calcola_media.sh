#!/bin/bash
if [ $# -eq 0 ]; then echo "Errore: nessun voto fornito."; exit 1; fi
somma=0
count=0
for v in "$@"; do
    if ! [ $v -eq $v ] 2>/dev/null || [ $v -lt 1 ] || [ $v -gt 10 ]; then
        echo "Errore: voto non valido: $v"; exit 1
    fi
    somma=$((somma + v))
    count=$((count + 1))
done
media=$((somma / count))
if [ $media -lt 6 ]; then giudizio="insufficiente"
elif [ $media -eq 6 ]; then giudizio="sufficiente"
elif [ $media -eq 7 ]; then giudizio="discreto"
elif [ $media -eq 8 ]; then giudizio="buono"
else giudizio="ottimo"; fi
echo "$media $giudizio"
