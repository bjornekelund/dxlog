#!/bin/bash
cd $(dirname $0)
FILE=`ls FOC* | tail -1 2> /dev/null`
ech Using file \"$FILE\"
dos2unix $FILE
./txt.bash $FILE
./xdt.bash $FILE
exit
