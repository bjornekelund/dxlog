BEGIN {
  printf("#01 Operator names based on data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  longest = "";
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Name/) name = 2;
    if ($4 ~ /Name/) name = 3;
    if ($5 ~ /Name/) name = 4;
    printf("%s --> call=%d name=%d\n", $0, call, name) > "/dev/stderr";
  }
  else
  {
    ucall = toupper($call);
    uname = toupper($name);
    # printf("$call=\"%s\" uname=\"%s\"\n", $call, uname) > "/dev/stderr";
    # printf("$0=\"%s\"\n", $0) > "/dev/stderr";
    if (ucall ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && uname ~ /^[A-Z]+$/)
    {
      if (line[ucall] != "")
      {
        printf("\"%s\" reoccurs as \"%s\"\n", line[ucall], $0) > "/dev/stderr";
      }
      else if (uname != "")
      {
        printf("%s=%s\n", ucall, uname);
        line[ucall] = $0;
        longest = length(uname) > length(longest) ? uname : longest;
      }
    }
    else if ($0 !~ /^(!|#)/)
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#03 Longest name is \"%s\" with %d characters\n", longest, length(longest));
}