BEGIN {
  FS=","
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $2 ~ /^..[1-9][0-9]*$/) {
    number = $2;
    printf("%s=%s\n", $1, number);
  }
  else if ($0 !~/^(!|#|$)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
}
END {
  printf("#0 MARCONI CLUB ARI LOANO members database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}