#!/bin/bash
FILE=`ls AGCW-NTC*txt | tail -1 2> /dev/null`
OUTFILE=AGCWNTPQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

cat $FILE | sed 's/ü/u/g' |  sed 's/é/e/g' | gawk '
BEGIN {
  FS=","
  printf("#0 AGCW-NTC Friendship QSO Party database\n");
  printf("#1 Based on call history data maintained by VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  maxlen = 0;
}
{
  callok = $1 ~ /^[0-9A-Z,\/]+$/;
  nameok = $2 ~ /^[A-Za-z]{2,10}$/;
  hyphenated = $2 ~ /^[A-Za-z]{2,10}\-[A-Za-z]{2,10}$/;
  firstok = $3 ~ /^(AGCW[1-9][0-9]{0,3}|NTC[1-9][0-9]{0,3}$|NM)$/;
  secondok = $4 ~ /^(NTC[1-9][0-9]{0,3}$|)$/;
  lenok = $6 == "";

  if (callok && firstok && secondok && lenok) {
    if (nameok) {
      name = $2;
    }
    else if (hyphenated) {
      p = index($2, "-");
      name = substr($2, 1, p - 1);
      printf("Hyphenated name: \"%s\" --> \"%s\"\n", $2, name) > "/dev/stderr";
    }
    else {
      name = "";
    }

    printf("%s=%s;%s;%s\n", $1, name, $3, $4);
    if (length($2) > maxlen && nameok) {
      maxcall = $1;
      maxlen = length($2);
      maxname = $2;
    }
    if (!nameok) {
        printf("Name ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
  else if ($0 !~ /^(!|#|$)/)
    if (nameok)
      printf("Problem entry: \"%s\"\n", $0) > "/dev/stderr";
    else
      printf("Problem name:  \"%s\"\n", $0) > "/dev/stderr";
}
END { 
    printf("Not counting hyphenated names, %s has the longest: \"%s\" (%d)\n", maxcall, maxname, maxlen) > "/dev/stderr";
}' | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
