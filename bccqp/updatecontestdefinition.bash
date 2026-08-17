#!/bin/bash
PROFILE=`wslpath "$(wslvar USERPROFILE)"`
CONTESTFILE=BCCQP.txt
TARGET=$PROFILE/source/repos/k1xm/DXLog.net/DXLog.net/Contest
REGEXFILE=BCC-regex.txt

#echo Updating contest definition in $CONTESTFILE with $REGEXFILE
cp $TARGET/$CONTESTFILE .
#sed -i "/# Start machine generated/,/# End machine generated/{ /START/{p; r BCC-regex.txt}; /END/p; d; }" $FILE
sed -i '/# Start machine generated/,/# End machine generated/{ /# Start machine generated/{p; r '$REGEXFILE'
}; /# End machine generated/p; d; }' $CONTESTFILE

echo Updated $TARGET/$CONTESTFILE
cp $CONTESTFILE $TARGET

exit
