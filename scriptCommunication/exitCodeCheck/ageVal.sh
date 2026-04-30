#!/bin/bash

# preso un numero da cmdLine, valida [1,120]
#TODO: son sicuro sia un numero? 

# se exit = 0 -> programma andato a buon fine
# se exit != 0 -> programma ha avuto problemi 

if [ $1 -lt 1 ] || [ $1 -gt 120 ]; then
	exit 1
else
	exit 0
fi

