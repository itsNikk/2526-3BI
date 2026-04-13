#!/bin/bash

clear

nomeNave=$1
max=$2

rm -rf tempDir
mkdir tempDir

read -n 3 -t 5 -p "Insert secret: " secret
if [ $? -ne 0 ]; then
echo
echo "Timeout!"
elif [ -n $secret ]; then
echo
echo "$secret"
fi

if [ -z $nomeNave ]; then
	echo "param vuoto."
	exit 1
fi

read -p "Inserisci container a bordo: " nCont
read -p "Inserisci destinazione: " citta

read -p "Inserisci peso singoli container sep.spazio: " -a containers

# -eq = equals
# 2> canale degli errori su monitor (sterr)
if ! [ $nCont -eq $nCont ] 2>/dev/null || [ $nCont -lt 1 ]; then
	echo "Numero container non valido."
	exit 1
fi

# alt+6 = copy
# ctrl + u = PASTE
echo "Nave: $nomeNave - $nCont Container - Destinazione: $citta"
echo "Nave: $nomeNave - $nCont Container - Destinazione: $citta" >> tempDir/arrivi.log


#C'è almeno un peso?
if [ ${#containers} -lt 1 ]; then
	echo "Bisogna inserire almeno un peso "
	exit 1
fi

# for each
sum=0
for peso in ${containers[@]}; do
	# var += valore -> var = var + valore
	#((sum += $peso))
	sum=$((sum + peso))
done

echo "Tutti i pesi: ${containers[@]}"
echo "Peso tot: $sum"

if [ $sum -gt $max ]; then
	echo "Sovraccarico. Diff: $(($sum - $max)) (max: $max)"
fi

