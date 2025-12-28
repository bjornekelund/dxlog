BEGIN {
  FS=","
}
{
  if (lines[$1] != "") 
  {
    if (toupper($3) != exch[$1])
    {
#      printf("Ignoring older exchange \"%s\" for %s\n", exch[$1], $1) > "/dev/stderr";
    }
  }
  else if ($1 ~ /^[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+$/ && $3 ~ /^[A-Ra-r]{2}[0-9]{2}[A-Xa-x]{2}$/) 
  {
    printf("%s=%s\n", $1, toupper($3));
    lines[$1] = $0;
    exch[$1] = toupper($3);
  }
  else if ($0 !~ /^(!|#|$)/ && $1 !~ /\//)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("#0 EURASIA Championship database - 6-position grid locator\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}