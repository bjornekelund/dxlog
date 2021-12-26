#!/bin/bash
FILE=`ls NTC_QP* | tail -1 2> /dev/null`
OUTFILE=NTC_db.txt

dos2unix -q $FILE
echo "Parsing" $FILE
cat $FILE | gawk '
BEGIN {
  FS=",";
  maxlen = 0;
  maxname = "";
}
{
  if ($1 ~ /^[A-Z0-9]+$/ && $2 ~ /^[a-zA-Z]+$/ && $3 ~ /^([0-9]+|NM)$/) {
    printf("%s=%s;%s\n", $1, $2, $3);
    if (length($2) > maxlen) {
      maxlen = length($2);
      maxname = $2;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("Longest name is \"%s\" which is %d characters long.\n", maxname, maxlen) > "/dev/stderr";
  printf("#0 NTC QP database\n");
  printf("#1 Based on data collected and maintained by Claude VE2FK\n");
  printf("#2 Send updates/corrections to ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
}' < $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo $OUTFILE "created"
unix2dos -q $OUTFILE
exit
