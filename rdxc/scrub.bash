#!/bin/bash
FILE=RussianDX.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk -f rdxc.awk $FILE

exit
