#!/bin/bash

cd $HOME/Desktop

mkdir -p "$1/$2" "$1/$3"
touch "$1/$2"/{1,2,3}.txt
touch "$1/$3"/{1,2}.txt
cd "$1"
read -p "Quale cartella vuoi visualizzare ($2 o $3)? " dir
ls "$dir"
read -p "Quale file spostare da $2 a $3? " file
mv "$2/$file" "$3/"