BEGIN {
  printf("#00 HA DX database\n");
  printf("#01 Data collected and maintained by HA2NA ha2na@ha2na.hu\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  call = 1;
  col = 2;
  if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^(BA|BE|BN|BO|BP|CS|FE|GY|HB|HE|SZ|KO|NG|PE|SO|SA|TO|VA|VE|ZA)$/) 
  {
    printf("%s=%s\n", $call, $col);
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
