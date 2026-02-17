#!/bin/bash

#range in [0, 32767]
rnd=$RANDOM

echo $rnd
echo $(($rnd % 100))
echo $(( ($rnd % 100) + 1))

if [ $rnd -gt 1000 ]
then
    echo "Il numero è magiore di 1000"
fi

