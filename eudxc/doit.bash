#!/bin/bash
FILE=`ls EU_DXC* | tail -1 2> /dev/null`
OUTFILE=EUDXC_db.txt

echo Parsing $FILE
dos2unix -q $FILE

sort $FILE | gawk '
BEGIN {
  FS=",";
  prevcall = "zz";
}
{
  call = $1;
  reg = toupper($2);
  lineok = call ~ /[0-9A-Z]{3,}/ && reg ~ /^[A-Z]{2}[0-9]{2}$/
  if ($0 ~ /^#/) {
    printf("%s\n", $0);
  }
  else if (lineok && call != prevcall) {
    printf("%s=%s\n", call, reg);
  }
 else {
    printf("%s %s\n", call == prevcall ? "Dupe   :" : "Ignored:", $0) > "/dev/stderr";
 }
  prevcall = call;
}
END {
}' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
