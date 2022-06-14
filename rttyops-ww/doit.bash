#!/bin/bash
dos2unix -q $1 $2

OUTFILE=RTTYOPS_WW_db.txt

cat $1 $2 | gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 ~ /(19|20)[0-9]{2}$/) {
    if (year[$1] != $3 && year[$1] != "")
      printf("Replaced %s with %s for %s\n", year[$1], $3, $1) > "/dev/stderr";
    year[$1] = $3;
  }
  else
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
  for (call in year)
    printf("%s=%s\n", call, year[call]);
  printf("#0 Database for SCC RTTY, IG-RY, and RTTYops WW DX contests\n");
  printf("#1 Based on data collected and maintained by Claude VE2FK\n");
  printf("#2 Report errors and changes to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}' | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos $OUTFILE

exit
