#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=MIQP_db.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
  printf("#0 Michigan QSO Party database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($2 ~ /Exch1|State/) col = 1;
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
      printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(AB|AK|AL|AR|AZ|BC|CA|CO|CT|DE|DX|FL|GA|HI|IA|ID|IL|IN|KS|KY|LA|MA|MB|MD|ME|MN|MO|MS|MT|NB|NC|ND|NE|NH|NJ|NL|NM|NS|NT|NU|NV|NY|OH|OK|ON|OR|PA|PE|QC|RI|SC|SD|SK|TN|TX|UT|VA|VT|WA|WI|WV|WY|YT|ALCO|ALGE|ALLE|ALPE|ANTR|AREN|BARA|BARR|BAY|BENZ|BERR|BRAN|CALH|CASS|CHAR|CHEB|CHIP|CLAR|CLIN|CRAW|DELT|DICK|EATO|EMME|GENE|GLAD|GOGE|GRAT|GRTR|HILL|HOUG|HURO|INGH|IONI|IOSC|IRON|ISAB|JACK|KALK|KENT|KEWE|KZOO|LAKE|LAPE|LEEL|LENA|LIVI|LUCE|MACK|MACO|MANI|MARQ|MASO|MCLM|MECO|MENO|MIDL|MISS|MONR|MTMO|MUSK|NEWA|OAKL|OCEA|OGEM|ONTO|OSCE|OSCO|OTSE|OTTA|PRES|ROSC|SAGI|SANI|SCHO|SHIA|STCL|STJO|TUSC|VANB|WASH|WAYN|WEXF)$/)
      printf("%s=%s\n", $1, $col);
    else if ($0 !~ /^(!|#|$)/)
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  } 
}
END { }' $FILE | sort | sed 's/#. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
