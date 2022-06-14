dos2unix $1 $2

cat $1 $2 |
gawk '
BEGIN {
  FS=","
  printf("#0 Saratov Region Cup database\n");
  printf("#1 Based on database from https://rdaward.org and call history data from VE2FK\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[0-9,A-Z\/]+$/ && $2 ~ /^SA[0-9]{2}$/) {
    if (rdalist[$1] != "" && rdalist[$1] != $2)
      printf("Call: %s Replacing %s with %s\n", $1, rdalist[$1], $2) > "/dev/stderr";
    callist[$1] = $1;
    rdalist[$1] = $2;
  }
  else {
#    printf("Bad data: %s\n", $0) > "/dev/stderr";
  }
}
END {
  for (cs in callist) {
    printf("%s=%s\n", callist[cs], rdalist[cs]);
  }
}' | sort | sed 's/#. /# /g' > R4C-CUP_db.txt

unix2dos R4C-CUP_db.txt

exit
