#!/bin/bash
if [ -z "$1" ] || [ ! -d "$1" ]; then echo "0"; exit 0; fi
du -sk "$1" | cut -f1
