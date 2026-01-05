BEGIN {
  FS="=";
}
{
  if (call[$1] != "" && $0 !~ /^#/) 
  {
    printf("Duplicate entry: \"%s\"\n", $0) > "/dev/stderr";
  }
  call[$1] = $1;
  if ($0 ~ /=$/ || $3 != "") 
  {
    printf("Problem exchange: \"%s\"\n", $0) > "/dev/stderr";
  }
  else {
    if ($0 !~ /^#/) 
    {
      if ($2 !~ /^[A-Z]{2}[0-9]{2}$/) 
      {
        printf("Problem exchange: \"%s\" in \"%s\"\n", $2, $0) > "/dev/stderr";
      }
    }
  }
}
