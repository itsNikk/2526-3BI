#!/bin/bash
if [ -z "$1" ] || [ ! -f "$1" ]; then exit 1; fi
eta_sec=$(( $(date +%s) - $(date -r "$1" +%s) ))
if [ $eta_sec -le 86400 ]; then exit 0; fi
exit 1
