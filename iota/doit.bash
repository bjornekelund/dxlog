#!/bin/bash
FILE=`ls IOTA_2* | tail -1 2> /dev/null`

dos2unix -q $FILE
./txt.bash $FILE
./xdt.bash $FILE

echo Parsed $FILE

exit
