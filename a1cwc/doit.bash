#!/bin/bash
FILE=`ls A1AWT* | tail -1 2> /dev/null`
OUTFILE=A1CWC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 A1CLUB Weekly Contest database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
  limit = 10;
  # maxlen = 0;
  # maxname = "";
}
{
  if ($0 ~ "^!!Order!!") {
    if ($2 ~ /Name/) col = 1;
    if ($3 ~ /Name/) col = 2;
    if ($4 ~ /Name/) col = 3;
    if ($5 ~ /Name/) col = 4;
    # printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    nm = toupper($col)
    if ($1 ~ /^[0-9,A-Z]/ && nm ~ /^[A-Z]+$/ && length(nm) <= limit) {
#      if (name[$1] != "" && name[$1] != nm)
      if (name[$1] != "")
        printf("\"%s\" reoccurs as \"%s\"\n", line[$1], $0) > "/dev/stderr";
#        printf("%s replaced by %s for %s\n", name[$1], nm, $1) > "/dev/stderr";
      line[$1] = $0;
      call[$1] = $1;
      name[$1] = nm;
      # if (length(nm) > maxlen) {
      #   maxlen = length(nm);
      #   maxname = nm;
      # }
    }
    else if ($0 !~ /^(!|#|$)/ && nm != "")
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (cl in call) {
    printf("%s=%s\n", cl, name[cl]);
  }
  # printf("Longest name is \"%s\" (%d)\n", maxname, maxlen) > "/dev/stderr";
}' $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
