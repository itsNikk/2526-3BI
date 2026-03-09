#!/bin/bash

input=(4 5 3 6 2 1 7 12 9)

echo ${input[@]}
read -p "Inserisci elemento da cercare: " c

for elem in ${input[@]}; do
    if [ $elem -eq $c ]; then
        echo $elem
        break
    fi
done
