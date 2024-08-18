#!/bin/bash
PROFILE=`wslpath "$(wslvar USERPROFILE)"`
TARGET=$PROFILE/source/repos/k1xm/DXLog.net/DXLog.net/Database
SOURCE=$1

echo Source: $SOURCE Target: $TARGET
cp $1 $TARGET

exit
