#!/bin/bash
FILE=`ls K1USNSST-* | tail -1 2> /dev/null`
OUTFILE=K1USN_SST_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  maxlen = 0;
  maxname = "";
}
{
  if ($1 ~ /^[0-9A-Z]/ && $2 != "") {
    ID = $3;
    if ($1 !~ /^(A[A-L]|K|N|W|C[F-K]|V[A-G]VX|VY9|X[LM]|C[F-Z]|V[A-Y]|X[J-O])/) {
      if (ID != "DX") {
        printf("Exchange should be DX: \"%s\"\n", $0) > "/dev/stderr";
      }
      ID = "DX";
    }
    if ((ID == "" && $2 == "") || ID !~ /[A-Z]{2}|/)
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    else {
      printf("%s=%s;%s\n", toupper($1), toupper($2), ID);
      if (length($2) > maxlen) {
        maxlen = length($2);
        maxname = $2;
      }
    }
  }
}
END {
  printf("#0 K1USN Slow Speed Test participants database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  printf("Longest name is \"%s\" (%d)\n", maxname, maxlen) > "/dev/stderr";
}' $FILE | sort | sed 's/^\#. /\# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
