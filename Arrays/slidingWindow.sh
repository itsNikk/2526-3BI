#!/bin/bash

arr=(1 2 3 4 5 6 7 8 9)

#X
if [ $1 -le 1 ]; then
    echo "Inserire un numero > 1"
    exit 1
fi

if [ $(( ${#arr[@]} % $winSize )) -ne 0 ]; then
    echo "Can't create windows of 2 in array of this length"
    exit 1
fi

winSize=$1

echo ${arr[@]}

for elem in $(seq 0 $winSize $((${#arr[@]} -1 )) ); do
    partialSum=0
    for step in $(seq 0 $((winSize-1)) ); do
        position=$(( elem + step ))
        partialSum=$(( partialSum + ${arr[$position]} ))
    done
    echo -n "$partialSum "
done
echo
