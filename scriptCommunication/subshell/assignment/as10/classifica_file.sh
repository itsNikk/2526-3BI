#!/bin/bash
if [ -z "$1" ]; then echo "altro"; exit 0; fi
ext="${1##*.}"
if [ "$ext" == "txt" ] || [ "$ext" == "log" ]; then echo "testo"
elif [ "$ext" == "sh" ]; then echo "script"
elif [ "$ext" == "csv" ] || [ "$ext" == "dat" ]; then echo "dati"
else echo "altro"; fi
