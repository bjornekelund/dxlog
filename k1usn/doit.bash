#/bin/bash
cd $(dirname $0)
FILE=`ls K1USNSST-* | tail -1 2> /dev/null`
echo Using file $FILE
if [ -n "$FILE" ]; then
  dos2unix -q $FILE
  ./txt.bash $FILE
else
  echo No file to process
fi
exit
