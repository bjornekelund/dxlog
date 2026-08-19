#!/bin/bash
# Run n1mmdoit first, then this one
#
FILE=`ls AGCW-NTCQP-XXX.txt | tail -1 2> /dev/null`
OUTFILE=AGCWNTPQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | gawk '
BEGIN {
  printf("#00 AGCW-NTC Friendship QSO Party prefill database\n");
  printf("#01 Based on data maintained by VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  maxlen = 0;
}
{
  if ($0 ~ /^[A-Z0-9]/)
  {
    printf("%s=%s;%s;%s\n", $1, $2, $3, $4);
    if (length($2) > maxlen)
    {
      maxcall = $1;
      maxlen = length($2);
      maxname = $2;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Problem entry: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
    printf("Not counting hyphenated names, %s has the longest: \"%s\" (%d)\n", maxcall, maxname, maxlen) > "/dev/stderr";
}' | sort | sed 's/^#0. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
