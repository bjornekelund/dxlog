#!/bin/bash
CMD=
if [[ -s $TARGET ]]; then

USER=`/mnt/c/Windows/System32/cmd.exe /c "echo %USERNAME%" | tr -d '\r'`
TARGET=/mnt/c/Users/$USER/source/repos/k1xm/DXLog.net/DXLog.net/Database
SOURCE=$1
if [[ -s $TARGET ]]; then
  cp $SOURCE $TARGET
  echo Updated $TARGET/$SOURCE
fi

exit
