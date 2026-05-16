#!/bin/bash
read -p "Username: " username
read -p "Livello richiesto (1/2/3): " livello
accesso=0
for tentativo in 1 2 3; do
    read -s -p "Password (tentativo $tentativo/3): " password
    echo
    ./controlla_accesso.sh "$username" "$password" $livello
    if [ $? -eq 0 ]; then
        accesso=1
        break
    else
        echo "Credenziali errate."
    fi
done
if [ $accesso -eq 1 ]; then
    echo "Accesso autorizzato. Benvenuto, $username."
    echo "$(date) ACCESSO OK $username livello=$livello" >> accessi.log
else
    echo "Accesso negato dopo 3 tentativi."
    echo "$(date) ACCESSO NEGATO $username" >> accessi.log
    exit 1
fi
