#!/bin/bash
if [ -z "$1" ]; then echo "Errore: nome modulo mancante."; exit 1; fi

depfile="${1}.dep"

if [ ! -f "$depfile" ]; 
then 
	echo "nessuna"; 
else 
	cat "$depfile"; 
fi
