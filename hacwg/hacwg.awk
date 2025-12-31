BEGIN {
  FS=","
  printf("#0 HACWG members database\n");
  printf("#1 Data collected and maintained by HA3NU\n");
  printf("#2 Report updates and corrections directly to ha3nu@dx.hu\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($2 ~ /Misc/) col = 1;
    if ($3 ~ /Misc/) col = 2;
    if ($4 ~ /Misc/) col = 3;
    if ($5 ~ /Misc/) col = 4;
    printf("%s --> col=%d\n", $0, col) > "/dev/stderr";
  } 
  else 
  {
    if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^[1-9][0-9]*$/) 
    {
      if (lines[$1] != "") 
      {
        printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
      }
      else 
      {
        printf("%s=%s\n", $1, $col);
        lines[$1] = $0;
      }
    }
    else if ($0 !~ /^(!|#|$)/ && $col != "") 
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  } 
}
