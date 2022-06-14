#!/bin/bash
FILE1=TESLA_VHF.txt
FILE2=TESLA_db2.txt
TEMP=.yt5m.txt

echo Parsing $FILE1 $FILE2

dos2unix -q $FILE1 $FILE2

cat $FILE2 | sed 's/=/,,/g' > $TEMP

cat $FILE1 $TEMP | gawk '
BEGIN {
  FS=",";
}
{
   call = $1;
   exch = $3;

  if (call ~ /^[0-9,A-Z\/]+$/ && exch ~ /^[A-Z]{2}[0-9]{2}$/) {
    calls[call] = call;
    exchanges[call] = exch;
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr"
}
END { 
  printf("#0 Tesla Memorial database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  for (c in calls) {
    printf("%s=%s\n", c, exchanges[c]);
  }
}' | sort | sed 's/^\#. /\# /g' > TESLA_db.txt

echo "TESLA_db.txt created"
unix2dos -q TESLA_db.txt
exit
