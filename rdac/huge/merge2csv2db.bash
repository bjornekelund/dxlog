dos2unix $1 $2
cat $1 $2 |
gawk '
BEGIN {
  printf("#00 HUGE RDA Contest prefill database.\n");
  printf("#01 Based on data from https://rdaward.org and call history data from VE2FK.\n");
  printf("#02 File created on %s.\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 ~ /^[A-Z]{2}[0-9]{2}$/)
  {
    if (rdalist[$1] != "" && rdalist[$1] != $2)
      printf("Call: %s Replacing %s with %s\n", $1, rdalist[$1], $2) > "/dev/stderr";
    callist[$1] = $1;
    rdalist[$1] = $2;
  }
  else 
  {
    printf("Bad data: %s\n", $0) > "/dev/stderr";
  }
}
END {
  for (cs in callist) 
  {
    printf("%s=%s\n", callist[cs], rdalist[cs]);
  }
}' | sort | sed 's/^#0. /# /g' > RDAC_huge_db.txt
unix2dos RDAC_huge_db.txt
