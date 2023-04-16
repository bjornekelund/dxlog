BEGIN {
  FS=",";
  prevcall = "zz";
}
{
  call = $1;
  reg = toupper($2);
  lineok = call ~ /[0-9A-Z]{3,}/ && reg ~ /^[A-Z]{2}[0-9]{2}$/
  if ($0 ~ /^#/) {
    printf("%s\n", $0);
  }
  else if (lineok && call != prevcall) {
    printf("%s=%s\n", call, reg);
  }
 else if ($0 !~ /^(!|#|$)/){
    printf("%s %s\n", call == prevcall ? "Dupe   :" : "Ignored:", $0) > "/dev/stderr";
 }
  prevcall = call;
}
