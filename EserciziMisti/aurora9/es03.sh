#!/bin/bash

if [ -z "$1" ]; then
    echo "Errore: parametro nome modulo mancante."
    exit 1
fi

modulo="$1"

read -p "Temperatura in Celsius: " temp

if ! [ $temp -eq $temp ] 2>/dev/null; then
    echo "Errore: valore non numerico."
    exit 1
fi

fahrenheit=$((temp * 9 / 5 + 32))

if [ $temp -lt -50 ] || [ $temp -gt 80 ]; then
    echo "AVVISO: temperatura anomala rilevata."
fi

echo "Modulo $modulo: ${temp}°C = ${fahrenheit}°F"
echo "Modulo $modulo: ${temp}°C = ${fahrenheit}°F" >> temperature.log
