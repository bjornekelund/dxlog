#!/bin/bash

echo ------------+------------------

echo "Job started" `date -u "+%F %T"` UTC
START=$SECONDS

./alln1mm.sh
./allsch.sh
./downloads.sh
./uploadxdt.sh

echo ------------+------------------

echo "Job ended" `date -u "+%F %T"`" UTC and took $((SECONDS-START)) seconds"

exit 0
