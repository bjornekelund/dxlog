dos2unix $1
gawk '
BEGIN {
  FS=","
  date = strftime("%Y-%m-%d");
  printf("#0 MD-DC QP database.\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly ve2fk@arrl.net\n");
  printf("#3 File last updated %s\n", strftime("%Y-%m-%d"));
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
