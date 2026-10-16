BEGIN {
  printf("#00 Prefill database for IG-RY, SCC RTTY and RTTYops WW DX contests\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("State|Exch1");
    printf("\"%s\" --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  }
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $exch ~ /^(19|20)[0-9]{2}$/)
  {
    if (year[$call] != "")
      printf("Replaced %s with %s for %s\n", year[$call], $2, $call) > "/dev/stderr";
    year[$call] = $exch;
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
