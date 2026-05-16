#!/bin/bash
if [ -z "$1" ]; then echo "Errore: nome sensore mancante."; exit 1; fi
echo $((RANDOM % 51 - 10))
