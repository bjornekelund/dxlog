#!/bin/bash
FILE=`ls IOTA_2* | tail -1 2> /dev/null`
DBFILE=IOTA_db.txt
XDTFILE=IOTA.xdt

dos2unix -q $FILE

gawk '
BEGIN {
  FS=","
}
{
  firstcharcall = substr($1, 1, 1);
  lengthcall = length($1);
  lastcharcall = substr($1,lengthcall,1);
  call = $1;
  iota = toupper($3);
  notignore = \
    firstcharcall ~ /[0-9A-Z]/ && \
    iota ~ /[EU|OC|AS|NA|SA|AF|AN]/ && \
    (lastcharcall ~ /[A-Z]/ || call ~/\/[0-9,A-Z]/ || call ~ /[0-9][0-9]/) && \
    lengthcall > 2 && \
    !(lengthcall < 6 && call ~ /[0-9]\//) && \
    !(lengthcall < 5 && call ~ /\//);
  isprefix = $1 ~ /[0-9]$|^[A-Z]{1,4}$|^[A-Z0-9]{1,3}\/|^[A-Z][0-9]$|^[0-9][A-Z]$/
  if (notignore)
    printf("%s=%s\n", call, iota);
  else if ($0 !~ /^(!|#|$)/ && !isprefix)
	  printf("Ignored: %s\n", $1) > "/dev/stderr";
}
END { 
  printf("#0 IOTA Contest database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}' $FILE | sort | sed 's/#. /# /g' > $DBFILE

echo Created $DBFILE
unix2dos -q $DBFILE

gawk '
BEGIN {
  FS=","
  printf("#TITLE IOTA\n");
}
{
  if ($1 ~ /^[0-9A-Z]/ && $3 ~ /[0-9]/) {
    printf("%s %s %s\n", $1, $3, $4);
  }
}
END {
}' $FILE | sort > $XDTFILE

echo Created $XDTFILE
unix2dos -q $XDTFILE

echo Parsed $FILE

exit
