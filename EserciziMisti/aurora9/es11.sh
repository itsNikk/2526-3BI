#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro nome modulo mancante."
    exit 1
fi

modulo="$1"

read -a equipaggio -p "Nomi membri equipaggio (separati da spazio): "

if [ ${#equipaggio[@]} -eq 0 ]; then
    echo "Errore: nessun membro inserito."
    exit 1
fi

n=${#equipaggio[@]}
echo "Modulo $modulo - $n membri:"

for i in $(seq 0 $((n - 1))); do
    echo "  $((i + 1)). ${equipaggio[$i]}"
done

riga="$modulo: $n membri"
for i in $(seq 0 $((n - 1))); do
    riga="$riga ${equipaggio[$i]}"
done
echo "$riga" >> equipaggio.log
