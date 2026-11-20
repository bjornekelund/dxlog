OLDFILE=FISTSSPR-OLD.txt

WEBFILE=fistsmembers.csv

OUTFILE=FISTSSPR_db.txt
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
      echo "Nothing new: FISTS"
      rm -f $DOWNLOAD
      exit 0
  fi
  mv $DOWNLOAD $WEBFILE

  echo Downloaded $WEBFILE, creating $OUTFILE...

  dos2unix -q $WEBFILE
  # sed -i '1i\' $WEBFILE

  echo Parsing $WEBFILE
  
  cat $WEBFILE | gawk -f fistsspr.awk | sort | sed 's/^#0. /# /g' > $OUTFILE

  unix2dos -q $OUTFILE
  echo Created $OUTFILE

  ../_helpers/copytosourcetree.sh $OUTFILE
  ../_helpers/uploaddb.sh $OUTFILE
fi

exit 0
