BEGIN {
  FS=","
  printf("#0 PACC database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $2 ~ /^(GR|FR|DR|OV|GD|UT|FL|NH|ZH|NB|ZL|LB)$/)
    printf("%s=%s\n", $1, $2);
  else if ($0 !~ /^(!|#|$)/)
    printf("Ignored: %s\n", $0) > "/dev/stderr";
  if (lines[$1] != "" && $0 !~ /^#/)
    printf("Duplicate: \"%s\" and \"%s\"\n", $0, lines[$1]) > "/dev/stderr";
  lines[$1] = $0; 
}