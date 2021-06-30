gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 RDAC database.\n");
  printf("#1 Based on call history data by VE2FK and UR7QM.\n");
  printf("#2 Last update on %s.\n", date);
}
{
  if (substr($1,1,1) ~ /[0-9,A-Z]/ && $2 != "" && $2 != "") {
    printf("%s=%s\n", $1, $2);
  }
}
END { }' RDAC.txt | sort | more > RDAC_db.txt
unix2dos RDAC_db.txt
