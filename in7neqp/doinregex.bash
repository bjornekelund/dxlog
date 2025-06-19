#!/bin/bash
FILE=in-multipliers.txt
OUTFILE=regex-in.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | gawk '
BEGIN {
  FS = " ";
  printf("^(");
}
{
  if ($1 ~ /^[A-Z]{5}$/)
    printf("%s|", $1);
}
END {
  printf(")$");
}' | sed 's/|)/)/g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
