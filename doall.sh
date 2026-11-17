#!/bin/bash

echo ------------+------------------

echo "Job started" `date -u "+%F %T"` UTC
START=$SECONDS

./alln1mm.sh $1
./allsch.sh $1
./downloads.sh $1
./uploadxdt.sh

echo ------------+------------------

echo "Job ended" `date -u "+%F %T"`" UTC and took $((SECONDS-START)) seconds"

exit 0
