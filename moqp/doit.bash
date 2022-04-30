#!/bin/bash
FILE=`ls QSOP_* | tail -1 2> /dev/null`
OUTFILE=MOQP_db.txt

echo Using file \"$FILE\"

dos2unix -q $FILE
gawk '
BEGIN {
  FS=","
  printf("#0 MOQP database.\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
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
    exch = $col;
    if (exch == "DC") 
      exch = "MD";
    if ($1 ~ /^[0-9,A-Z,\/]+$/ && exch ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VA|VT|WA|WV|WI|WY|AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT|ADR|AND|ATC|AUD|BAR|BAT|BEN|BOL|BOO|BTN|BTR|BUC|CAL|CAM|CAR|CAS|CED|CHN|CHR|CLA|CLK|CLN|COL|COP|CPG|CRA|CRL|CWL|DAD|DAL|DEK|DEN|DGL|DUN|DVS|FRA|GAS|GEN|GRN|GRU|HAR|HEN|HIC|HLT|HOW|HWL|IRN|JAC|JAS|JEF|JON|KNX|LAC|LAF|LAW|LCN|LEW|LIN|LIV|MAC|MAD|MAR|MCD|MER|MGM|MIL|MIS|MNT|MON|MOR|MRE|NMD|NOD|NWT|ORE|OSA|OZA|PEM|PER|PET|PHE|PIK|PLA|POL|PUL|PUT|RAL|RAN|RAY|REY|RIP|SAL|SCH|SCL|SCO|SCT|SHA|SHL|SLC|STC|STD|STF|STG|STL|STN|SUL|TAN|TEX|VRN|WAR|WAS|WAY|WEB|WOR|WRT)$/)
      printf("%s=%s\n", $1, exch);
    else if ($0 !~ /^(!|#|$)/)
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  } 
}
END { }' $FILE | sort | sed 's/#. /# /g' > $OUTFILE
unix2dos -q $OUTFILE
echo Created $OUTFILE
exit
