#!/bin/bash
FILE=YOTA_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS="="
}
{
  if (lines[$1] != "") {
    printf("Repeated call: \"%s\" and \"%s\"\n", lines[$1], $0) > "/dev/stderr";
  }
  lines[$1] = $0;
}' $FILE

#unix2dos -q $OUTFILE
#echo Created $OUTFILE

exit
