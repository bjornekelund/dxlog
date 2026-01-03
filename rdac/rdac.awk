BEGIN {
  FS=","
  printf("#00 RDAC database\n");
  printf("#01 Based on data collected and maintained data by VE2FK and UR7QM\n");
  printf("#02 Includes updates by NA3M and RA3R\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $2 ~ /^[A-Z]{2}[0-9]{2}$/) 
  {
    printf("%s=%s\n", $1, $2);
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
