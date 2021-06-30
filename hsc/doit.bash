#!/bin/bash
dos2unix $1
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
  printf("#0 HSC Member numbers data base.\n");
  printf("#1 Last updated %s.\n", strftime("%Y-%m-%d"));
}' < $1 | sort | sed 's/#./#/g' | more > HSC_db.txt
echo "HSC_db.txt created"
unix2dos HSC_db.txt
exit
