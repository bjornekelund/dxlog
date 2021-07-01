#bin/bash

dos2unix $1

cat $1 | sed 's/\"//g' |
gawk '
BEGIN {
  FS=","
  max = 0;
  printf("#0 DIG members database\n");
  printf("#1 Based on official member roster at https://diplom-interessen-gruppe.info\n");
  printf("#2 File created %s\n", strftime("%Y-%m-%d"));
}
{
  if ($3 ~ /^[0-9]+$/ && $4 ~/^[A-Z0-9]+$/)
    printf("%s=%s\n", $4, $3);
  else
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
}' | sed 's/=0*/=/g' | sed 's/^\#. /\# /g' > DIG_db.txt

unix2dos DIG_db.txt
echo "DIG_db.txt created"

exit
