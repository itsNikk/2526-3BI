#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ]; then exit 1; fi
if ! [ $1 -eq $1 ] 2>/dev/null || ! [ $2 -eq $2 ] 2>/dev/null; then exit 1; fi
if [ $1 -gt $2 ]; then exit 1; fi
exit 0
