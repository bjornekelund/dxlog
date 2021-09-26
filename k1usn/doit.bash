#!/bin/bash
FILE=`ls K1USNSST-* | tail -1 2> /dev/null`

echo Parsing $FILE

if [ -n "$FILE" ]; then
  dos2unix -q $FILE
  ./txt.bash $FILE
  ./maxnamelength.bash $FILE
else
  echo No file to process
fi
exit
