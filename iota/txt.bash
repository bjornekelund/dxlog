#!/bin/bash
OUTFILE=IOTA_db.txt

gawk '
BEGIN {
  FS=","
}
{
  firstcharcall = substr($1, 1, 1);
  lengthcall = length($1);
  lastcharcall = substr($1,lengthcall,1);
  call = $1;
  iota = $3;
  notignore = \
    firstcharcall ~ /[0-9,A-Z]/ && \
	  iota ~ /[EU|OC|AS|NA|SA|AF|AN]/ && \
	  (lastcharcall ~ /[A-Z]/ || call ~/\/[0-9,A-Z]/ || call ~ /[0-9][0-9]/) && \
	  lengthcall > 2 && \
	  !(lengthcall < 6 && call ~ /[0-9]\//) && \
	  !(lengthcall < 5 && call ~ /\//);
  if (notignore)
    printf("%s=%s\n", $1, $3);
  else if ($0 !~ /^(!|#|$)/)
	  printf("Ignored: %s\n", $1) > "/dev/stderr";
}
END { 
  printf("#0 IOTA Contest database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}' < $1 | sort | sed 's/#. /# /g' | more > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
