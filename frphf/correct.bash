#!/bin/bash
FILE=FRPHF.txt
OUTFILE=FRPHF-001.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | gawk '
BEGIN{ FS=","; }
{
  if (($1 ~ /^[PZ]/ && $3 ~ /^(AC|AL|AP|AM|BA|CE|DF|ES|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RJ|RN|RS|RO|RR|SC|SP|SE|TO|QRP|YL|HQ|FRP)$/) || ($1 ~ /^(!|#)/))
    printf("%s\n", $0);
}
END{}' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
