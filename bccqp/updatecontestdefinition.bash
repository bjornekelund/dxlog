#!/bin/bash
PROFILE=`wslpath "$(wslvar USERPROFILE)"`
FILE=BCCQP.txt
TARGET=$PROFILE/source/repos/k1xm/DXLog.net/DXLog.net/Contest
SOURCE=$TARGET/$FILE

cp $SOURCE .
#sed -i "/# Start machine generated/,/# End machine generated/{ /START/{p; r BCC-regex.txt}; /END/p; d; }" $FILE
sed -i '/# Start machine generated/,/# End machine generated/{ /# Start machine generated/{p; r BCC-regex.txt
}; /# End machine generated/p; d; }' $FILE

echo Source: $FILE Target: $TARGET
cp $FILE $TARGET

exit
