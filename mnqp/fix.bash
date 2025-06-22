#!/bin/bash
FILE=QSOP_MN-2025-001.txt
OUTFILE=QSOP_MN-2025-002.txt

echo Cleaning up $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  num = 0;
  FS = ",";
}
{
  if ($1 !~ /^[A-Z0-9\/]+$/) {
    line[num++] = $0;
  }
  else {
    if (call[$1] == "") {

      if ($2 == "" && ($3 == "" || $3 !~ /^[A-Z]{2,3}$/)) {
        printf("%s is missing data\n", $0) >> "/dev/stderr";
      }
      else {
        call[$1] = $1;
        calline[$1] = $0;
        line[num++] = $0;
      }
    }
    else {
      printf("%s is repeated as %s\n", calline[$1], $0) >> "/dev/stderr";
    }
  }
}
END {
    for (i = 0; i < num; i++) {
        print line[i];
    }
}' $FILE > $OUTFILE

echo "Created" $OUTFILE
unix2dos -q $OUTFILE

exit
