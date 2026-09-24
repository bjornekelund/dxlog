#!/bin/bash
CMD="/mnt/c/Windows/System32/cmd.exe"
if [[ -s $CMD ]]; then
  USER=`/mnt/c/Windows/System32/cmd.exe /c "echo %USERNAME%" | tr -d '\r'`
  TARGET=/mnt/c/Users/$USER/source/repos/k1xm/DXLog.net/DXLog.net/Contest
  if [[ -s $TARGET ]]; then


    CONTESTFILE=BCCQP.txt
    REGEXFILE=BCC-regex.txt

    #echo Updating contest definition in $CONTESTFILE with $REGEXFILE
    cp $TARGET/$CONTESTFILE .
    #sed -i "/# Start machine generated/,/# End machine generated/{ /START/{p; r BCC-regex.txt}; /END/p; d; }" $FILE
    sed -i '/# Start machine generated/,/# End machine generated/{ /# Start machine generated/{p; r '$REGEXFILE'
}; /# End machine generated/p; d; }' $CONTESTFILE
    echo Updated $TARGET/$CONTESTFILE 
    cp $CONTESTFILE $TARGET
  fi
fi

exit
