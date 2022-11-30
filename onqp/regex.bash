#!/bin/bash
FILE=multipliers.txt
OUTFILE=multipliers-regex.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | gawk '
BEGIN {
  FS = "=";
  printf("^(");
}
{
  if ($1 ~ /^[A-Z]{1,2}$/)
    printf("%s|", $1);
}
END {
  printf(")$");
}' | sed 's/|)/)/g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
