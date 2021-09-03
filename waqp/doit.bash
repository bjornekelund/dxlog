#/bin/bash
cd $(dirname $0)
FILE=`ls QSOP_* | tail -1 2> /dev/null`
echo Using file \"$FILE\"

dos2unix $FILE
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 WAQP/Salmon Run database.\n");
  printf("#1 Based on call history data maintained by VE2FK ve2fk@arrl.net.\n");
  printf("#2 File created %s.\n", date);
  col = 2;
}
{
  if ($1 == "!!Order!!") {
    if ($2 ~ /State|Exch1/) col = 1;
    if ($3 ~ /State|Exch1/) col = 2;
    if ($4 ~ /State|Exch1/) col = 3;
    if ($5 ~ /State|Exch1/) col = 4;
      printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^[A-Z]{2,4}$/)
      printf("%s=%s\n", $1, $col);
#    else
#      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END { }' $FILE | sort | sed 's/#. /# /g' > WAQP_db.txt
unix2dos WAQP_db.txt
