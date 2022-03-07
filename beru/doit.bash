#!/bin/bash
FILE=`ls RSGBBERU* | tail -1`
if [ -n "$FILE" ]; then
  echo Parsing $FILE...
  dos2unix -q $FILE
  ./txt.bash $FILE
  ./xdt.bash $FILE
else
  echo No input file
fi

exit
