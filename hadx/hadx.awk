BEGIN {
  printf("#0 HA DX database\n");
  printf("#1 Data collected and maintained by HA2NA ha2na@ha2na.hu\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($1 ~ /^[0-9A-Z/]+$/ && $2 ~ /^(BA|BE|BN|BO|BP|CS|FE|GY|HB|HE|SZ|KO|NG|PE|SO|SA|TO|VA|VE|ZA)$/) {
    printf("%s=%s\n", $1, $2);
  }
  else if ($0 !~ /^(!|#|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
