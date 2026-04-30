#!/bin/bash

# da read: nome ed età
# dopo, chiamo ageVal.sh e controllo $?

read -p "Name and age: " name age

#subShell
./ageVal.sh $age

if [ $? -eq 1 ]; then
	echo "$name non ha un età valida ($age)"
	exit 1
else
	echo "$name registrato correttamente"
	echo "$name $age" >> registro.txt
fi
