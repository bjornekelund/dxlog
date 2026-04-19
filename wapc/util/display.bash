#!/bin/bash
INFILE=../WAPC_db.txt

dos2unix -q $INFILE

gawk 'BEGIN { FS="="; } { if ($2 ~ /^HN$/) { printf("%s => %s\n", $2, $1); } }' $INFILE


exit
