BEGIN {
  printf("#0 UK EI CC database with six-position grids\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($0 ~ "!!Order!!") {
    if ($3 ~ /Loc1/) col = 2;
    if ($4 ~ /Loc1/) col = 3;
    if ($5 ~ /Loc1/) col = 4;
    printf("\"%s\" --> Exchange column is %d\n", $0, col) > "/dev/stderr";
  } 
  else {
    if ($1 ~ /^[0-9A-Z/]+$/ && $col ~ /^[A-Ra-r]{2}[0-9]{2}[A-Xa-x]{2}$/) {
      if (lines[$1] != "") {
        printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
      }
      else {
        printf("%s=%s\n", $1, $col);
        lines[$1] = $0;
      }
    }
    else if ($0 !~ /^(!|#|$)/) {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  } 
}
