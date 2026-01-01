BEGIN {
  FS=","
  printf("#00 DIG members database\n");
  printf("#01 Based on official member roster at https://diplom-interessen-gruppe.info \n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  if ($1 ~ /^[0-9]+$/ && $4 ~/^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+$/ && $4 !~ /^DE/)
  {
    basecall = $4;
    memberid = $3;
    
    printf("%s=%s\n", $4, $3);

    if ($5 != "")
    {
      extra = split($5, words, " ")
      for (i = 1; i <= extra; i++) 
      {
        if (words[i] ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+$/ && words[i] !~ /^DE/)
        {
          printf("%s=%s\n", words[i], $3);
#          printf("\$4=\"%s\" \$5=\"%s\" => words[%d]=\"%s\"\n", $4, $5, i, words[i]) > "/dev/stderr";
        }
      }
    }
  }
  else if ($4 !~ /SWL|\-/ && $4 !~ /^DE|[0-9]$/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
