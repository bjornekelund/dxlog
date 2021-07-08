#bin/bash
cp vhf_uhf_r1_db.txt _vhf_uhf_r1_db.tmp
dos2unix _vhf_uhf_r1_db.tmp

gawk '
BEGIN {
  FS="=";
}
{
#  printf("Call=%s Grid=%s Status=%s\n", $1, $2, $3) > "/dev/stderr";
  firstcharcall = substr($1, 1, 1);
  call = $1;
  grid4 = substr($2, 1, 4);
  notignore = firstcharcall ~ /[0-9,A-Z]/ && (grid4 ~ /^[A-R][A-R][0-9][0-9]$/)
  if (notignore)
    printf("%s=%s\n", call, grid4);
  else
	printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
  printf("#0 VHF/UHF 4-position grid data base\n");
  printf("#1 Credits to VE2FK, HB9THU, and ES7GM\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
}'  _vhf_uhf_r1_db.tmp | sort | sed 's/^\#. /\# /g' > vhf_uhf_r1-4_db.txt
echo "vhf_uhf_r1-4_db.txt created"
unix2dos vhf_uhf_r1-4_db.txt
exit

