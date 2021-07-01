#!/bin/bash
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
	!(lengthcall < 5 && call ~ /\//)
  if (notignore)
    printf("%s=%s\n", $1, $3);
  else
	printf("Ignored: %s\n", $1) > "/dev/stderr";
}
END { 
  printf("#0 IOTA data base\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s.\n", strftime("%Y-%m-%d"));
}' < $1 | sort | more > IOTA_db.txt
echo "IOTA_db.txt created"
unix2dos IOTA_db.txt
exit
