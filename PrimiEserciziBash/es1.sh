#!/bin/bash

#Ovunque si lancerà lo script, la prima cosa che farò è spostarmi sul desktop
# $HOME=tilde
cd $HOME/Desktop

#Perchè?
rm -r Progetto

mkdir Progetto
cd Progetto
mkdir Documenti 
mkdir Immagini
cd Documenti
touch lista.txt
cd ..