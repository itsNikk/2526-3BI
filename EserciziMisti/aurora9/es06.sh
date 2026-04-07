#!/bin/bash

read -n 4 -p "Inserisci il codice di accesso (4 caratteri): " codice
echo

if [ ${#codice} -ne 4 ]; then
    echo "Errore: il codice deve essere di esattamente 4 caratteri."
    exit 1
fi

if [ "$codice" == "A9X2" ]; then
    echo "Accesso autorizzato."
else
    echo "Accesso negato."
fi
