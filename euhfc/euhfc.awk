BEGIN {
  printf("#00 European HF Championship prefill database\n");
  printf("#01 Based on data from https://euhf.s5cc.eu/history_files\n");
  printf("#03 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if (IsValidCall($1) && $2 ~ /^(|[0-9]{2}$)/)
  {
    if (lines[$1] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $1, $2);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
