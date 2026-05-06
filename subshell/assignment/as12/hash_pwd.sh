#!/bin/bash
if [ -z "$1" ]; then echo "0"; exit 0; fi
pwd="$1"
somma=0
for i in $(seq 0 $((${#pwd} - 1))); do
    c="${pwd:$i:1}"
    v=$(printf '%d' "'$c")
    somma=$((somma + v))
done
echo $((somma % 997))
