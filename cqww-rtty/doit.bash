#bin/bash
dos2unix CQWWRTTY.txt
gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 != "") {
    printf("%s=%s\n", $1, $3);
  }
  else
    printf("Fail: \"%s\"\n", $0) > "/dev/stderr"
}
END { 
  printf("#0 CQ 160M database - States and provinces but AK HI PR VI not listed as state.\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", strftime("%Y-%m-%d"));
}' < CQWWRTTY.txt | sort | sed 's/^\#. /\# /g' > CQWWR_db.txt

echo "CQWWR_db.txt created"
unix2dos CQWWR_db.txt
exit
