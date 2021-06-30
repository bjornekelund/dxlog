#bin/bash
dos2unix $1
gawk '
BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $3 ~ /(19|20)[0-9]{2}$/)
    printf("%s=%s\n", $1, $3);
  else
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
  printf("#0 Database for SCC RTTY and IG WW RTTY\n");
  printf("#1 Based on call history data by Claude VE2FK\n");
  printf("#2 File created %s\n", strftime("%Y-%m-%d"));
}' < $1 | sort | sed 's/^\#. /\# /g' > SCC_db.txt
echo "SCC_db.txt created"
unix2dos SCC_db.txt
exit
