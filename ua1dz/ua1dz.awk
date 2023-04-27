BEGIN {
  FS=","
  printf("#0 UA1DZ Memorial Cup database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($0 ~ "!!Order!!") {
    if ($2 ~ /Exch1/) col = 1;
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else if ($1 ~ /^[0-9,A-Z,\/]+$/ && ($col ~ /^[A-R]{2}[0-9]{2}$/ || $col ~ /^(LO|SP)/)) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ($1 ~ /^[RU]1[ABFGHJLM]|^R[A-Z]1[ABFGHJLM]|^U[A-I]1[ABFGHJLM]|^[RU]1[CDE]|^R[A-Z]1[CDE]|^U[A-I]1[CDE]/ && $col !~ /^(LO|SP)/) {
      printf("Bad exchange: \"%s\"\n", $0) > "/dev/stderr";
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
