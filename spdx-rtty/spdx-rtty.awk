BEGIN {
  FS=","
  max = 0;
}
{
  if ($1 ~ /^[0-9A-Z\/]+$/ && $2 ~ /^[A-Za-z]{2}$/)
#  if ($1 ~ /^[0-9A-Z\/]+$/)
  printf("%s=%s\n", $1, toupper($2));
  else
    printf("Ignored: %s\n", $0) > "/dev/stderr";
}
END { 
  printf("#0 SP DX RTTY participants database\n");
  printf("#1 Based on call history data by Chris SP5KP, SN5N\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
}