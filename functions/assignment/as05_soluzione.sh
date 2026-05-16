#!/bin/bash
# as05 — Analisi testo con funzioni
# Funzioni: conta_parole(), conta_righe(), conta_caratteri(),
#           parola_piu_lunga(), cerca_parola().
# Tutte ricevono il nome del file come argomento e stampano il risultato.
# Il main chiama tutte le funzioni e assembla un report in analisi.txt.
# Trap su SIGTERM salva un report parziale e termina.

report_file="analisi.txt"
file_analizzato=""

function conta_righe() {
    local f="$1"
    if [ ! -f "$f" ]; then echo 0; return 1; fi
    wc -l < "$f"
}

function conta_parole() {
    local f="$1"
    if [ ! -f "$f" ]; then echo 0; return 1; fi
    wc -w < "$f"
}

function conta_caratteri() {
    local f="$1"
    if [ ! -f "$f" ]; then echo 0; return 1; fi
    wc -c < "$f"
}

function parola_piu_lunga() {
    local f="$1"
    if [ ! -f "$f" ]; then return 1; fi
    local max_len=0
    local max_parola=""
    for parola in $(cat "$f"); do
        len=${#parola}
        if [ $len -gt $max_len ]; then
            max_len=$len
            max_parola="$parola"
        fi
    done
    echo "$max_parola ($max_len caratteri)"
}

function cerca_parola() {
    local f="$1"
    local query="$2"
    if [ -z "$query" ] || [ ! -f "$f" ]; then return 1; fi
    local n
    n=$(grep -o "$query" "$f" | wc -l)
    echo "$query: $n occorrenze"
}

function salva_report_parziale() {
    echo "SIGTERM ricevuto. Salvataggio report parziale..."
    echo "Report parziale al $(date)" >> "$report_file"
    exit 0
}

trap salva_report_parziale SIGTERM

if [ -z "$1" ] || [ ! -f "$1" ]; then
    echo "Errore: file da analizzare mancante."
    exit 1
fi

file_analizzato="$1"

righe=$(conta_righe "$file_analizzato")
parole=$(conta_parole "$file_analizzato")
caratteri=$(conta_caratteri "$file_analizzato")
piu_lunga=$(parola_piu_lunga "$file_analizzato")

echo "=== ANALISI: $file_analizzato ===" > "$report_file"
echo "Righe     : $righe" >> "$report_file"
echo "Parole    : $parole" >> "$report_file"
echo "Caratteri : $caratteri" >> "$report_file"
echo "Piu' lunga: $piu_lunga" >> "$report_file"

cat "$report_file"

read -p "Cerca una parola specifica (invio per saltare): " q
if [ -n "$q" ]; then
    cerca_parola "$file_analizzato" "$q" | tee -a "$report_file"
fi
