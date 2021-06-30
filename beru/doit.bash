#bin/bash
cd $(dirname $0)
FILE=`ls RSGBBERU* 2> /dev/null`
USED=used-$FILE
#echo FILE=\"$FILE\"
#echo USED=$USED
if [ -n "$FILE" ]; then
#  echo True
  dos2unix $FILE
  ./txt.bash $FILE
  ./xdt.bash $FILE
  mv $FILE $USED
fi
exit
