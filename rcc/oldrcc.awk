BEGIN {
  FS=";"
  max = 0;
  printf("# RCC members prefill database\n");
  printf("# Based on http://rcccup.ru/information/rcc-members\n");
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[1-9]/ && $2 !~ / (SK|HQ)$/) 
  {
    mnr = $1
    call = $2
    ccall = $3
    printf("%s=RCC%s\n", call, mnr);
    if (ccall != "") printf("%s=RCC%s\n", ccall, mnr);
  }
  else
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
}
