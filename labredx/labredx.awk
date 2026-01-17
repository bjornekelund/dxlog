BEGIN {
  printf("#00 LABRE DX Contest prefill database\n");
  printf("#01 Based on data maintained by Claude VE2FK\n");
  printf("#02 Contains only calls not handled by rule-based prefill\n");
  printf("#03 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Exch1/) exch = 2;
    if ($4 ~ /Exch1/) exch = 3;
    if ($5 ~ /Exch1/) exch = 4;
    printf("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if ( \
    $call ~ /^(P[P-Y]|Z[VWXY])[1-9]{1}[A-Z]{1,3}(\/(P[TUVY][1-9]|[0-9]))?$/ && \
    $exch ~ /^(AC|AL|AP|AM|BA|CE|DF|ES|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RJ|RN|RS|RO|RR|SC|SP|SE|TO)$/)
  {
    if (line[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      guess = "";
      if ($call ~ /^PU8[J-L]|^PT8/) guess = "AC";
      if ($call ~ /^PU7[A-D]|^PP7/) guess = "AL";
      if ($call ~ /^PU8[A-C]|^PP8/) guess = "AM";
      if ($call ~ /^PU8[G-I]|^PQ8/) guess = "AP";
      if ($call ~ /^PU6[J-Y]|^PY6/) guess = "BA";
      if ($call ~ /^PU7[M-P]|^PT7/) guess = "CE";
      if ($call ~ /^PU2[A-E]|^PT2/) guess = "DF";
      if ($call ~ /^PU1[A-I]|^PP1/) guess = "ES";
      if ($call ~ /^PU2[F-H]|^PP2/) guess = "GO";
      if ($call ~ /^PU4[A-Y]|^PY4/) guess = "MG";
      if ($call ~ /^PU9[A-N]|^PT9/) guess = "MS";
      if ($call ~ /^PU8[M-O]|^PR8/) guess = "MA";
      if ($call ~ /^PU9[O-Y]|^PY9/) guess = "MT";
      if ($call ~ /^PU8[W-Y]|^PY8/) guess = "PA";
      if ($call ~ /^PU7[E-H]|^PR7/) guess = "PB";
      if ($call ~ /^PU7[R-Y]|^PY7/) guess = "PE";
      if ($call ~ /^PU8[P-S]|^PS8/) guess = "PI";
      if ($call ~ /^PU5[M-Y]|^PY5/) guess = "PR";
      if ($call ~ /^PU1[J-Y]|^PY1/) guess = "RJ";
      if ($call ~ /^PU7[I-L]|^PS7/) guess = "RN";
      if ($call ~ /^PU8[D-F]|^PW8/) guess = "RO";
      if ($call ~ /^PU8[T-V]|^PV8/) guess = "RR";
      if ($call ~ /^PU3[A-Y]|^PY3/) guess = "RS";
      if ($call ~ /^PU5[A-L]|^PP5/) guess = "SC";
      if ($call ~ /^PU6[A-I]|^PP6/) guess = "SE";
      if ($call ~ /^PU2[K-Y]|^PY2/) guess = "SP";
      if ($call ~ /^PU2[G-J]|^PQ2/) guess = "TO";

      # printf("%s: $exch=\"%s\" guess=\"%s\"\n", $call, $exch, guess) > "/dev/stderr"

      if (guess != $exch)
      {
        printf("%s=%s\n", $call, $exch);
        line[$1] = $0;
      }
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $exch !~ /^(NA|EU|AS|AF|SA)$/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
