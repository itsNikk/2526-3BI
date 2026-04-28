#!/bin/bash

# presa una list di nomi, li saluta
#da dove prendo la lista?
#1) read -a 
#2) l.sh n1 n2 n3 n4 ----------

read -p "Nomi: " -a names
# $@
# for x in ...
# for a là C...

#$() Command SUbstitution - esegui uno script, salva valore
n=$(./rndNumberGen.sh 10)



for ((i=0;i<${#names[@]};i++)); do
    ./greet.sh ${names[$i]}
done




