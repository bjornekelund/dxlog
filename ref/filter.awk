BEGIN {
  printf("#00 REF Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Exch1");
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if (IsValidCall($call) && $exch ~ /^(F[YRTSPOMKGHJW]|[0-9][0-9]?|2[AB])$/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, ($exch ~ /^[1-9]$/) ? "0" $exch : $exch);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
