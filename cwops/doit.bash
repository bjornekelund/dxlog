#/bin/bash
cd $(dirname $0)
FILE=`ls CWOPS_* 2> /dev/null`
USED=used-$FILE
#echo FILE=\"$FILE\"
#echo USED=$USED
if [ -n "$FILE" ]; then
  dos2unix $FILE
  ./txt.bash $FILE
  ./xdt.bash $FILE
  mv $FILE $USED
else
  echo Nothing to process
fi
exit
