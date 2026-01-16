BEGIN {
  printf("#00 RCWC members prefill database based on data from https://rcwc.ru/?do=members\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = " ";
  max = 0;
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
      max = $2 > max ? $2 : max;
    }
  }
  else if ($0 !~ /\-/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr"
  }
}
END {
  printf("#01 Contains members up to #%d\n", max);
  printf("Highest member number is %d\n", max) > "/dev/stderr";
}
