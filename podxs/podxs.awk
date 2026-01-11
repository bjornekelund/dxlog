BEGIN {
  printf("#00 PODXS 070 members prefill database\n");
  printf("#01 Based on data from https://www.podxs070.com/member-files\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=",";
}
{
  if ($2 == "2EOKHP") $2="2E0KHP";
  if ($1 ~ /^[1-9][0-9]*$/ && $2 ~ /^^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/)
  {
    printf("%s=%s\n", $2, $1);
  }
  else if ($0 !~ /^(!|#|$)/ && $1 != "nr")
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
