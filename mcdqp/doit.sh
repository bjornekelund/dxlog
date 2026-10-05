#!/bin/bash
WEBFILE=List_Members_MC.csv
OUTFILE=MCD_db.txt
DOWNLOAD=.downloaded

# rm -f $WEBFILE
curl -fsSL --connect-timeout 5 --max-time 20 https://www.marconiclub.it/List_Members_MC.csv -o $DOWNLOAD || {\
  echo "ERROR! Download of member data failed. Aborting." 
  rm -f $DOWNLOAD
  exit 1
}

if [ ! -f $DOWNLOAD ] || [ $(stat -c%s $DOWNLOAD 2>/dev/null) -lt 200 ]; then
  echo "ERROR! Download of member data failed. Aborting." 
  rm -f $DOWNLOAD
  exit 1
else
  dos2unix -q $DOWNLOAD
  if cmp $WEBFILE $DOWNLOAD; then 
    echo "The latest member data file is already downloaded."
    rm -f $DOWNLOAD
  else
    echo Downloaded $WEBFILE, parsing...
    mv $DOWNLOAD $WEBFILE
    dos2unix -q $WEBFILE
    sed 's/ //g' $WEBFILE |\
        iconv -f ISO-8859-1 -t ASCII//TRANSLIT |\
        gawk -f mcdqp.awk | sort | sed 's/^#0. /# /g' > $OUTFILE
    echo Created $OUTFILE
    unix2dos -q $OUTFILE
    if [ -s ../copytosourcetree.sh ]; then
        ../copytosourcetree.sh $OUTFILE
    fi
  fi
fi

exit
