BEGIN {
  FS=","
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
    else {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($0 ~ /^#/) {
      printf("%s\n", $0);
  }
  else if ($0 !~ /^(!|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
 

