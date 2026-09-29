BEGIN {
  printf("#00 A1 Club Weekly Contest prefill database\n");
  printf("#01 Based on data from https://supercheckhistory.com\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  limit = 10;
  printf("Name length limit set to %d\n", limit) > "/dev/stderr";
  FS = ",";
  longest = "";
  call = 1;
  namc = 2;
}
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
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#03 Longest name is \"%s\" with %d characters\n", longest, length(longest));
}
