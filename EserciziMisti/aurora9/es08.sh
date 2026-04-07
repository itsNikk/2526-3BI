#!/bin/bash

read -t 5 -p "ALLARME MODULO DELTA - Confermare disattivazione? (s/n): " risposta
echo

if [ -z "$risposta" ]; then
    echo "Timeout - allarme inviato al controllo."
elif [ "$risposta" == "s" ]; then
    echo "Allarme disattivato."
elif [ "$risposta" == "n" ]; then
    echo "Allarme mantenuto attivo."
else
    echo "Risposta non riconosciuta. Allarme mantenuto attivo."
fi
