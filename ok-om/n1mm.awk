BEGIN {
  printf("!!Order!!,Call,Exch1,\n");
  FS = "=";
}
{
  if ($0 ~ /^[A-Z][A-Z0-9]/)
  {
    printf("%s,%s,\n", $1, $2);
  }
  else
  {
    printf("%s\n", $0);
  }
}
