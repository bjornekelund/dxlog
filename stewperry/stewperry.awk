BEGIN {
  printf("#0 Stew Perry TBDC data base\n");
  printf("#1 Also used for Makrothen, Maidenhead Mayhem, Russian 160m, Solar Eclipse QP, and CQ WW VHF contests\n");
  printf("#2 Data collected and maintained by VE2FK\n");
  printf("#3 Send new info/corrections to ve2fk@arrl.net\n");
  printf("#4 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($0 ~ /^!!Order!!/)
  {
    if ($3 ~ /Loc1/) loc = 2;
    if ($4 ~ /Loc1/) loc = 3;
    if ($5 ~ /Loc1/) loc = 4;
    printf("%s --> loc=%d\n", $0, loc) > "/dev/stderr";
  } 
  else if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $loc ~ /^[A-R]{2}[0-9]{2}$/) 
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else 
    {
      printf("%s=%s\n", $1, $loc);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $loc != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
