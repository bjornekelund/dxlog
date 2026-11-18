#!/bin/bash

# Move to correct folder to allow execution from cron
[ -d "/home/sm7iun/dxlog" ] && cd /home/sm7iun/dxlog

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
