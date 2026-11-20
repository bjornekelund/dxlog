#!/bin/bash
CMD="/mnt/c/Windows/System32/cmd.exe"
if [[ -s $CMD ]]; then
  USER=$(cd /mnt/c && $CMD /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
  TARGET=/mnt/c/Users/$USER/source/repos/k1xm/DXLog.net/DXLog.net/Database
  SOURCE=$1
  if [[ -s $TARGET ]]; then
    cp $SOURCE $TARGET
    echo Updated $TARGET/$SOURCE
  fi
fi

exit 0
