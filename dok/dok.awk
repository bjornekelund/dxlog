BEGIN {
  FS=","
  printf("#0 German DOK database\n");
  printf("#1 Data collected and maintained by Claude VE2FK\n");
  printf("#2 Report updates and corrections directly to ve2fk@arrl.net\n");
  printf("#3 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
  max = 0;
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Sect/) col = 2;
    if ($4 ~ /Sect/) col = 3;
    if ($5 ~ /Sect/) col = 4;
    printf("%s --> Exchange column is %d\n", $0, col) > "/dev/stderr";
  } 
  else if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^[A-Z0-9]+$/) 
  {
    printf("%s=%s\n", $1, $col);
    if (length($col) > max) 
    {
      longest = $col;
      max = length($col);
    }
  }
  else if ($0 !~ /^(!|#|$)/ && $col != "") 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("Longest DOK is %s with %d characters.\n", longest, max) > "/dev/stderr"; 
  printf("#4 Longest DOK is %s with %d characters.\n", longest, max); 
}