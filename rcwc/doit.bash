#!/bin/bash
FILE=RCWC.txt
OUTFILE=RCWC_db.txt
dos2unix -q $FILE

echo "Parsing" $FILE "..."

gawk '
BEGIN {
  FS=" "
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 != "") {
    printf("%s=CM%s\n", $1, $2);
  }
  else
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 RCWC member database based on data from http://rcwc.ru\n");
  printf("#2 File updated %s\n", strftime("%Y-%m-%d"));
}' < $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE "created."
unix2dos -q $OUTFILE
exit
