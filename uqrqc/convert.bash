#!/bin/bash
FILE=uqrq_mem.txt
OUTFILE=UQRQC_db.txt

echo Processing $FILE
dos2unix -q $FILE

cat $FILE | sed 's/Ø/0/g' | gawk '
BEGIN {
  FS=" "
  printf("# U-QRQ-C Members database\n");
  printf("# Scraped from https://u-qrq-c.ru/members-rus/\n");
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  printf("%s=%s\n", $2, $1);
}
END {
}' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
