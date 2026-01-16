#!/bin/bash
FILE=sortedmults.txt
OUTFILE=regex.txt

echo Parsing $FILE
dos2unix -q $FILE

#cat $FILE | sed 's/* //g' |

gawk '
BEGIN {
  FS = "=";
  printf("^(")
}
{
  printf("%s|", $1)
}
END {
  printf(")$")
}' $FILE | sed 's/|)/)/g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
