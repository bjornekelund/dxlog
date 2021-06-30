#bin/bash
dos2unix $1
gawk '
BEGIN {
  FS=","
}
{
  firstcharcall = substr($1, 1, 1);
  call = $1;
  grid = $3;
  notignore = firstcharcall ~ /[0-9,A-Z]/ && (grid ~ /^[A-R][A-R][0-9][0-9][A-X][A-X]$/ || grid ~ /^[A-R][A-R][0-9][0-9]$/)
  if (notignore)
    printf("%s=%s\n", call, grid);
  else
	printf("Ignored: %s: \"%s\"\n", $1, $2) > "/dev/stderr";
}
END { 
  printf("#0 VHF/UHF grid data base\n");
  printf("#1 Based on call history data from Claude VE2FK.\n");
  printf("#2 Created by SM7IUN on %s.\n", strftime("%Y-%m-%d"));
}' < $1 | sort | sed 's/^\#. /\# /g' > vhf_uhf_r1_db.txt
echo "vhf_uhf_r1_db.txt created"
unix2dos vhf_uhf_r1_db.txt
exit
