BEGIN {
  FS=","
  printf("#0 RDAC database\n");
  printf("#1 Based on data collected and maintained data by VE2FK and UR7QM\n");
  printf("#2 Includes updates by NA3M and RA3R\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $2 != "") {
    printf("%s=%s\n", $1, $2);
  }
  else if ($0 !~ /^(!|#|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
