BEGIN {
  printf("#00 Prefill database for IG-RY, SCC RTTY and RTTYops WW DX contests\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("State|Exch1");
    # printf("\"%s\" --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  }
  else if (IsValidCall($call) && $exch ~ /^(19|20)[0-9]{2}$/)
  {
    if (years[$call] != "" && years[$call] != $exch)
    {
      # printf("%s reoccurred with %s instead of %s\n", $call, $exch, years[$call]) > "/dev/stderr";
    }
    else
    {
      calls[$call] = $call;
      years[$call] = $exch;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  for (c in calls)
  {
    printf("%s=%s\n", c, years[c]);
  }
}
