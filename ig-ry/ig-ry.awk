BEGIN {
  printf("#00 Database for IG-RY, SCC RTTY and RTTYops WW DX contests\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report errors and updates to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /State|Exch1/) col = 2;
    if ($4 ~ /State|Exch1/) col = 3;
    if ($5 ~ /State|Exch1/) col = 4;
    printf("\"%s\" --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  } 
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^(19|20)[0-9]{2}$/) 
  {
    if (year[$call] != "")
      printf("Replaced %s with %s for %s\n", year[$call], $2, $call) > "/dev/stderr";
    year[$call] = $2;
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (call in year)
  {
    printf("%s=%s\n", call, year[call]);
  }
}