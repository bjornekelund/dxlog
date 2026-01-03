BEGIN {
  FS=","
  printf("#01@%s\n", strftime("%Y"));
  printf("#02 JARTS database for %s\n", strftime("%Y"));
  printf("#03 Data collected and maintained by Claude VE2FK\n");
  printf("#04 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#05 Last updated %s\n", strftime("%Y-%m-%d"));

}
{
  call = 1;
  col = 2;
  if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^[0-9]{1,2}?$/) 
  {
    if (lines[$1] != "")
      printf("Repeated: \"%s\" and \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    else
      printf("%s,%s,\n", $1, $col);
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
