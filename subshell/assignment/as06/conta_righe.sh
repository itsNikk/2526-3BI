#!/bin/bash
if [ -z "$1" ] || [ ! -f "$1" ]; then echo "0"; exit 0; fi
wc -l < "$1"
