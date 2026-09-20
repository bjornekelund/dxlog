#!/bin/bash
USER=`/mnt/c/Windows/System32/cmd.exe /c "echo %USERNAME%" | tr -d '\r'`
TARGET=/mnt/c/Users/$USER/source/repos/k1xm/DXLog.net/DXLog.net/Database
SOURCE=$1

echo Updated $TARGET/$SOURCE
cp $SOURCE $TARGET

exit
