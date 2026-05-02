BEGIN {
  printf("#00 UN DX Contest prefill database\n");
  printf("#01 Credits to SP5KP and VE2FK for collecting and consolidating the data\n");
  printf("#02 Last updated %s\n", strftime("%Y-%m-%d"));
  FS = ",";
}
{
  if ($1 ~ /!!Order!!/)
  {
    if ($2 ~ /Call/) call = 1;
    if ($3 ~ /Call/) call = 2;
    if ($4 ~ /Call/) call = 3;
    if ($5 ~ /Call/) call = 4;
    if ($3 ~ /Sect/) col = 2;
    if ($4 ~ /Sect/) col = 3;
    if ($5 ~ /Sect/) col = 4;
    printf("\"%s\" --> call=%d col=%d\n", $0, call, col) > "/dev/stderr";
  }
  else {
    if ($col =="J08") dist = "D01";  else
    if ($col =="J12") dist = "D03";  else
    if ($col =="J17") dist = "D03";  else
    if ($col =="J01") dist = "D04";  else
    if ($col =="J02") dist = "D05";  else
    if ($col =="J09") dist = "D07";  else
    if ($col =="J10") dist = "D08";  else
    if ($col =="J15") dist = "D10";  else
    if ($col =="J19") dist = "D12";  else
    if ($col =="J20") dist = "J02";  else
    if ($col =="J13") dist = "J12";  else
    if ($col =="J14") dist = "J13";  else
    if ($col =="P14") dist = "P10";  else
    if ($col =="P15") dist = "P12";  else
    if ($col =="P17") dist = "P13";  else
    if ($col =="P18") dist = "P14";  else
    if ($col =="Q02") dist = "Q01";  else
    if ($col =="Q14") dist = "Q02";  else
    if ($col =="Q10") dist = "Q03";  else
    if ($col =="Q12") dist = "Q05";  else
    if ($col =="Q16") dist = "Q06";  else
    if ($col =="Q13") dist = "Q07";  else
    if ($col =="Q15") dist = "Q08";  else
    if ($col =="Q11") dist = "Q09";  else
    if ($col =="P07") dist = "R01";  else
    if ($col =="P06") dist = "R02";  else
    if ($col =="P12") dist = "R03";  else
    if ($col =="P13") dist = "R04";  else
    if ($col =="P16") dist = "R05";  else
    if ($col =="K09") dist = "S01";  else
    if ($col =="Q04") dist = "V01";  else
    if ($col =="Q01") dist = "V02";  else
    if ($col =="Q07") dist = "V03";  else
    if ($col =="Q08") dist = "V04";  else
    if ($col =="Q06") dist = "V05";  else
    if ($col =="Q03") dist = "V06";  else
    if ($col =="Q09") dist = "V07";  else
    if ($col =="Q05") dist = "V08";  else
    if ($col =="Q17") dist = "V09";  else
    if ($col =="Q19") dist = "V10";  else
    if ($col == "I13") dist = ""; else	
    if ($col == "J05") dist = ""; else	
    if ($col == "J16") dist = ""; else	
    if ($col == "J18") dist = ""; else	
    if ($col == "J21") dist = ""; else	
    if ($col == "N05") dist = ""; else	
    if ($col == "N13") dist = ""; else	
    if ($col == "P10") dist = ""; else	
    if ($col == "Q18") dist = ""; else dist = $col;
    if ( \
      $call ~ /^U[NOPQ][0-9]{1,2}[A-Z]{1,3}(\/[AMP0-9])?$/ && \
      dist ~ /^(A01|A02|A03|A04|A05|A06|A07|B01|B02|B03|B04|B05|B06|B07|B08|B09|B10|B11|B12|B13|B14|B15|B16|B17|B18|B19|B20|C01|C02|C03|C04|C05|C06|C07|C08|C09|C10|C11|C12|C13|C14|D01|D02|D03|D04|D05|D06|D07|D08|D09|D10|D11|D12|F01|F02|F03|F04|F05|F06|F07|F08|F09|F10|F11|F12|F13|G01|G02|G03|G04|G05|G06|G07|G08|I01|I02|I03|I04|I05|I06|I07|I08|I09|I10|I11|I12|I13|I14|J01|J02|J03|J04|J05|J06|J07|J08|J09|J10|J11|J12|J13|K01|K02|K03|K04|K05|K06|K07|K08|L01|L02|L03|L04|L05|L06|L07|L08|L09|L10|L11|L12|L13|L14|L15|L16|L17|L18|L19|L20|M01|M02|M03|M04|M05|M06|M07|M08|M09|M10|M11|M12|M13|N01|N02|N03|N04|N05|N06|N07|N08|N09|N10|N11|N12|N13|N14|N15|N16|N17|N18|N19|N20|N21|N22|O01|O02|O03|O04|O05|O06|O07|O08|P01|P02|P03|P04|P05|P06|P07|P08|P09|P10|P11|P12|P13|P14|Q01|Q02|Q03|Q04|Q05|Q06|Q07|Q08|Q09|Q10|Q11|R01|R02|R03|R04|R05|S01|T01|T02|T03|T04|T05|T06|T07|T08|T09|T10|T11|T12|V01|V02|V03|V04|V05|V06|V07|V08|V09|V10|Z01|Z02|Z03|Z04|Z05|Z06)$/)
    {
      if (lines[$call] != "")
      {
        printf("\"%s\" reoccurs as \"%s\"\n", lines[$call], $0) > "/dev/stderr";
      }
      else
      {
        printf("%s=%s\n", $call, dist);
        lines[$call] = $0;
      }
    }
    else if ($0 !~ /^(!|#|$)/)
    {
      printf("Ignored: \"%s\"\n", $0) > "/dev/stderr";
    }
  }
  
}
