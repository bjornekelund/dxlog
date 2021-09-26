#!/bin/bash
FILE=`ls FOC* | tail -1 2> /dev/null`
echo Parsing $FILE
dos2unix -q $FILE
./txt.bash $FILE
./xdt.bash $FILE
exit
