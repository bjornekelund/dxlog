BEGIN {
  FS=","
  max = 0;
  printf("#0 DIG members database\n");
  printf("#1 Based on official member roster at https://diplom-interessen-gruppe.info \n");
  printf("#2 Updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($3 ~ /^[0-9]+$/ && $4 ~/^[A-Z0-9/]+$/)
    printf("%s=%s\n", $4, $3);
  else if ($4 !~ /SWL|\-/)
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END {
}
