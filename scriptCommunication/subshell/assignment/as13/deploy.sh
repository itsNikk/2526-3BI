#!/bin/bash

read -a moduli -p "Moduli da installare (separati da spazio): "
if [ ${#moduli[@]} -eq 0 ]; then echo "Errore: nessun modulo specificato."; exit 1; fi

echo "=== DEPLOYMENT ==="
ok=0
falliti=0

for m in "${moduli[@]}"; do
    ./installa_modulo.sh "$m"
    if [ $? -eq 0 ]; then 
	ok=$((ok + 1))
    else
	echo "Errore nell'installazione di $m."; falliti=$((falliti + 1))
    fi
done
echo ""
echo "Installati: $ok | Falliti: $falliti"
