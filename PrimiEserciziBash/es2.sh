#!/bin/bash

cd $HOME/Desktop

read -p "Gimme directory name, please: " dirName

rm -r $dirName

mkdir $dirName
cd $dirName
touch file1.txt file2.txt file3.txt