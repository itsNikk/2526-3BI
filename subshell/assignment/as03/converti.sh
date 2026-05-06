#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then echo "Errore: argomenti mancanti."; exit 1; fi
val=$1
da="$2"
a="$3"
if ! [ $val -eq $val ] 2>/dev/null; then echo "Errore: valore non numerico."; exit 1; fi
if [ "$da" == "km" ] && [ "$a" == "m" ]; then echo $((val * 1000))
elif [ "$da" == "m" ] && [ "$a" == "km" ]; then echo $((val / 1000))
elif [ "$da" == "kg" ] && [ "$a" == "g" ]; then echo $((val * 1000))
elif [ "$da" == "g" ] && [ "$a" == "kg" ]; then echo $((val / 1000))
elif [ "$da" == "min" ] && [ "$a" == "sec" ]; then echo $((val * 60))
elif [ "$da" == "sec" ] && [ "$a" == "min" ]; then echo $((val / 60))
else echo "Errore: conversione non supportata."; exit 1; fi
