BEGIN {
  printf("#00 Stew Perry TBDC data base\n");
  printf("#01 Also used for Makrothen, Maidenhead Mayhem, Russian 160m, Solar Eclipse QP, and CQ WW VHF contests\n");
  printf("#02 Based on data maintained by VE2FK\n");
  printf("#03 Send new info/corrections to ve2fk@arrl.net\n");
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  count = 0;
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1; else
    if ($3 ~ /Call/) call = 2; else
    if ($4 ~ /Call/) call = 3; else
    if ($5 ~ /Call/) call = 4; else call = 0;
    if ($3 ~ /Loc1/) loc = 2; else
    if ($4 ~ /Loc1/) loc = 3; else
    if ($5 ~ /Loc1/) loc = 4; else loc = 0;
  # printf\("%s --> call=%d loc=%d\n", $0, call, loc) > "/dev/stderr";
  }
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $loc ~ /^[A-R]{2}[0-9]{2}$/)
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
