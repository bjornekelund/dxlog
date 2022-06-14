#!/bin/bash
FILE1=`ls ../cwt/CWOPS_* | tail -1 2> /dev/null`
FILE2=`ls ../k1usn/K1USNSST-* | tail -1 2> /dev/null`
OUTFILE=diff.txt

echo Parsing files $FILE1 and $FILE2

dos2unix -q $FILE1 $FILE2

gawk '
BEGIN {
  FS=","
  col = 2;
}
{
  if ($0 ~ "^!!Order!!") {
    if ($2 ~ /Name/) col = 1;
    if ($3 ~ /Name/) col = 2;
    if ($4 ~ /Name/) col = 3;
    if ($5 ~ /Name/) col = 4;
#    printf("%s --> col=%d\n", $0, col);
  } else {
    nm = $col;
    if ($1 ~ /^[0-9,A-Z]/ && nm ~ /^[A-Za-z ]+$/) {
      if (name[$1] != "" && toupper(name[$1]) != toupper(nm))
        printf("Diff: Call: %-8s CWT: %-8s K1USN: %-8s\n", $1, name[$1], nm);
      call[$1] = $1;
      name[$1] = nm;
    }
    else if ($0 !~ /^(!|#|$)/ && nm != "")
      printf("Invalid exchange: \"%s\"\n", $0);
  }
}
END {
}
END { }' $FILE1 $FILE2 | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
