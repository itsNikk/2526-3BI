#!/bin/bash

array=(1 2 3 4 5 6 7 8 9 10)
doubles=()

echo ${array[@]}

for number in ${array[@]}; do
    echo -n "$((number*2)) "
    doubles[${#doubles[@]}]=$((number*2))
done
echo

echo "Results: ${doubles[@]}"
