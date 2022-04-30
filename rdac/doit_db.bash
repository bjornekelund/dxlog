gawk '
BEGIN {
  FS=","
  printf("#0 RDAC database.\n");
  printf("#1 Based on data collected and maintained data by VE2FK and UR7QM.\n");
  printf("#2 Includes updates by NA3M and RA3R.\n");
  printf("#3 Updated %s.\n", strftime("%Y-%m-%d"));
}
{
  if (substr($1,1,1) ~ /[0-9,A-Z]/ && $2 != "" && $2 != "") {
    printf("%s=%s\n", $1, $2);
  }
}
END { }' RDAC.txt | sort | sed 's/#. /# /g' | uniq > RDAC_db.txt
unix2dos RDAC_db.txt
