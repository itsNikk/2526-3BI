#!/bin/bash

read -p "Pattern: " p
read -p "File: " f
grep "$p" "$f"