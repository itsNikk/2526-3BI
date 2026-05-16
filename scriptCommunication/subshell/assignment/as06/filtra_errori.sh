#!/bin/bash
if [ -z "$1" ] || [ ! -f "$1" ]; then echo "Errore: file non trovato."; exit 1; fi
if [ -z "$2" ]; then echo "Errore: livello mancante."; exit 1; fi
grep "^$2" "$1"
