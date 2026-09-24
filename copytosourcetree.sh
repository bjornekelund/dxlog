#!/bin/bash
CMD="/mnt/c/Windows/System32/cmd.exe"
if [[ -s $CMD ]]; then
  USER=`$CMD /c "echo %USERNAME%" | tr -d '\r'`
  TARGET=/mnt/c/Users/$USER/source/repos/k1xm/DXLog.net/DXLog.net/Database
  SOURCE=$1
  if [[ -s $TARGET ]]; then
    cp $SOURCE $TARGET
    echo Updated $TARGET/$SOURCE
  fi
fi

exit
