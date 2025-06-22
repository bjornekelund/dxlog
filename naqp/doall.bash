#!/bin/bash
PROFILE=`wslpath "$(wslvar USERPROFILE)"`
SOURCE=$PROFILE/AppData/Roaming/DXLog.net/Database
TARGET=$PROFILE/source/repos/k1xm/DXLog.net/DXLog.net/Database

#echo $FOLDER
LIST="naqp mdqp mtqp"

for contest in $LIST; do
  cd ../$contest
  echo "Doing" $contest "in" `pwd`
  ./doit.bash
  echo ---------------
done

exit
