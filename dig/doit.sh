#!/bin/bash
WEBFILE=DIGLISTE.csv
OUTFILE=DIG_db.txt
DOWNLOAD=.downloaded

#rm -f $WEBFILE
curl -fsSL --connect-timeout 5 --max-time 20 https://diplom-interessen-gruppe.info/fileadmin/downloads/DIGLISTE.csv -o $DOWNLOAD || {\
  echo "ERROR! Download of $WEBFILE failed. Aborting."
  rm -f $DOWNLOAD
  exit 1
}

dos2unix -q $DOWNLOAD

if cmp -s $WEBFILE $DOWNLOAD && [ -z "$1" ]; then
  echo "Nothing new: DIG"
  rm $DOWNLOAD
  exit 0
fi

mv $DOWNLOAD $WEBFILE

if [ ! -f $WEBFILE ] || [ $(stat -c%s $WEBFILE 2>/dev/null) -lt 1000 ]; then
  echo "ERROR! Download of $WEBFILE failed" $>2
  rm -f $WEBFILE
  exit 1
fi

echo Downloaded $WEBFILE, parsing...

dos2unix -q $WEBFILE
# cat $WEBFILE | sed 's/\"//g' | sort -t, -k3,3n -k1,1 | sed 's/\\N//g' | tee sorted.txt | gawk -f dig.awk | sort | sed 's/=0*/=/g' | sed 's/^#0. /# /g' > $OUTFILE
cat $WEBFILE | sed 's/\"//g' | sort -t, -k3,3n -k1,1 | sed 's/\\N//g' | gawk -f dig.awk | sort | sed 's/=0*/=/g' | sed 's/^#0. /# /g' > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit 0
