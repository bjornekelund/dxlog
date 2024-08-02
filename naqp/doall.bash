#!/bin/bash

#!/bin/bash
PROFILE=`wslpath "$(wslvar USERPROFILE)"`
SOURCE=$PROFILE/AppData/Roaming/DXLog.net/Database
TARGET=$PROFILE/source/repos/k1xm/DXLog.net/DXLog.net/Database

FOLDER="`pwd`/derivatives"
#echo $FOLDER
LIST="naqp mdqp mtqp ndqp nhqp njqp"
test -e "$FOLDER" || mkdir $FOLDER
rm -f $FOLDER/*

for contest in $LIST; do
  cd ../$contest
  echo "Doing" $contest
  ./doit.bash &> log.txt
  cp *_db.txt $FOLDER
  cp *_db.txt $TARGET
#  echo $contest
done

exit
