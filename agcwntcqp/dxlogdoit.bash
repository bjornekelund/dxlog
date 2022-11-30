#!/bin/bash
# Run n1mmdoit first, then this one
#
FILE=`ls AGCW-NTCQP-XXX.txt | tail -1 2> /dev/null`
OUTFILE=AGCWNTPQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | gawk '
BEGIN {
  FS=","
  printf("#0 AGCW-NTC Friendship QSO Party database\n");
  printf("#1 Based on call history data maintained by VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  maxlen = 0;
}
{
  if ($0 ~ /^[A-Z0-9]/) {
    printf("%s=%s;%s;%s\n", $1, $2, $3, $4);
    if (length($2) > maxlen) {
      maxcall = $1;
      maxlen = length($2);
      maxname = $2;
    }
  }
  else if ($0 !~ /^(!|#|$)/) {
    printf("Problem entry: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { 
    printf("Not counting hyphenated names, %s has the longest: \"%s\" (%d)\n", maxcall, maxname, maxlen) > "/dev/stderr";
}' | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
