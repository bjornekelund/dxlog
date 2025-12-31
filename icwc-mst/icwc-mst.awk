#!/bin/bash
BEGIN {
  FS=","
  printf("#0 ICWS Medium Speed Test database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
  longest = "";
}
{
  if ($0 ~ /^(!|#|$)/) 
  {
    if ($1 ~ /!!Order!!/) 
    {
      if ($2 ~ /Name/) col = 1;
      if ($3 ~ /Name/) col = 2;
      if ($4 ~ /Name/) col = 3;
      if ($5 ~ /Name/) col = 4;
      call = 1;
      printf("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
    } 
  }
  else if (line[$call] != "")
  {
    printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
  }
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^[A-Za-z]+$/) 
  {
    if (length($col) > length(longest)) 
    {
      longest = $col;
    }
    printf("%s=%s\n", $call, toupper($col));
    line[$call] = $0;
  }
  else 
  {
    if ($col != "") 
    {
      printf("Problem name: \"%s\"\n", $0) > "/dev/stderr";
    }
    else 
    {
#      printf("Missing name: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END {
  printf("Longest name is: \"%s\" with %d characters.\n", longest, length(longest)) > "/dev/stderr";
}