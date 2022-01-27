#!/bin/bash
INFILE=`ls ARRLDX* | tail -1 2> /dev/null`
echo Using $INFILE
OUTFILE=ARRL_DX_db.txt

dos2unix -q $INFILE

cat $INFILE | tr -d " " | gawk '
BEGIN {
  FS=",";
  prevcall = "";
}
{
  call = $1;
  if (call ~ /^[0-9,A-Z\/]+$/) {
    if (call == prevcall)
      printf("Dupe: \"%s\"\n", $0) > "/dev/stderr"
    else if ($3 ~ /^[A-Z]{2}$/ && $4 == "")
      printf("%s=%s\n", $1, $3);
    else if ($4 ~ /^[0-9KW]+$/)
      printf("%s=%s\n", $1, $4);
    else
      printf("Info missing: \"%s\"\n", $0) > "/dev/stderr"
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignore: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 ARRL DX database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", strftime("%Y-%m-%d"));
}' | sort | sed 's/^\#. /\# /g' > ARRL_DX_db.txt

echo $OUTFILE created
unix2dos -q $OUTFILE
exit
