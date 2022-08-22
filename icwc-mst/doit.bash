#!/bin/bash
FILE=`ls ICWC-* | tail -1 2> /dev/null`
OUTFILE=ICWCMST_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 ICWS Medium Speed Test database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
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
END { }' $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
