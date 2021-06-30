dos2unix $1
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 MD-DC QP database.\n");
  printf("#1 Based on NAQP call history data by Claude VE2FK.\n");
  printf("#3 Created %s.\n", date);
}
{
  call = toupper($1);
  state = toupper($3);
  if (call ~ /^[0-9,A-Z]/ && state != "" && state != "MD" && state != "DC")
    printf("%s=%s\n", toupper($1), toupper($3));
  else
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}' $1 | sort | sed 's/^#./#/g' > MDQP_db.txt
unix2dos MDQP_db.txt
