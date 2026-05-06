#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ]; then echo "Errore: due giocatori richiesti."; exit 1; fi
if [ $((RANDOM % 2)) -eq 0 ]; then echo "$1"; else echo "$2"; fi
