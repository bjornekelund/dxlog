#!/bin/bash
#FILE=`ls QSOP_* | tail -1 2> /dev/null`
FILE1=NVHAMS.txt
FILE2=ARRL160.txt

dos2unix -q $FILE1 $FILE2

#echo FILE=\"$FILE\"
OUTFILE=NVQP_db.txt


cat $FILE1 | gawk '
BEGIN {
  FS=","
  col = 2;
}
{
  if ($1 == "!!Order!!") {
    if ($2 ~ /Exch1|State/) col = 1;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> Column is %d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^[A-Z]{3}$/)
      printf("%s,,NV%s\n", $1, $col);
    else
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { }' > .file1

echo Merging files...

cat .file1 $FILE2 | gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 Nevada QSO Party database.\n");
  printf("#1 Based on call history data maintained by VE2FK ve2fk@arrl.net.\n");
  printf("#2 File created %s.\n", date);
  col = 3;
}
{
  if ($1 ~ /!!Order!!/) {
    if ($2 ~ /Exch1|State/) col = 1;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    printf("%s --> Column is %d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^[A-Z]{2,5}$/ && $col !~ /^NV$/)
      printf("%s=%s\n", $1, $col);
    else
      printf("Not included: \"%s\"\n", $0) > "/dev/stderr";
  }
}' | sort | uniq | sed 's/#. /# /g' > $OUTFILE
echo Created $OUTFILE
unix2dos -q $OUTFILE
exit
