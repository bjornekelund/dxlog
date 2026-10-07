#!/bin/bash
#INFILE=`ls FISTSSPR[^_]* | tail -1 2> /dev/null`
OLDFILE=FISTSSPR-OLD.txt
# NAMESFILE=`ls ../names/Names_VE2FK* | tail -1 2> /dev/null`
# CWTFILE=`ls ../cwt/CWOPS_* | tail -1 2> /dev/null`
# SSFILE=`ls ../arrlss/SSCW* | tail -1 2> /dev/null`
# NAQPFILE=`ls ../naqp/NAQPC* | tail -1 2> /dev/null`

WEBFILE=fistsmembers.csv

OUTFILE=FISTSSPR_db.txt
# NAMEFILE=.names
# LOCFILE=.locs
# MEMFILE=.members
DOWNLOAD=.downloaded

rm -f $DOWNLOAD
curl -sS https://fists.co.uk/docs/$WEBFILE -o $DOWNLOAD

if [ ! -f $DOWNLOAD ] || [ $(stat -c%s $DOWNLOAD 2>/dev/null) -lt 1000 ]; then
  echo "ERROR! Download of $WEBFILE failed. Aborting."
  rm -f $DOWNLOAD
  exit 1
else

  dos2unix -q $DOWNLOAD
  if cmp -s $WEBFILE $DOWNLOAD && [ -z $1 ]; then 
      echo "The latest db file is already downloaded."
      rm -f $DOWNLOAD
      exit 0
  fi
  mv $DOWNLOAD $WEBFILE


  # echo Downloaded $WEBFILE, creating $INFILE...

  # dos2unix -q $WEBFILE $OLDFILE
  # sed -i '1i\' $WEBFILE

  # echo Parsing $WEBFILE $OLDFILE $NAMESFILE $CWTFILE $SSFILE $NAQPFILE
  # dos2unix -q $WEBFILE $OLDFILE $NAMESFILE $CWTFILE $SSFILE $NAQPFILE

  # gawk 'BEGIN{FS = ",";printf("!!Order!!,Misc,Call,Name,NEWFILE\n");}{if ($0 ~ /^[0-9]/)printf("%s\n", $0);}' $WEBFILE > $MEMFILE
  # gawk 'BEGIN{FS = ",";printf("!!Order!!,Call,Name,xxx,OLDFILE\n");}{if ($0 ~ /^[A-Z0-9]/)printf("%s\n", $0);}' $OLDFILE >> $MEMFILE
  # gawk 'BEGIN{FS = ",";printf("!!Order!!,Call,Name,NAMEFILE-NAMES\n");}{if ($0 ~ /^[A-Z0-9]/ && $2 ~ /^[A-Za-z]+/)printf("%s,%s\n", $1, $2);}' $NAMESFILE > $NAMEFILE
  # gawk 'BEGIN{FS = ",";printf("!!Order!!,Call,Name,NAMEFILE-CWT\n");}{if ($0 ~ /^[A-Z0-9]/ && $2 ~ /^[A-Za-z]+/)printf("%s,%s\n", $1, $2);}' $CWTFILE >> $NAMEFILE
  # gawk 'BEGIN{FS = ",";printf("!!Order!!,Call,Exch1,LOCFILE-SS\n");}{if ($0 ~ /^[A-Z0-9]/ && $3 ~ /^[A-Z]+/)printf("%s,%s\n", $1, $3);}' $SSFILE > $LOCFILE
  # gawk 'BEGIN{FS = ",";printf("!!Order!!,Call,Name,Exch1,LOCFILE-NAQP\n");}{if ($0 ~ /^[A-Z0-9]/ && $3 ~ /^[A-Z]+/)printf("%s,%s,%s\n", $1, $2, $3);}' $NAQPFILE >> $LOCFILE

  # cat $MEMFILE $OLDFILE $NAMEFILE $LOCFILE | gawk -f fistsspr.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

  # unix2dos -q $OUTFILE
  # echo Created $OUTFILE


  echo Downloaded $WEBFILE, creating $OUTFILE...

  dos2unix -q $WEBFILE
  # sed -i '1i\' $WEBFILE

  echo Parsing $WEBFILE
  
  cat $WEBFILE | gawk -f fistsspr.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

  unix2dos -q $OUTFILE
  echo Created $OUTFILE

  if [ -s ../copytosourcetree.sh ]; then
    ../copytosourcetree.sh $OUTFILE
  fi
fi
exit
