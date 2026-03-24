#!/bin/bash

read -p "Gimme a 4 char code: " -n 4 code
echo

if [ ${#code} -ne 4 ]; then
    echo "Errore: deve avere esattamente 4 caratteri."
    exit 1
fi

if [ $code == "A9X2" ]; then
    echo "Accesso autorizzato."
else
    echo "Accesso negato."
fi

