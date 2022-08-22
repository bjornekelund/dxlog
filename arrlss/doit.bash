#!/bin/bash
FILE1=`ls ARRLSS_CW* | tail -1 2> /dev/null`
FILE2=`ls ARRLSS_SSB* | tail -1 2> /dev/null`

OUTFILE=ARRLSS_db.txt

echo Parsing $FILE1 \& $FILE2
dos2unix -q $FILE1 $FILE2

cat $FILE1 $FILE2 |\
sed 's/=/;/g' |\
gawk '
BEGIN {
  FS=";"
  col = 2;
}
{
  if ($0 !~ /#/) {
    if (call[$1] != "" && (prec[$1] != $2 || lic[$1] != $3 || sect[$1] != $4))
      printf("Replace %s=%s;%s;%s with %s=%s;%s;%s\n", $1, prec[$1], lic[$1], sect[$1], $1, $2, $3, $4) > "/dev/stderr";
    call[$1] = $1;
    prec[$1] = $2;
    lic[$1] = $3;
    sect[$1] = $4;
  }
}
END {
  printf("#0 ARRL Sweestakes database\n");
  printf("#1 Based on data collected and maintained by VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  for (cs in call)
    printf("%s=%s;%s;%s\n", cs, prec[cs], lic[cs], sect[cs]);
}
' $FILE | sort | uniq | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
