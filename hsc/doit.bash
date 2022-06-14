#!/bin/bash

DBFILE=HSC_db.txt
XDTFILE=hsc.xdt

curl -s https://hsc.dj1yfk.de/db/HSC_db.txt --output HSC_db.txt
curl -s https://hsc.dj1yfk.de/db/hsc.xdt --output hsc.xdt

echo Downloaded $DBFILE and $XDTFILE

exit

INFILE=HSCCW.txt 
OUTFILE=HSC_db.txt

dos2unix -q $1
echo Processing $INFILE

gawk '
BEGIN {
  FS=","
}
{
  notignore = $1 ~ /[0-9,A-Z]/ 
  notignore = notignore && !($1 ~ /[!#]/)
  notignore = notignore && $2 ~ /^[1-9]|[10-99]|[100-999]|[1000-9999]$/
  if (notignore)
    printf("%s=%s\n", $1, $2);
  else
	printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
}
END { 
  printf("#0 HSC Member numbers data base\n");
  printf("#1 Last updated %s\n", strftime("%Y-%m-%d"));
}' $INFILE | sort | sed 's/#./#/g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit



