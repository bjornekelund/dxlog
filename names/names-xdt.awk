BEGIN {
  FS=","
  printf("#1 Operator names by VE2FK\n");
}
{
  call = toupper($1)
  if (call ~ /^[0-9A-Z/]+$/ && $2 ~ /^[A-Za-z .\-0-9]+$/) 
  {
    if ($3 != "" && $3 != " ")
      printf("%s %s, %s\n", call, $2, $3);
    else
      printf("%s %s\n", call, $2);
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }  
}
