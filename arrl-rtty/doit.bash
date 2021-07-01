#bin/bash
dos2unix $1
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
  printf("#0 ARRL RTTY database\n");
  printf("#1 Data collected and maintained by Claude VE2FK ve2fk@arrl.net\n");
  printf("#2 File updated %s\n", strftime("%Y-%m-%d"));
}' < $1 | sort | sed 's/^\#. /\# /g' > ARRL_RTTY_db.txt

echo "ARRL_RTTY_db.txt created"
unix2dos ARRL_RTTY_db.txt
exit
