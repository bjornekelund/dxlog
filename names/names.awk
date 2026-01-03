BEGIN {
  FS=","
  printf("#01 Operator names based on data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  maxlen = 0;
  maxname = "";
}
{
  call = toupper($1)
  if (line[$1] != "")
    printf("Duplicate entry \"%s\" and \"%s\"\n", line[$1], $0) > "/dev/stderr";
  line[$1] = $0;
  if (call ~ /^[0-9A-Z/]+$/ && $2 ~ /^[A-Za-z]+$/) 
  {
    if ($2 != "") 
    {
      printf("%s=%s\n", call, toupper($2));
      if (length($2) > maxlen) 
      {
        maxlen = length($2);
        maxname = $2;
      }
    }
  }
  else if ($0 !~ /^(!|#)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("#03 Longest name is %s (%d)\n", maxname, maxlen);
  printf("Longest name is %s (%d)\n", maxname, maxlen) > "/dev/stderr";
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
}