#!/bin/bash
BEGIN {
  printf("#00 ICWS Medium Speed Test prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  longest = "";
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($2 ~ /Call/) call = 1; else
    if ($3 ~ /Call/) call = 2; else
    if ($4 ~ /Call/) call = 3; else
    if ($5 ~ /Call/) call = 4; else call = 0;
    if ($2 ~ /Name/) col = 1; else
    if ($3 ~ /Name/) col = 2; else
    if ($4 ~ /Name/) col = 3; else
    if ($5 ~ /Name/) col = 4; else col = 0;
    printf("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  } 
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^[A-Za-z]+$/) 
  {
    if (line[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, toupper($col));
      longest = length($col) > length(longest) ? toupper($col) : longest;
      line[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#03 Longest name is \"%s\" with %d characters\n", longest, length(longest));
}
