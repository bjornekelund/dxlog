#!/bin/bash
FILE=ntc.txt
OUTFILE=NTCQP_db.txt

dos2unix -q $FILE
echo "Parsing" $FILE
gawk '
BEGIN {
  FS=" "
}
{
  if ($1 ~ /^[1-9][0-9]*$/ && $2 ~ /^[A-Z0-9]+$/) {
    printf("%s=%s\n", $2, $1);
  }
  else
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 NTC members database based on data from https://www.qsl.net/ntc/ntc.txt\n");
  printf("#1 File updated %s\n", strftime("%Y-%m-%d"));
}' < $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE "created"
unix2dos -q $OUTFILE
exit
