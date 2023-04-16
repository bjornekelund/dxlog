BEGIN {
  FS=","
  printf("#0 PA Beker database\n");
  printf("#1 Based on data maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  maxlen = 0;
}
{
  if ($1 ~ /^[A-Z0-9]+$/ && $2 ~ /^[0-5][0-9]$/)
    printf("%s=%s\n", $1, $2);
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
