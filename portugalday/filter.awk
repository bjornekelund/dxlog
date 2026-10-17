BEGIN {
  printf("#00 Portugal Day Contest prefill database\n");
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    call = FindColumn("Call");
    exch = FindColumn("Sect|Exch1");
  # printf\("%s --> call=%d exch=%d\n", $0, call, exch) > "/dev/stderr";
  }
  else if (IsValidCall($call) && \
    $exch ~ /^(AH|AV|BG|BJ|BR|CA|CA|CB|CM|CO|CV|EV|FC|FR|FU|GD|HT|LG|LR|LX|LJ|LJ|MC|MD|ND|PD|PG|PM|PO|PS|PT|PT|PV|RB|RG|SC|SC|SC|SR|SR|ST|ST|SV|VC|VL|VP|VR|VS)$/)
  {
    if (lines[$call] != "")
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s=%s\n", $call, ($exch ~ /^[1-9]$/) ? "0" $exch : $exch);
      lines[$call] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/)
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
