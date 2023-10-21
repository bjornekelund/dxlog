#!/bin/bash

FILE=agb-list.txt
OUTFILE=AGB_db.txt

echo Downloading $FILE

curl -sS http://ev5agb.com/club/agb-list.txt -o $FILE

dos2unix -q $FILE

gawk \
'BEGIN {
  FS=" "
  printf("#00 AGB members database\n");
  printf("#01 Based on http://ev5agb.com/club/agb-list.txt\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 ~ /^[0-9]+$/ && $2 ~ /^[A-Z0-9/]+$/)
    printf("%s=%s\n", $2, $1);
  else if ($0 !~ /^N/ && $0 !~ /-[0-9]/ && $0 !~ /delet/ && $0 != "")
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
}' $FILE | sort | sed 's/#0. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
