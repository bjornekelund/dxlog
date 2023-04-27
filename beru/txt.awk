BEGIN {
  printf("#0 BERU HQ stations database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
  max = 0;
}
{
  if ($1 ~ /[0-9A-Z]/ && $3 == "HQ")
    printf("%s=%s\n", $1, $3);
}
