#!/bin/bash
read -t 5 -p "ALLARME MODULO DELTA — Confermare disattivazione? (s/n): " risposta

# $? restituisce il codice di errore dell'ultimo comando eseguito
if [ $? -ne 0 ]; then
  echo ""
  echo "Timeout — allarme inviato al controllo."
  exit 1
fi

if [ $risposta == "s" ]; then
    echo "Allarme disattivato."
elif [ $risposta == "n" ]; then
    echo "Allarme mantenuto attivo."
else
    echo "Risposta non riconosciuta. Allarme mantenuto attivo."
fi
