#!/bin/bash
INFILE=../WAPC_db.txt

echo Checking $INFILE
dos2unix -q $INFILE

gawk -f check.awk $INFILE

echo Done.

exit
