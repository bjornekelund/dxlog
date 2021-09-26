#!/bin/bash
FILE=`ls RSGBBERU* 2> /dev/null`
if [ -n "$FILE" ]; then
  echo Using $FILE
  dos2unix -q $FILE
  ./txt.bash $FILE
  ./xdt.bash $FILE
fi
exit
