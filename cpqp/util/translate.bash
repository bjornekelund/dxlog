#!/bin/bash
INFILE=`ls QSOP_CP-[^F]* | tail -1 2> /dev/null`
OUTFILE=QSOP_CP-FIXED.txt

echo Parsing $INFILE
dos2unix -q $INFILE

gawk 'BEGIN { FS = "," }
{
  if ($0 ~ /^(!|#|$)/) 
  {
    printf("%s\n", $0);
  }
  else if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|4U)/ && $3 !~ /^(SKG|CYP|CFL|CRR|EMW|EWE|RDM|CHA|DAU)$/) 
  {
    switch ($3)
    {
      case "BTL": ex = "BLM"; break;
      case "MOD": ex = "MOO"; break;
      case "PRA": ex = "PRI"; break;
      case "BAR": ex = "AIR"; break;
      case "CMD": ex = "CMI"; break;
      case "CSD": ex = "CSH"; break;
      case "CSH": ex = "CSG"; break;
      case "ERB": ex = "ERV"; break;
      case "GPM": ex = "GPR"; break;
      case "RDP": ex = "RED"; break;
      case "STA": ex = "SPK"; break;
      case "STR": ex = "STS"; break;
      case "BRS": ex = "BRA"; break;
      case "CHR": ex = "CHU"; break;      
      default: ex = $3; break;
    }
    printf("%s,%s,%s,%s\n", $1, $2, ex, $4);
    lines[$1] = $0;
  }
  else 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}' $INFILE > $OUTFILE

unix2dos -q $OUTFILE $INFILE
echo Created $OUTFILE

exit
