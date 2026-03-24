#!/bin/bash

if [ -z "$1" ]; then
  echo "Errore: nome modulo mancante."
  exit 1
fi

modulo=$1

read -p "Temperatura in Celsius: " c
if ! [ "$c" -eq "$c" ] 2>/dev/null; then
  echo "Errore: valore non numerico."
  exit 1
fi

f=$(( c * 9 / 5 + 32 ))
echo "Modulo $modulo: ${c}°C = ${f}°F"

if [ $c -lt -50 ] || [ $c -gt 80 ]; then
  echo "AVVISO: temperatura anomala nel modulo $modulo!"
fi

#Attenzione al formato...
echo "Modulo $modulo: ${c}°C = ${f}°F" >> temperature.log