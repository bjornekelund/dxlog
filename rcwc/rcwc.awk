BEGIN {
  FS=" "
  last = 0;
}
{
  if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?(\/P)?$/ && $2 ~ /^[1-9][0-9]*$/) 
  {
    if (lines[$1] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr"
    }
    else
    {
      lines[$1] = $0;
      printf("%s=CM%s\n", $1, $2);
      if ($2 > last) last = $2;
    }
  }
  else if ($0 !~ /\-/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("#0 RCWC member database based on data from https://rcwc.ru/?do=members\n");
  printf("#2 Contains members up to #%d\n", last);
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
}
