#!/bin/bash
nome="$1"
anno=$2
durata=$3
if [ -z "$nome" ] || [ -z "$anno" ] || [ -z "$durata" ]; then exit 1; fi
if [ ${#nome} -lt 3 ]; then exit 1; fi
if ! [ $anno -eq $anno ] 2>/dev/null || [ $anno -lt 2000 ] || [ $anno -gt 2100 ]; then exit 1; fi
if ! [ $durata -eq $durata ] 2>/dev/null || [ $durata -le 0 ]; then exit 1; fi
exit 0
