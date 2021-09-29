#!/bin/bash
FILE=`ls RSGBBERU* 2> /dev/null`
if [ -n "$FILE" ]; then
  echo Parsing $FILE...
  dos2unix -q $FILE
  ./txt.bash $FILE
  ./xdt.bash $FILE
else
  echo No input file
fi

exit
