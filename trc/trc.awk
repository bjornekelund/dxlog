BEGIN {
  FS=","
  printf("#0 TRC members database\n");
  printf("#1 Data collected and maintained by Chris SP5KP\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 == "!!Order!!") {
    if ($3 == "Sect) col = 2;
    if ($4 == "Sect") col = 3;
    if ($5 == "Sect") col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else if ($col ~ /^TRC$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
