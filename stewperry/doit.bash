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
	printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
  printf("#0 Stew Perry data base\n");
  printf("#1 Data collected and maintained by VE2FK\n");
  printf("#2 Send new info/corrections to ve2fk@arrl.net\n");
  printf("#3 File updated %s\n", strftime("%Y-%m-%d"));
}' < $1 | sort | sed 's/^#./#/g' > StewPerry_db.txt
echo "StewPerry_db.txt created"
unix2dos StewPerry_db.txt
exit
