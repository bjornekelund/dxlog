#!/bin/bash
FILED=disabled.txt
FILEG=grosssupported.txt
FILEDS=dis.txt
FILEGS=gro.txt

FILEM=merge.txt
TEMP=temp.txt

echo Parsing $FILED $FILEG
dos2unix -q $FILED $FILEG

gawk 'BEGIN {FS=","}{printf("%s\n", $1);}' $FILED | sort > $FILEDS
gawk 'BEGIN {FS=","}{printf("%s\n", $5);}' $FILEG | sort > $FILEGS

awk 'NR==FNR { b[$0] = 1; next } !b[$0]' $FILEDS $FILEGS

exit
