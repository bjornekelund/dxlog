#!/bin/bash
FILE=LZDX-AAA.txt
OUTFILE=LZDX-BBB.txt

dos2unix -q $FILE
echo Parsing $FILE...

gawk '
BEGIN {
  FS=","
}
{
  cl = $1;
  nm = $2;
  ex = $3;
  cm = $4;  
  if (cl ~ /^[0-9,A-Z]/ && ex ~ /^(BU|BL|VN|VT|VD|VR|GA|DO|KA|KD|LV|MN|PA|PK|PL|PD|RZ|RS|SS|SL|SM|SF|SO|SZ|TA|HA|SN|YA)$/) {
    if (exch[$1] != "" && exch[$1] != $3)
      printf("Replacing %s with %s for %s\n", exch[$1], ex, cl) > "/dev/stderr";
    call[$1] = cl;
    exch[$1] = ex;
    name[$1] = nm;
    comment[$1] = cm;
  }
  else if ($0 ~ /^(!|#|$)/) {
    printf("%s\n", $0); 
  }
  else {
      printf("Bad line \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (cll in call)
    printf("%s,%s,%s,%s\n", cll, name[cll], exch[cll], comment[cll]);
}' $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
