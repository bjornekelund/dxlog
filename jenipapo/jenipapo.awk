BEGIN {
  FS=","
  printf("#0 Prefill database for Contest Batalha do Jenipapo\n");
  printf("#1 NB! Only contains calls not covered by rgx file\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($0 ~ "!!Order!!") {
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } else if ($1 ~ /^[A-Z0-9]/ && $col ~ /^(DX|HQ|MIL|QRP|YL|BJ|BP|AC|AL|AP|AM|BA|CE|DF|ES|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RJ|RS|RO|RN|RR|SC|SP|SE|TO)$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else if ($1 !~ /^(PU8[J-L]|PT8|PU7[A-D]|PP7|PU8[A-C]|PP8|PU8[G-I]|PQ8|PU6[J-Y]|PY6|PU7[M-P]|PT7|PU2[A-E]|PT2|PU1[A-I]|PP1|PU2[F-H]|PP2|PU4[A-Y]|PY4|PU9[A-N]|PT9|PU8[M-O]|PR8|PU9[O-Y]|PY9|PU8[W-Y]|PY8|PU7[E-H]|PR7|PU7[R-Y]|PY7|PU8[P-S]|PS8|PU5[M-Y]|PY5|PU1[J-Y]|PY1|PU7[I-L]|PS7|PU8[D-F]|PW8|PU8[T-V]|PV8|PU3[A-Y]|PY3|PU5[A-L]|PP5|PU6[A-I]|PP6|PU2[K-Y]|PY2|PU2[I-J]|PQ2)/) {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
    else 
    #if ($0 !~ /^(!|$)/) {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
 

