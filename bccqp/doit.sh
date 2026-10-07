#!/bin/bash
URL=https://www.bavarian-contest-club.de/data
WEBFILE=bcc-members.txt
REGEXFILE=BCC-regex.txt
DOWNLOAD=.downloaded

# rm -f $WEBFILE
curl -sS $URL/$WEBFILE -o $DOWNLOAD

dos2unix -q $DOWNLOAD

if cmp $WEBFILE $DOWNLOAD && [ -z "$1" ]; then 
    echo "The latest member file is already downloaded."
    rm $DOWNLOAD
    exit 0
fi

mv $DOWNLOAD $WEBFILE

if [ ! -s $WEBFILE ]; then
  echo "ERROR! Download of $WEBFILE failed. Aborting."
  exit 1
else
  echo Downloaded $WEBFILE, parsing...
  dos2unix -q $WEBFILE

  sed 's/ //g' $WEBFILE | sort | gawk -b -f regex.awk > $REGEXFILE

  echo Created $REGEXFILE
  unix2dos -q $REGEXFILE
fi

CMD="/mnt/c/Windows/System32/cmd.exe"
if [[ -s $CMD ]]; then
  USER=`$CMD /c "echo %USERNAME%" | tr -d '\r'`
  TARGET=/mnt/c/Users/$USER/source/repos/k1xm/DXLog.net/DXLog.net/Contest
  if [[ -s $TARGET ]]; then
    CONTESTFILE=BCCQP.txt
    #echo Updating contest definition in $CONTESTFILE with $REGEXFILE
    cp $TARGET/$CONTESTFILE .
    #sed -i "/# Start machine generated/,/# End machine generated/{ /START/{p; r BCC-regex.txt}; /END/p; d; }" $FILE
    sed -i '/# Start machine generated/,/# End machine generated/{ /# Start machine generated/{p; r '$REGEXFILE'
    }; /# End machine generated/p; d; }' $CONTESTFILE
    echo Updated $TARGET/$CONTESTFILE 
    cp $CONTESTFILE $TARGET
  fi
fi

XDTFILE=bcc-members.xdt

rm -f $XDTFILE
curl -sS https://www.bavarian-contest-club.de/data/$XDTFILE -O

if [ ! -s $XDTFILE ]; then
    echo "ERROR! Download of member roster failed. Aborting."
    exit 1
else
    echo Downloaded $XDTFILE
    iconv -f ISO-8859-1 -t UTF-8 $XDTFILE -o $XDTFILE
    unix2dos -q $XDTFILE
    cp $XDTFILE ../3xdt
    echo Created $XDTFILE
fi

exit

