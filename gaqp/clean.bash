#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=QSOP_GA.fixed.txt

echo Using file \"$FILE\"

dos2unix -q $FILE
gawk '
BEGIN {
  FS=","
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
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(AB|AK|AL|AR|AZ|BC|CA|CO|CT|DE|DX|FL|HI|IA|ID|IL|IN|KS|KY|LA|MA|MB|MD|MI|ME|MN|MO|MS|MT|NB|NC|ND|NE|NH|NJ|NL|NM|NS|NT|NU|NV|NY|OH|OK|ON|OR|PA|PE|QC|RI|SC|SD|SK|TN|TX|UT|VA|VT|WA|WI|WV|WY|YT|ALCO|ALGE|ALLE|ALPE|ANTR|AREN|BARA|BARR|BAY|BENZ|BERR|BRAN|CALH|CASS|CHAR|CHEB|CHIP|CLAR|CLIN|CRAW|DELT|DICK|EATO|EMME|GENE|GLAD|GOGE|GRAT|GRTR|HILL|HOUG|HURO|INGH|IONI|IOSC|IRON|ISAB|JACK|KALK|KENT|KEWE|KZOO|LAKE|LAPE|LEEL|LENA|LIVI|LUCE|MACK|MACO|MANI|MARQ|MASO|MCLM|MECO|MENO|MIDL|MISS|MONR|MTMO|MUSK|NEWA|OAKL|OCEA|OGEM|ONTO|OSCE|OSCO|OTSE|OTTA|PRES|ROSC|SAGI|SANI|SCHO|SHIA|STCL|STJO|TUSC|VANB|WASH|WAYN|WEXF)$/)
      printf("%s\n", $0);
    else if ($0 ~ /^(!|#|$)/)
      printf("%s\n", $0);
	else
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  } 
}
END { }' $FILE > $OUTFILE
unix2dos -q $OUTFILE
echo Created $OUTFILE
exit
