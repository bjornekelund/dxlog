BEGIN {
  FS=","
  printf("#0 DIG members database\n");
  printf("#1 Based on official member roster at https://diplom-interessen-gruppe.info \n");
  printf("#2 Updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[0-9]+$/ && $4 ~/^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/)
  {
    printf("%s=%s\n", $4, $3);
  }
  else if ($4 !~ /SWL|\-/ && $4 !~ /[0-9]$/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
