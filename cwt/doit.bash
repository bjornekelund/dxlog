#/bin/bash
cd $(dirname $0)
FILE=`ls CWOPS_* | tail -1 2> /dev/null`
echo Using file $FILE
if [ -n "$FILE" ]; then
  dos2unix -q $FILE
  ./txt.bash $FILE
  ./xdt.bash $FILE
  ./maxnamelength.bash $FILE
else
  echo No file to process
fi
exit
