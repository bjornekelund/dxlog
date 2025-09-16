BEGIN {
  FS=","
  max = 0;
  printf("#0 RCC Cup prefill database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[A-Z0-9]/ && $2 ~ /RCC[0-9]+$/) {
    printf("%s=%s\n", $1, $2);
  }
  else if ($0 !~ /^(!|#|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
