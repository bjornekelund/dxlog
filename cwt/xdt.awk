BEGIN {
  FS=","
  printf("#TITLE CWOps members\n");
}
{
  call = $1;
  name = $2;
  ID = toupper($3);
  info = $4;
  # printf("call=\"%s\", name=\"%s\" ID=\"%s\" info=\"%s\"\n", call, name, ID, info) > "/dev/stderr";
  if (call ~ /^[0-9A-Z]/ && ID ~ /^[0-9]+$/) 
  {
    printf("%s %s #%s %s\n", call, name, ID, info);
  }
  else if ($0 !~ /^(#|$)/ && ID !~ /[A-Z]|^$/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
