#!/bin/bash
FILE=`ls QSOP_VA-2* | tail -1 2> /dev/null`
OUTFILE=QSOP_VA.fixed.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ "!!Order!!") {
    if ($3 ~ /Exch1|State/) col = 2;
    if ($4 ~ /Exch1|State/) col = 3;
    if ($5 ~ /Exch1|State/) col = 4;
    if ($3 ~ /UserText/) usr = 2;
    if ($4 ~ /UserText/) usr = 3;
    if ($5 ~ /UserText/) usr = 4;
    printf("%s --> col=%d usr=%d\n", $0, col, usr) > "/dev/stderr";
    printf("%s\n", $0);
  } else {
    if (line[$1] != "") {
      printf("%s reoccurs as %s and is ignored\n", line[$1], $0) > "/dev/stderr";
    }
    else if ($1 ~ /^[0-9,A-Z,\/]+$/ && $col ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|WA|WV|WI|WY|AB|BC|LB|MB|NB|NF|NL|NS|NT|NU|ON|PE|QC|SK|YT|ACC|ALB|ALL|ALX|AME|AMH|APP|ARL|AUG|BAT|BCH|BED|BHM|BLA|BOT|BRU|BRX|BVX|CAM|CCY|CHA|CHE|CHX|CLA|CLN|COX|CPX|CRA|CRL|CUL|CUM|CVX|DAX|DIC|DIN|EMX|ESS|FAU|FBX|FCX|FFX|FLO|FLU|FRA|FRE|FRX|FXX|GAX|GIL|GLO|GOO|GRA|GRN|GVL|HAL|HAN|HAX|HBX|HCO|HIG|HOX|HRY|IOW|JAM|KGE|KQN|KWM|LAN|LDN|LEE|LEX|LSA|LUN|LYX|MAD|MAT|MAX|MEC|MID|MON|MPX|MVX|NEL|NEW|NFX|NHA|NNX|NOT|NRX|NUM|ORG|PAG|PAT|PBX|PIT|POW|POX|PQX|PRE|PRG|PRW|PUL|RAP|RAX|RBR|RHM|RIC|RIX|ROA|ROX|RUS|SAX|SCO|SHA|SHE|SMY|SPO|STA|STX|SUR|SUS|SUX|TAZ|VBX|WAR|WAS|WAX|WES|WIS|WIX|WMX|WYT|YOR)$/) {
      printf("%s\n", $0);
      line[$1] = $0;
    }
    else if ($1 ~ /^[0-9,A-Z,\/]+$/ && $usr != "") {
      printf("%s\n", $0);
      call[$1] = $1;
      line[$1] = $0;
    }
    else if ($0 ~ /^(!|#|$)/) {
      printf("%s\n", $0);
      call[$1] = $1;
      line[$1] = $0;
    }
	  else
      printf("Invalid exchange: \"%s\"\n", $0) > "/dev/stderr";
  } 
}
END { }' $FILE > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
