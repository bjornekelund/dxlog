#!/bin/bash
FILE=`ls AGCW-NTC* | tail -1 2> /dev/null`
OUTFILE=AGCWNTPQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

tr 
gawk '
BEGIN {
  FS=","
  printf("#0 AGCW/NTC QSO Party database\n");
  printf("#1 Based on call history data maintained by VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  callok = $1 ~ /^[0-9,A-Z,\/]+$/;
  nameok = $2 ~ /^[A-Za-z\-]+$/
  firstok = $3 ~ /^(AGCW[1-9][0-9]{0,3}|NTC[1-9][0-9]{0,3}$|NM)$/;
  secondok = $4 ~ /^(AGCW[1-9][0-9]{0,3}|NTC[1-9][0-9]{0,3}$|)$/;

  if (callok && nameok && firstok && secondok)
    printf("%s=%s;%s\n", $1, $3, $4);
  else if ($0 !~ /^(!|#|$)/)
    printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
}
END { }' $FILE | sort | uniq | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
