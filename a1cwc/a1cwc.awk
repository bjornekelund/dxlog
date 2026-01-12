BEGIN {
  printf("#00 A1 Club Weekly Contest prefill database\n");
  printf("#00 A1 Club Weekly Contest prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  limit = 10;
  printf("Name length limit set to %d\n", limit) > "/dev/stderr";
  FS=",";
  longest = "";
  FS=",";
  longest = "";
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($2 ~ /Name/) nm = 1;
    if ($3 ~ /Name/) nm = 2;
    if ($4 ~ /Name/) nm = 3;
    if ($5 ~ /Name/) nm = 4;
    printf("%s --> call=%d nm=%d\n", $0, call, nm) > "/dev/stderr";
  } 
  else 
  {
    name = toupper($nm);
    if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && name ~ /^[A-Z]+$/ && length(name) <= limit) 
    {
      if (calls[$call] != "") 
      {
        printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
      }
      else 
      {
        line[$call] = $0;
        calls[$call] = $call;
        names[$call] = name;
        longest = length(name) > length(longest) ? name : longest;
      }
    }
    else if ($0 !~ /^(!|#|$)/) 
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  for (cl in calls) 
  {
    printf("%s=%s\n", cl, names[cl]);
  }
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#03 Longest name is \"%s\" with %d characters\n", longest, length(longest));
}
