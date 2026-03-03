#!/bin/bash

# se esiste il nome...
# -z : sse stringa è vuota

echo "cancelletto: $#"
echo "chiocciola $@"

#Lista: eterogenee, non statiche
possibleNames=("Andrew" "Luke" "XXXX")

#1 echo ${possibleNames[@]}

#2
#for index in $(seq 0 $(( ${#possibleNames[@]}-1))); do
#    echo ${possibleNames[$index]}
#done

#3 ForEach (per ogni elemento.. non per ogni indice)
for elem in ${possibleNames[@]}; do
    echo $elem
done


exit 0

if [ $# -ne 1 ]; then
    echo "Devi inserire il nome."
    exit 1
else
    name=$1
fi

echo "Benvenuto $name"
# -p = prompt
read -p "Inserisci carburante: "  carb
read -p "scafo (%): " scafo
echo -n "Inserisci equipaggio: " 
read equip

read -p "Crediti: " cred
read -p "Ossigeno (ore): " oxy

if [ $carb -lt 0 ] || [ $carb -gt 100 ]; then
    echo "Carburante fuori soglia."
elif [ $scafo -lt 0 ] || [ $scafo -gt 100 ]; then
    echo "Scafo non valido"
fi


echo "Starting travel..."
sleep 2
clear

echo "Nome: $1"
echo "Carb: $carb"
echo "Scafo: $scafo"


intensita=$(( $RANDOM % 10 + 1 ))
echo "Intensità rilevata $intensita/10"
echo

dannoBase=6
if [ $intensita -eq 3 ]; then
    dannoScafo=$dannoBase
    echo "Danno lieve. $dannoScafo"
elif [ $intensita -eq 6 ]; then
    dannoScafo=$(( dannoBase * 2 ))
    echo "Danno medio $dannoScafo"
elif [ $intensita -eq 8 ]; then
    dannoScafo=$(( dannoBase * 3 ))
    echo "DANNONEEE $dannoScafo"
else
    dannoScafo=0
fi

scafo=$(( scafo - dannoScafo ))

if [ $scafo -lt 0 ]; then
    scafo=0
fi

if [ $dannoScafo -eq 0 ]; then
    echo "Danno subito: $dannoScafo"
else
    echo "Danno subito: -$dannoScafo"
fi

echo "Scafo attuale: $scafo%"

if [ $scafo -lt 20 ]; then
    echo "ALLARME. Scafo critico"
else
    echo "Tutto ok. andiamo avanti"
fi

echo


















