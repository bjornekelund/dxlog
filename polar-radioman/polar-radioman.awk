BEGIN {
  FS=","
  printf("# Members of International Radio Club ARKTIKA\n");
  printf("# Data provided by Oleg RA9JM\n");
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  call = toupper($1)
  number = toupper($2)
  if (call ~ /^[0-9,A-Z,\/]+$/ && number ~ /^AC[0-9]+$/) {
    printf("%s=%s\n", call, number);
  }
  else if ($0 !~ /^(#|!|$)/)
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
}
