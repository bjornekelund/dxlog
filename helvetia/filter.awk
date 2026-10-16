BEGIN {
  printf("#00 Helvetia prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    canton = FindColumn("Misc|Exch1");
  # printf\("%s --> call=%d canton=%d\n", $0, call, canton) > "/dev/stderr";
  }
  else if (IsValidCall($call) && $canton ~ /^(AG|AI|AR|BE|BL|BS|FR|GE|GL|GR|JU|LU|NE|NW|OW|SG|SH|SO|SZ|TG|TI|UR|VD|VS|ZG|ZH)$/)
  {
    printf("%s=%s\n", $call, $canton);
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
