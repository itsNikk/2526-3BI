#!/bin/bash
if [ -z "$1" ]; then exit 1; fi
if ! [ $1 -eq $1 ] 2>/dev/null; then exit 1; fi
if [ ${#1} -ne 4 ]; then exit 1; fi
if [ $1 -lt 1000 ] || [ $1 -gt 9999 ]; then exit 1; fi
exit 0
