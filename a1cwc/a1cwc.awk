BEGIN {
  printf("#00 A1 Club Weekly Contest prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  limit = 10;
  printf("Name length limit set to %d\n", limit) > "/dev/stderr";
  FS = ",";
  longest = "";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($2 ~ /Name/) namc = 1;
    if ($3 ~ /Name/) namc = 2;
    if ($4 ~ /Name/) namc = 3;
    if ($5 ~ /Name/) namc = 4;
    printf("%s --> call=%d namc=%d\n", $0, call, namc) > "/dev/stderr";
  }
  else
  {
    name = toupper($namc);
    if ( \
      $call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && \
      name ~ /^[A-Z]+$/ && \
      length(name) <= limit)
    {
      if (calls[$call] != "")
      {
        printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
      }
      else
      {
        line[$call] = $0;
        longest = length(name) > length(longest) ? name : longest;
        printf("%s=%s\n", $call, name);
      }
    }
    else if ($0 !~ /^(!|#|$)/)
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#03 Longest name is \"%s\" with %d characters\n", longest, length(longest));
}
