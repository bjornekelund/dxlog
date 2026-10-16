BEGIN {
  printf("#00@%s\n", strftime("%Y"));
  printf("#01 YOTA prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Exch1");
  # printf\("%s --> call=%d exch=%s\n", $0, call, exch) > "/dev/stderr";
  }
  else if (IsValidCall($call) && $exch ~ /^[1-9][0-9]?$/)
  {
    if (lines[$call] != "")
    {
      printf("Repeated: \"%s\" and \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      if ($exch ~ /^[1-9]$/) $exch = "0" $exch;
      printf("%s=%d\n", $call, $exch);
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
