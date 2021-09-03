#/bin/bash
cd $(dirname $0)
FILE=`ls CWOPS* | tail -1 2> /dev/null`
echo Using file \"$FILE\"

dos2unix $FILE
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 CWOps Open database.\n");
  printf("#1 Based on call history data maintained by VE2FK ve2fk@arrl.net.\n");
  printf("#2 File created %s.\n", date);
  col = 2;
}
{
  if ($0 ~ /!!Order!!/) {
    if ($2 ~ /Name/) col = 1;
    if ($3 ~ /Name/) col = 2;
    if ($4 ~ /Name/) col = 3;
    if ($5 ~ /Name/) col = 4;
      printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^[A-Za-z]+$/)
      printf("%s=%s\n", $1, toupper($col));
    else
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { }' $FILE | sort | sed 's/#. /# /g' > CWOpen_db.txt
unix2dos CWOpen_db.txt
