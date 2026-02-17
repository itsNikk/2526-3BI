#!/bin/bash

read -p "Parola: " p
read -p "File: " f

grep -o $p $f | wc -l
