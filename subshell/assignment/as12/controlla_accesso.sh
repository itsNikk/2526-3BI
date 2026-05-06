#!/bin/bash
user="$1"
pwd="$2"
livello=$3
if [ -z "$user" ] || [ -z "$pwd" ] || [ -z "$livello" ]; then exit 1; fi
if [ ! -f "utenti.txt" ]; then exit 1; fi
hash_inserito=$(./hash_pwd.sh "$pwd")
while read riga; do
    u=$(echo "$riga" | cut -d' ' -f1)
    h=$(echo "$riga" | cut -d' ' -f2)
    l=$(echo "$riga" | cut -d' ' -f3)
    if [ "$u" == "$user" ] && [ $h -eq $hash_inserito ] && [ $l -ge $livello ]; then
        exit 0
    fi
done < utenti.txt
exit 1
