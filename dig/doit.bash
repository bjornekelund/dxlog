#!/bin/bash
FILE=`ls DIGLI* | tail -1 2> /dev/null`
echo Using $FILE
OUTFILE=DIG_db.txt

dos2unix -q $FILE

cat $FILE | sed 's/\"//g' |
gawk '
BEGIN {
  FS=","
  max = 0;
  printf("#0 DIG members database\n");
  printf("#1 Based on official member roster at https://diplom-interessen-gruppe.info\n");
  printf("#2 File created %s\n", strftime("%Y-%m-%d"));
}
{
  if ($3 ~ /^[0-9]+$/ && $4 ~/^[A-Z0-9]+$/)
    printf("%s=%s\n", $4, $3);
  else
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
}' | sed 's/=0*/=/g' | sed 's/^\#. /\# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo $OUTFILE "created"

exit
