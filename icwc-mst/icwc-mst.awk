#!/bin/bash
BEGIN {
  FS=","
  printf("#0 ICWS Medium Speed Test database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "^!!Order!!") {
    if ($3 ~ /Name/) col = 2;
    if ($4 ~ /Name/) col = 3;
    if ($5 ~ /Name/) col = 4;
    # printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else {
    nm = toupper($col)
    if ($1 ~ /^[0-9A-Z/]+$/ && nm ~ /^[A-Z]+$/) {
      if (line[$1] != "")
        printf("\"%s\" reoccurs as \"%s\"\n", line[$1], $0) > "/dev/stderr";
      else {
        printf("%s=%s\n", $1, nm);
        line[$1] = $0;
      }
    }
    else if ($0 !~ /^(!|#|$)/ && nm != "") {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
