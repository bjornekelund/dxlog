BEGIN {
  printf("#00 Stew Perry TBDC data base\n");
  printf("#01 Also used for Makrothen, Maidenhead Mayhem, Russian 160m, Solar Eclipse QP, and CQ WW VHF contests\n");
  printf("#02 Based on data from https://supercheckhistory.com\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  count = 0;
  call = 1;
  loc = 2;
}
{
  if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $loc ~ /^[A-R]{2}[0-9]{2}$/)
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
    # printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
      printf("File contained %d calls\n", count) > "/dev/stderr";
}
