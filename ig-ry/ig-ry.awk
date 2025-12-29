BEGIN {
  printf("#0 Database for IG-RY, SCC RTTY and RTTYops WW DX contests\n");
  printf("#1 Based on data collected and maintained by Claude VE2FK\n");
  printf("#2 Report errors and updates to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($1 == "!!Order!!") 
  {
    if ($3 ~ /State|Exch1/) col = 2;
    if ($4 ~ /State|Exch1/) col = 3;
    if ($5 ~ /State|Exch1/) col = 4;
    printf("\"%s\" --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else 
  {
    if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^(19|20)[0-9]{2}$/) 
    {
      if (year[$1] != "")
        printf("Replaced %s with %s for %s\n", year[$1], $2, $1) > "/dev/stderr";
      year[$1] = $2;
    }
    else if ($0 !~ /^(!|#|$)/)
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  for (call in year)
    printf("%s=%s\n", call, year[call]);
}