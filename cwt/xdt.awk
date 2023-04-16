BEGIN {
  FS=","
  printf("#TITLE CWOps members\n");
}
{
  call = $1;
  name = $2;
  ID = toupper($3);
#  printf("call=\"%s\", name=\"%s\"\n", call, ID) > "/dev/stderr";
  if (call ~ /^[0-9A-Z]/ && ID ~ /^[0-9]+$/) {
    printf("%s %s #%s %s\n", call, name, ID, $4);
  }
}
END {}
