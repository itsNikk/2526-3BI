#!/bin/bash

# preso un param da riga di comando
# lo saluta
# se non c'è errore exit 1

if [ -z $1 ]; then
    exit 1
fi

echo "Benvenuto, $1"
