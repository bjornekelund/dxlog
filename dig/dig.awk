BEGIN {
  printf("#00 DIG members prefill database\n");
  printf("#01 Based on official member roster at https://diplom-interessen-gruppe.info \n");
  printf("#04 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
  max = 0;
}
{
  memberid = $3;
  basecall = $4;
  other = $5;
  if (memberid ~ /^[0-9]+$/ && basecall ~/^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]{1,2}[A-Z]{1,3}$/ && basecall !~ /^DE/)
  {    
    printf("%s=%s\n", basecall, memberid);
    max = memberid > max ? memberid : max;
    if (other != "")
    {
      count = split(other, othercall, " ")
      for (i = 1; i <= count; i++) 
      {
        if (othercall[i] ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]{1,2}[A-Z]{1,3}$/ && othercall[i] !~ /^DE/)
        {
          printf("%s=%s\n", othercall[i], memberid);
          # printf("$4=\"%s\" $5=\"%s\" => call[%d]=\"%s\"\n", $4, $5, i, call[i]) > "/dev/stderr";
        }
        else if (othercall[i] !~ /SWL|\-|^DE|[0-9]$/)
        {
          # printf("Ignored other call: \"%s\" in \"%s\"\n", othercall[i], $0) > "/dev/stderr";
        }
      }
    }
  }
  else if (basecall !~ /SWL|\-|^DE|[0-9]$/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
END {
  printf("#03 Contains members up to #%d\n", max);
  printf("Highest member number is %d\n", max) > "/dev/stderr";
}

#  else if (basecall !~ /SWL|\-|^DE|[0-9]$/)
