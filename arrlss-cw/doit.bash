#!/bin/bash
FILE=`ls SSCW* | tail -1 2> /dev/null`

OUTFILE=ARRLSS_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  printf("#0 ARRL CW Sweepstakes database\n");
  printf("#1 Based on data collected and maintained by VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
  col = 2;
}
{
  if ($0 !~ /^(#|!)/) {
    if (call[$1] != "" && (prec[$1] != $2 || lic[$1] != $3 || sect[$1] != $4))
      printf("For %s replace %s;%s with %s;%s\n", $1, lic[$1], sect[$1], $2, $4) > "/dev/stderr";
    call[$1] = $1;
    prec[$1] = "";
    lic[$1] = $3;
    sect[$1] = $4;
  }
}
END {
  for (cs in call)
    printf("%s=%s;%s;%s\n", cs, prec[cs], lic[cs], sect[cs]);
}' $FILE | sort | uniq | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
