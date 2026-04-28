#!/bin/bash

# preso $1, genera un numero casuale tra 0 e $1

echo $(($RANDOM % $1))
