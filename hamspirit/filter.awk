BEGIN {
  printf("#00 Ham Spirit Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = FindColumn("Call");
    if ($3 ~ /Sect/) col = FindColumn("Sect");
  # printf\("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  }
  else if (IsValidCall($call) && $col ~ /^(90|0[1-9]|[1-8][0-9])[A-R]{2}$/)
  {
    printf("%s=%s\n", $call, $col);
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
