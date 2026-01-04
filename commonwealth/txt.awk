BEGIN {
  printf("#00 Commonwealth Contest HQ stations database\n");
  printf("#01 Data collected and maintained by Claude VE2FK\n");
  printf("#02 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS=","
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /State/) state = 2;
    if ($4 ~ /State/) state = 3;
    if ($5 ~ /State/) state = 4;
    printf("%s --> call=%d state=%d\n", $0, call, state) > "/dev/stderr";
  }
  else if ($call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $state == "HQ")
  {
    printf("%s=%s\n", $1, $3);
  }
}
