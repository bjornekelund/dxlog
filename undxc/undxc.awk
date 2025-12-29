BEGIN {
  FS=","
  printf("#0 UN DX Contest database\n");
  printf("#1 Credits to SP5KP and VE2FK for collecting and consolidating the data\n");
  printf("#2 Last updated %s\n", strftime("%Y-%m-%d"));
  col = 2;
}
{
  if ($1 ~ /!!Order!!/) 
  {
    if ($3 ~ /Exch1/) col = 2;
    if ($4 ~ /Exch1/) col = 3;
    if ($5 ~ /Exch1/) col = 4;
    printf("\"%s\" --> Exchange is in column %d\n", $0, col) > "/dev/stderr";
  } 
  else if ($1 ~ /^([A-Z1-9]+0?\/)?[1-9]?[A-Z]{1,2}[0-9]+[A-Z]+(\/[A-Z0-9]+)?$/ && $col ~ /^(A01|A02|A03|A04|A05|A06|B01|B02|B03|B04|B05|B06|B07|B08|B09|B10|B11|B12|B13|B14|B15|B16|B17|B18|B19|C01|C02|C03|C04|C05|C06|C07|C08|C09|C10|C11|C12|C13|C14|F01|F02|F03|F04|F05|F06|F07|F08|F09|F10|F11|F12|F13|G01|G02|G03|G04|G05|G06|G07|G08|I01|I02|I03|I04|I05|I06|I07|I08|I09|I10|I11|I12|I13|J01|J02|J03|J04|J05|J06|J07|J08|J09|J10|J11|J12|J13|J14|J15|J16|J17|J18|J19|J20|J21|K01|K02|K03|K04|K05|K06|K07|K08|K09|L01|L02|L03|L04|L05|L06|L07|L08|L09|L10|L11|L12|L13|L14|L15|L16|L17|L18|L19|L20|M01|M02|M03|M04|M05|M06|M07|M08|M09|M10|M11|M12|M13|N01|N02|N03|N04|N05|N06|N07|N08|N09|N10|N11|N12|N13|N14|N15|N16|O01|O02|O03|O04|O05|O06|O07|O08|P01|P02|P03|P04|P05|P06|P07|P08|P09|P10|P11|P12|P13|P14|P15|P16|P17|P18|Q01|Q02|Q03|Q04|Q05|Q06|Q07|Q08|Q09|Q10|Q11|Q12|Q13|Q14|Q15|Q16|Q17|Q18|Q19|T01|T02|T03|T04|T05|T06|T07|T08|T09|T10|T11|Z01|Z02|Z03|Z04)$/) 
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else 
    {
      printf("%s=%s\n", $1, $col);
      lines[$1] = $0;
    }
  }
  else if ($0 !~ /^(!|#|$)/) 
  {
    printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
  }
}
