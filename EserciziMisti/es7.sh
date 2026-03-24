#!/bin/bash

if [ -z $1 ]; then
  echo "Errore: nome sistema mancante."
  exit 1
fi

sistema=$1
read -s -p "Password per $sistema: " pass1
echo
read -s -p "Conferma password: " pass2
echo

if [ -z "$pass1" ]; then
  echo "Errore: password vuota."
  exit 1
fi

if [ $pass1 == $pass2 ]; then
  echo "Password impostata correttamente."
  echo "$sistema: password impostata" >> passwords.log
else
  echo "Errore: le password non coincidono."
  exit 1
fi
