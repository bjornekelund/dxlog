#!/bin/bash
gawk '
BEGIN {
  FS=","
}
{
  firstcharcall = substr($1, 1, 1);
  call = $1;
  zone = $2;
  notignore = firstcharcall ~ /[0-9,A-Z]/ && zone ~ /^[0-9][0-9]$|^[0-9]$/
  if (notignore)
    printf("%s=%02d\n", call, zone);
  else
	printf("Ignored: %s\n", $1) > "/dev/stderr";
}
END { 
  printf("#0 CQ WW contest data base\n");
  printf("#1 Based on 2019 call history data collected and scrubbed by Bob KE2D\n");
  printf("#2 File created on %s\n", strftime("%Y-%m-%d"));
}' < $1 | sort | more > CQWW_db.txt
echo "CQWW_db.txt created"
unix2dos CQWW_db.txt
exit
