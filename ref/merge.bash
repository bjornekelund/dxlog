#!/bin/bash
FILE1=REF-F5OIH.txt
FILE2=REFCW-2024.txt

OUTFILE=REFCW-2024-001.txt

echo Parsing $FILE1 and $FILE2
dos2unix -q $FILE1 $FILE2

cat $FILE1 $FILE2 | gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[A-Z0-9\/]+$/ && $2 ~ /^([0-9]{1,2}|2A|2B|F[KYJTWRSOPMGH])$/) {
    if (call[$1] != "" && exchange[$1] != $2) {
      printf("Replaced: \"%s\" \"%s\" with \"%s\" \n", $1, exchange[$1], $2) > "/dev/stderr";
    }
    call[$1] = $1;
    user[$1] = $3;
    exchange[$1] = $2;
  }
  else if ($0 !~ /^(!|#|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("!!Order!!,Call,Exch1,UserText\n");
  printf("#0 REF database\n");
  printf("#1 Based on data collected and maintained by Claude VE2FK and Vince F5OIH\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  for (c in call) {
    printf("%s,%s,%s\n", call[c], exchange[c], user[c]);
  }
}' | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
