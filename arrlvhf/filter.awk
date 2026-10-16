BEGIN {
  printf("#00 ARRL VHF Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    loc = FindColumn("Exch1|Loc1");
    # printf("%s --> call=%d loc=%d\n", $0, call, loc) > "/dev/stderr";
  }
  else if (IsValidCall($call) && $loc ~ /^[A-R]{2}[0-9]{2}$/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, $loc);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
