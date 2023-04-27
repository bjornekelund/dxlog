BEGIN {
  FS=","
  printf("# Members of International Radio Club ARKTIKA\n");
  printf("# Data provided by Oleg RA9JM\n");
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  call = $1;
  number = $2;
  if (call ~ /^[0-9,A-Z,\/]+$/ && number ~ /^AC[0-9]+$/) {
    if (lines[$1] != "") {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else {
      printf("%s=%s\n", call, number);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(#|!|$)/) {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
