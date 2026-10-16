BEGIN {
  printf("#00 Stew Perry TBDC data base\n");
  printf("#04 Also used for Makrothen, Maidenhead Mayhem, Russian 160m, Solar Eclipse QP, and CQ WW VHF contests\n");
  FS = ",";
  count = 0;
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    loc = FindColumn("Loc1|Exch1");
  # printf\("%s --> call=%d loc=%d\n", $0, call, loc) > "/dev/stderr";
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
      count++;
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $loc != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
      printf("File contained %d calls\n", count) > "/dev/stderr";
}
