#!/bin/bash
OUTFILE=R4C-CUP_db.txt
FILE=rda-cleaned.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 Saratov oblast database.\n");
  printf("#1 Based on database from https://rdaward.org.\n");
  printf("#2 File created on %s.\n", strftime("%Y-%m-%d"));
}
{
  if ($2 ~ /[0-9,A-Z]/ && $3 ~ /SA-[0-9]{2}/) {
    calll = length($2) - 2;
    call = substr(substr($2, 2), 1, calll);
    rda = substr($3,2,2) substr($3,5,2);
#    printf("call=%s rda=%s\n", call, rda) > "/dev/stderr";
    callist[call] = call;
    rdalist[call] = rda;
  }
  else {
#    printf("Ignored: %s\n", $0) > "/dev/stderr";
  }
}
END {
  for (cs in callist) {
    printf("%s=%s\n", callist[cs], rdalist[cs]);
  }
}' $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
