#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Errore: parametri mancanti. Uso: ./porto5.sh [nave] [file_log]"
    exit 1
fi

nave="$1"
logfile="$2"

if [ ! -f "$logfile" ]; then
    echo "Errore: file $logfile non trovato."
    exit 1
fi

if [ ! -f "operatori.txt" ]; then
    echo "Errore: file operatori.txt non trovato."
    exit 1
fi

read -p "Numero di container a bordo: " container
read -p "Città di destinazione: " destinazione

if ! [ $container -eq $container ] 2>/dev/null || [ $container -le 0 ]; then
    echo "Errore: numero di container non valido."
    exit 1
fi

if [ -z "$destinazione" ]; then
    echo "Errore: la destinazione non può essere vuota."
    exit 1
fi

riga="Nave $nave - $container container - destinazione: $destinazione"
echo "$riga"
echo "$riga" >> arrivi.log

in_porto=0
in_transito=0
partito=0
altro=0

while read riga_log; do
    stato=$(echo "$riga_log" | cut -d' ' -f4)
    if [ "$stato" == "IN_PORTO" ]; then
        in_porto=$((in_porto + 1))
    elif [ "$stato" == "IN_TRANSITO" ]; then
        in_transito=$((in_transito + 1))
    elif [ "$stato" == "PARTITO" ]; then
        partito=$((partito + 1))
    else
        altro=$((altro + 1))
    fi
done < "$logfile"

totale=$((in_porto + in_transito + partito + altro))

echo "=== RIEPILOGO STATI ==="   > riepilogo_stati.txt
echo "IN_PORTO   : $in_porto"    >> riepilogo_stati.txt
echo "IN_TRANSITO: $in_transito" >> riepilogo_stati.txt
echo "PARTITO    : $partito"      >> riepilogo_stati.txt
echo "Altro      : $altro"        >> riepilogo_stati.txt
echo "Totale     : $totale"       >> riepilogo_stati.txt
echo "======================="    >> riepilogo_stati.txt

cat riepilogo_stati.txt

echo ""
echo "=== ACCESSO AL SISTEMA DI CONTROLLO ==="

read -p "Username: " username

if [ -z "$username" ]; then
    echo "Errore: username non può essere vuoto."
    exit 1
fi

accesso=0
ruolo_utente=""

for tentativo in 1 2 3; do
    read -s -p "Password (tentativo $tentativo/3): " password
    echo

    if [ -z "$password" ]; then
        echo "Errore: password non può essere vuota."
        continue
    fi

    trovato=0
    while read riga_op; do
        u=$(echo "$riga_op" | cut -d' ' -f1)
        p=$(echo "$riga_op" | cut -d' ' -f2)
        ruolo=$(echo "$riga_op" | cut -d' ' -f3)
        if [ "$u" == "$username" ] && [ "$p" == "$password" ]; then
            trovato=1
            ruolo_utente=$ruolo
            break
        fi
    done < operatori.txt

    if [ $trovato -eq 1 ]; then
        accesso=1
        break
    else
        data=$(date '+%Y-%m-%d %H:%M:%S')
        echo "$data TENTATIVO FALLITO - username: $username" >> accessi_negati.log
        echo "Credenziali errate."
    fi
done

if [ $accesso -eq 0 ]; then
    echo "Accesso bloccato: troppi tentativi falliti."
    exit 1
fi

data=$(date '+%Y-%m-%d %H:%M:%S')
echo "Accesso autorizzato. Ruolo: $ruolo_utente"
echo "$data ACCESSO OK - username: $username - ruolo: $ruolo_utente" >> accessi.log

read -p "Nome operatore per il report: " operatore

if [ -z "$operatore" ]; then
    echo "Errore: nome operatore non può essere vuoto."
    exit 1
fi

data_report=$(date '+%Y-%m-%d')
ora=$(date '+%Y-%m-%d %H:%M:%S')
host=$(hostname)
utente=$(whoami)

operazioni=$(wc -l < "$logfile")
navi_distinte=$(cut -d' ' -f1 "$logfile" | sort | uniq | wc -l)

peso_totale=0
for p in $(cut -d' ' -f3 "$logfile"); do
    peso_totale=$((peso_totale + p))
done

reportfile="report_$data_report.txt"

echo "=== REPORT UFFICIALE PORTO DI LEVANTE ===" > "$reportfile"
echo "Data/ora    : $ora"                         >> "$reportfile"
echo "Operatore   : $operatore ($ruolo_utente)"   >> "$reportfile"
echo "Macchina    : $host"                        >> "$reportfile"
echo "Utente      : $utente"                      >> "$reportfile"
echo ""                                           >> "$reportfile"
echo "Operazioni totali : $operazioni"            >> "$reportfile"
echo "Navi distinte     : $navi_distinte"         >> "$reportfile"
echo "Peso totale (ton) : $peso_totale"           >> "$reportfile"
echo "========================================="  >> "$reportfile"

cat "$reportfile"
echo ""
echo "Report salvato in: $reportfile"
