#!/bin/bash
FILE=`ls ../naqp/NAQP[^_]* | tail -1 2> /dev/null`
OUTFILE=QSOP_AC.txt

echo Parsing $FILE
dos2unix -q $FILE

gawk 'BEGIN {
  printf("!!Order!!,Call,Name,Exch1,UserText,\n");
  FS = ",";
}
{
  if ($0 ~ "!!Order!!") 
  {
    name = 2;
    exch = 3;
    call = 1;
  } else if ($1 ~ /^(A[A-L]|K[A-Z]?[0-9]|N[A-Z]?[0-9]|W[A-Z]?[0-9]|V[A-EOXY]|4U)/ && $exch ~ /^(DX|AL|AK|AZ|AR|CA|CO|CT|DC|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MA|MD|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY|QC|ON|MB|SK|AB|BC|NT|NU|YT|NLASJ|NLBMT|NLSCB|NLSGS|NLHCB|NLGFW|NLBTC|NLNDL|NLNSA|NLLGB|NLLNN|PEKGS|PEQNS|PEPRN|NBALB|NBCAR|NBCHA|NBGLO|NBKEN|NBKGS|NBMAD|NBNOR|NBQNS|NBRES|NBSJC|NBSUN|NBVIC|NBWES|NBYOR|NSANP|NSATG|NSCBR|NSCOL|NSCMB|NSDIG|NSGUY|NSHRM|NSHNT|NSINV|NSKGS|NSLUN|NSPIC|NSQNS|NSRIC|NSSHL|NSVIC|NSYAR)$/) 
  {
    if (lines[$1] != "") 
    {
      printf("\"%s\" reoccurs as \"%s\"\n", lines[$1], $0) > "/dev/stderr";
    }
    else
    {
      printf("%s,%s,%s,\n", $1, $name, $exch);
      lines[$1] = $0;
    }
  }
  else if ($exch != "") 
  {
#    printf("%s\n", $0);
  }
}' $FILE | sort | sed 's/#. /# /g' > $OUTFILE

echo Created $OUTFILE
unix2dos -q $OUTFILE

exit
