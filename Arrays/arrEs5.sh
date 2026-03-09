#!/bin/bash

input=(4 5 3 6 3 3 7 2 9)
indexes=()

echo ${input[@]}
read -p "Inserisci elemento da cercare: " c

for index in $(seq 0 $(( ${#input[@]} -1))); do
    if [ ${input[$index]} -eq $c ]; then
        indexes[${#indexes[@]}]=$index
    fi
done

if [ ${#indexes[@]} -eq 0 ]; then
    echo "Nessun elemento matcha con $c"
else
    numOccurrences=${#indexes[@]}
    echo "$c è stato tovato $numOccurrences volte"
    echo "posizioni specifiche ${indexes[@]}"
fi
