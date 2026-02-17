#!/bin/bash

cd $HOME/Desktop

fileName=$1
dirName=$2

rm -r $dirName
mkdir $dirName
touch $dirName/$fileName
echo "-_-_-__-_ Intestazione file -_-_-_-_" > $dirName/$fileName

# .... WHAAAAT?!
cp "$dirName/$fileName" "$dirName/${fileName}_Copia"
rm "$dirName/$fileName"