BEGIN {
  FS=","
  printf("#0 Database for UKEI DX Contest\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  maxlen = 0;
  longest = "";
}
{
  if ($1 ~ /^[0-9A-Z\/]+$/ && $2 ~ /^[A-Z]{2}$/)
    printf("%s=%s\n", $1, $2);
  else if ($0 !~ /^(!|#|$)/ && $2 != "")
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
