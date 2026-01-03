BEGIN {
  FS=","
  printf("#00 A1 CLUB Weekly Contest database\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  longest = "";
  limit = 10;
  printf("Name length limit set to %d\n", limit) > "/dev/stderr";
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($2 ~ /Name/) col = 1;
    if ($3 ~ /Name/) col = 2;
    if ($4 ~ /Name/) col = 3;
    if ($5 ~ /Name/) col = 4;
    printf("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  } 
  else 
  {
    nm = toupper($col);
    if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && nm ~ /^[A-Z]+$/ && length(nm) <= limit) 
    {
      if (calls[$call] != "") 
      {
        printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
      }
      else 
      {
        line[$call] = $0;
        calls[$call] = $call;
        names[$call] = nm;
        if (length(nm) > length(longest)) 
        {
          longest = nm;
        }
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
  printf("Longest name is \"%s\" (%d)\n", longest, length(longest)) > "/dev/stderr";
}
