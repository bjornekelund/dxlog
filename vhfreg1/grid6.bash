#!/bin/bash
dos2unix -q $1 $2
echo Creating 6-position grid database
gawk '
BEGIN {
  FS=",";
}
{
  firstcharcall = substr($1, 1, 1);
  call = $1;
  grid = $3;
  notignore = firstcharcall ~ /[0-9,A-Z]/ && (grid ~ /^[A-R][A-R][0-9][0-9][A-X][A-X]$/)
  if (notignore)
    printf("%s=%s=0\n", call, grid);
#  else
#    printf("Ignored: %s: \"%s\"\n", $1, $2) > "/dev/stderr";
}
END {
}' < $1 > .older.tmp

gawk '
BEGIN {
  FS="=";
}
{
  firstcharcall = substr($1, 1, 1);
  call = $1;
  grid = $2;
  notignore = firstcharcall ~ /[0-9,A-Z]/ && (grid ~ /^[A-R][A-R][0-9][0-9][A-X][A-X]$/)
  if (notignore)
    printf("%s=%s=1\n", call, grid);
#  else
#    printf("Ignored: %s: \"%s\"\n", $1, $2) > "/dev/stderr";
}
END {
}' < $2 > .younger.tmp

cat .older.tmp .younger.tmp | gawk '
BEGIN {
  FS="=";
}
{
#  printf("Call=%s Grid=%s Status=%s\n", $1, $2, $3) > "/dev/stderr";
  if (gridlist[$1] == "" || $3 == "1") {
    if ($3 == 1 && $2 != gridlist[$1] && gridlist[$1] != "")
      printf("Younger file override: %s = %s, was %s\n", $1, $2, gridlist[$1]) > "/dev/stderr";
    callist[$1] = $1;
    gridlist[$1] = $2;
  }
}
END {
  printf("#0 VHF/UHF 6-position grid data base\n");
  printf("#1 Credits to VE2FK, HB9THU, and ES7GM\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  for (c in callist)
    printf("%s=%s\n", callist[c], gridlist[c]);
}'  | sort | sed 's/^\#. /\# /g' > vhf_uhf_r1_db.txt
echo "vhf_uhf_r1_db.txt created"
unix2dos vhf_uhf_r1_db.txt
exit

