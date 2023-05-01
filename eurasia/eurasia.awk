BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && ($2 ~ /^[A-Za-z]$/ || $3 ~ /^[A-Ra-r]{2}[0-9]{2}[A-Xa-x]{2}$/)) {
    printf("%s=%s\n", $1, toupper($3));
  }
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
}
END {
  printf("#0 EURASIA Championship database - 6-position grid locator\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}