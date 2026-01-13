BEGIN {
  printf("#TITLE CWOps members\n");
  FS = ",";
}
{
  call = $1;
  name = $2;
  ID = toupper($3);
  info = $4;
  # printf("call=\"%s\", name=\"%s\" ID=\"%s\" info=\"%s\"\n", call, name, ID, info) > "/dev/stderr";
  if (call ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && ID ~ /^[0-9]+$/) 
  {
    printf("%s %s #%s %s\n", call, name, ID, info);
  }
  else if ($0 !~ /^(#|$)/ && ID !~ /[A-Z]|^$/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
