BEGIN {
  printf("#00 UA1DZ Memorial Cup prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1|Loc1/) col = 2;
    if ($4 ~ /Exch1|Loc1/) col = 3;
    if ($5 ~ /Exch1|Loc1/) col = 4;
    printf("%s --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  }
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && ($col ~ /^[A-R]{2}[0-9]{2}$/ || $col ~ /^(LO|SP)/))
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($call ~ /^[RU]1[ABFGHJLM]|^R[A-Z]1[ABFGHJLM]|^U[A-I]1[ABFGHJLM]|^[RU]1[CDE]|^R[A-Z]1[CDE]|^U[A-I]1[CDE]/ && $call !~ /\/MM$/ && $col !~ /^(LO|SP)/)
    {
      printf("Ignored1: \"%s\"\n", $0) > "/dev/stderr";
    }
    else
    {
        printf("%s=%s\n", $call, $col);
        lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored2: \"%s\"\n", $0) > "/dev/stderr";
  }
}
