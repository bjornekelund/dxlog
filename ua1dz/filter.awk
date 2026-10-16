BEGIN {
  printf("#00 UA1DZ Memorial Cup prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Exch1");
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if (IsValidCall($call) && ($exch ~ /^[A-R]{2}[0-9]{2}$/ || $exch ~ /^(LO|SP)/))
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else if ($call ~ /^[RU]1[ABFGHJLM]|^R[A-Z]1[ABFGHJLM]|^U[A-I]1[ABFGHJLM]|^[RU]1[CDE]|^R[A-Z]1[CDE]|^U[A-I]1[CDE]/ && $call !~ /\/MM$/ && $exch !~ /^(LO|SP)/)
    {
      printf("Ignored1: \"%s\"\n", $0) > "/dev/stderr";
    }
    else
    {
        printf("%s=%s\n", $call, $exch);
        lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored2: \"%s\"\n", $0) > "/dev/stderr";
  }
}
