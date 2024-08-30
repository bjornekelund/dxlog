#!/bin/bash
FILE=QSOP_TN-2024-001.txt
OUTFILE=QSOP_TN-2024-002.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | gawk '
BEGIN{
  FS=",";
}
{
  if ($0 ~ /^#/ || $1 !~ /\//) {
    printf("%s\n", $0);
  }
  else {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  } 
}' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
