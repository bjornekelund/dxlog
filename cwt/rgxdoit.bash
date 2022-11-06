#!/bin/bash
FILE=cty.dat
RGXFILE=CWT_rgx.txt
XDTFILE=CWOps.xdt

echo Parsing $FILE
dos2unix -q $FILE

gawk '
BEGIN {
  FS=" "
  printf("#\n");
  printf("# Regex file for CWOps CWT\n");
  printf("#\n");
}
{
  for (col = 1; col < 12; col++) {
    if ($col != "") {
      dxcc = $col;
    }
  }
  if (dxcc ~ /^[A-Z0-9]+:$/) {
    pfx = substr(dxcc, 1, length(dxcc) - 1);
    if (pfx !~ /^(1S|3B|3C|4U|9M|BS7|BV9|CE[09]|CY|H4|HC8|K|PY0|R1|T[2-8]|VE|VK[09]|VU[47]|VQ|XF|XX|YV0|ZK|ZL[789])/) {
      # printf("$1=%s dxcc=%s pfx=%s\n", $1, dxcc, pfx) > "/dev/stderr";
      printf("DXCC:^%s$=%s\n", pfx, pfx);
    }
  }
  else if (dxcc ~ /:/ && dxcc !~ /^\-?[0-9\.]+:$/) {
    printf("Ignored: \"%s\"\n", dxcc) > "/dev/stderr";
  }
}
END {
}' $FILE  > $RGXFILE
echo $RGXFILE "created"
unix2dos -q $RGXFILE

exit
