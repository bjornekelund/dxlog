BEGIN {
  FS=","
  col = 2;
  dupes = 0;
  maxlen = 0;
}
{
  if ($0 ~ /!!Order!!/) {
    if ($2 ~ /Name/) col = 1;
    if ($3 ~ /Name/) col = 2;
    if ($4 ~ /Name/) col = 3;
    if ($5 ~ /Name/) col = 4;
      printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else {
    newname = toupper($col);
    if ($1 ~ /^[0-9A-Z\/]+$/ && newname != "") {
      if (length(newname) > maxlen) {
        maxlen = length(newname);
        maxname = newname;
        printf("Longer \"%s\"\n", $0) > "/dev/stderr";
      }
      if (name[$1] != $col && name[$1] != newname && name[$1] != "") {
#        printf("Replaced %s with %s for %s\n", name[$1], newname, $1) > "/dev/stderr";
        dupes++;
      }
      name[$1] = newname;
      calls[$1] = $1;
    }
    else if ($0 !~ /^(!|#|$)/ && newname != "") {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
}
END { 
  printf("#0 CWOps Open database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  for (call in calls)
    printf("%s=%s\n", call, name[call]);
  printf("Overwrote %d duplicate entries.\n", dupes) > "/dev/stderr";
  printf("Longest name is \"%s\" (%d)\n", maxname, maxlen) > "/dev/stderr";
}