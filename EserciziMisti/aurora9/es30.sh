#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro livello di sicurezza mancante."
    exit 1
fi

livello=$1

if [ "$livello" != "1" ] && [ "$livello" != "2" ] && [ "$livello" != "3" ]; then
    echo "Errore: livello di sicurezza non valido. Valori ammessi: 1, 2, 3."
    exit 1
fi

if [ ! -f "utenti_autorizzati.txt" ]; then
    echo "Errore: file utenti_autorizzati.txt non trovato."
    exit 1
fi

read -p "ID utente: " id_utente

if [ -z "$id_utente" ]; then
    echo "Errore: ID utente non può essere vuoto."
    exit 1
fi

accesso=0

for tentativo in 1 2 3; do
    read -s -p "Password (tentativo $tentativo/3): " password
    echo

    if [ -z "$password" ]; then
        echo "Errore: password non può essere vuota."
        continue
    fi

    trovato=0
    while read riga; do
        id_file=$(echo "$riga" | cut -d' ' -f1)
        pass_file=$(echo "$riga" | cut -d' ' -f2)
        livello_file=$(echo "$riga" | cut -d' ' -f3)

        if [ "$id_file" == "$id_utente" ] && [ "$pass_file" == "$password" ] && [ "$livello_file" == "$livello" ]; then
            trovato=1
            break
        fi
    done < utenti_autorizzati.txt

    if [ $trovato -eq 1 ]; then
        accesso=1
        break
    else
        data=$(date '+%Y-%m-%d %H:%M:%S')
        echo "$data TENTATIVO FALLITO - ID: $id_utente" >> accessi_negati.log
        echo "Credenziali errate."
    fi
done

if [ $accesso -eq 1 ]; then
    data=$(date '+%Y-%m-%d %H:%M:%S')
    echo "Accesso autorizzato. Livello: $livello"
    echo "$data ACCESSO OK - ID: $id_utente - livello: $livello" >> accessi.log
else
    echo "Accesso bloccato: troppi tentativi falliti."
fi
