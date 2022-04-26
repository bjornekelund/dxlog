#!/bin/bash
FILE1=`ls ../cwt/CWOPS_* | tail -1 2> /dev/null`
FILE2=`ls ../k1usn/K1USNSST-* | tail -1 2> /dev/null`
OUTFILE=ICWCMST_db.txt

echo Parsing files $FILE1 and $FILE2

dos2unix -q $FILE1 $FILE2

gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 ICWS Medium Speed Test  database.\n");
  printf("#1 Derived from K1USN and CWT databases by Claude VE2FK\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "^!!Order!!") {
    if ($2 ~ /Name/) col = 1;
    if ($3 ~ /Name/) col = 2;
    if ($4 ~ /Name/) col = 3;
    if ($5 ~ /Name/) col = 4;
      printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    nm = toupper($col)
    if ($1 ~ /^[0-9,A-Z]/ && nm ~ /^[A-Z ]+$/) {
      if (name[$1] != "" && name[$1] != nm)
        printf("Replacing %s with %s for %s\n", name[$1], nm, $1) > "/dev/stderr";
      call[$1] = $1;
      name[$1] = nm;
    }
    else if ($0 !~ /^(!|#|$)/ && nm != "")
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (cl in call)
    printf("%s=%s\n", cl, name[cl]);
}
END { }' $FILE1 $FILE2 | sort | sed 's/#. /# /g' > $OUTFILE
unix2dos -q $OUTFILE
echo Created $OUTFILE
exit
