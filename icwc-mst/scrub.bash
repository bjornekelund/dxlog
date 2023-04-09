#!/bin/bash
FILE=`ls ICWC-* | tail -1 2> /dev/null`
OUTFILE=ICWCMST_db.txt

echo Scrubbing $FILE
dos2unix -q $FILE

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
    # printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    nm = toupper($col)
    if ($1 ~ /^[0-9,A-Z]/ && nm ~ /^[A-Z]+$/) {
#      if (name[$1] != "" && name[$1] != nm)
      if (name[$1] != "")
        printf("\"%s\" reoccurs as \"%s\"\n", line[$1], $0) > "/dev/stderr";
#        printf("%s replaced by %s for %s\n", name[$1], nm, $1) > "/dev/stderr";
      line[$1] = $0;
      call[$1] = $1;
      name[$1] = nm;
    }
    else if ($0 !~ /^(!|#|$)/) {
    if (nm != "")
      printf("Problem exchange: \"%s\"\n", $0) > "/dev/stderr";
    else
      printf("Lacking exchange: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
}' $FILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
