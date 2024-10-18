BEGIN {
  FS=","
  col = 2;
}
{
  if ($0 ~ /^(#|!)/) {
    printf("%s\n", $0);
  } 
  else  {
    printf("%s,%s,\n", $1, $2);
  }
}
