#!/bin/bash
BEGIN {
  printf("#00 ICWS Medium Speed Test prefill database\n");
  FS = ",";
  longest = "";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Name");
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $exch ~ /^[A-Za-z]+$/)
  {
    if (line[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", line[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, toupper($exch));
      longest = length($exch) > length(longest) ? toupper($exch) : longest;
      line[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $exch != "")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("Longest name is \"%s\" with %d characters\n", longest, length(longest)) > "/dev/stderr";
  printf("#04 Longest name is \"%s\" with %d characters\n", longest, length(longest));
}
