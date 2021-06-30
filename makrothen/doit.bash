#!/bin/bash
dos2unix $1
gawk '
BEGIN {
  FS=","
}
{
  firstcharcall = substr($1, 1, 1);
  call = $1;
  grid = $3;
  notignore = firstcharcall ~ /[0-9,A-Z]/ && grid ~ /^[A-R][A-R][0-9][0-9]$/
  if (notignore)
    printf("%s=%s\n", call, grid);
  else
	printf("Ignored: %s\n", $1) > "/dev/stderr";
}
END { 
  printf("#0 Makrothen contest data base\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File last updated %s\n", strftime("%Y-%m-%d"));
}' < $1 | sort | more > TMCR_db.txt
echo "TMCR_db.txt created"
unix2dos TMCR_db.txt
exit
