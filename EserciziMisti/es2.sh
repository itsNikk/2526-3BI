#!/bin/bash

if [ -z "$1" ]; then
  echo "Errore: specifica il tipo di missione (breve/lunga)."
  exit 1
fi

tipo="$1"
read -p "Distanza (km): " dist
read -p "Consumo per km: " cons

#Non è necessario farla con un for ma è interessante per scrivere meglio..
# Si può risolvere con degli if...
for v in "$dist" "$cons"; do
  if ! [ "$v" -eq "$v" ] 2>/dev/null || [ "$v" -le 0 ]; then
    echo "Errore: inserire numeri positivi."
    exit 1
  fi
done

carb=$(( dist * cons ))

if [ "$tipo" = "lunga" ]; then
  carb=$(( carb * 120 / 100 ))
fi

echo "Carburante necessario: ${carb} litri"
echo "$tipo ${dist}km -> ${carb} litri" >> log_carburante.txt
