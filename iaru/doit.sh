#!/bin/bash
FOLDER=zipfiles
ZIPFILE=$FOLDER/itu.zip
DBFILE=$FOLDER/iaruhq.txt
DOWNLOAD=$FOLDER/.downloaded.zip

XDTFILE=iaru*.xdt
OUTFILE=iaruhq.txt

#rm -rf $FOLDER
#rm -f $XDTFILE $OUTFILE
mkdir -p $FOLDER

# echo Downloading $ZIPFILE

wget -q https://bit.ly/itudtb -O $DOWNLOAD

if cmp -s $ZIPFILE $DOWNLOAD; then
    echo "Nothing new: IARU"
    rm -f $DOWNLOAD
    exit 0
fi

mv $DOWNLOAD $ZIPFILE
echo Unzipping $ZIPFILE

unzip -o $ZIPFILE -d $FOLDER

dos2unix -q $FOLDER/$OUTFILE

gawk '
BEGIN {
  printf("# HQ prefill database for IARU HF Championship\n");
  printf("# Data collected and maintained by Joe OZ0J and Bob N6TV\n");
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  printf("%s\n", $0);
}' $FOLDER/$OUTFILE > $OUTFILE

cp $FOLDER/$XDTFILE $XDTFILE
unix2dos -q $OUTFILE

echo Created $OUTFILE $XDTFILE

../_xdt/upload.sh $XDTFILE
../_helpers/copytosourcetree.sh $OUTFILE
../_helpers/uploaddb.sh $OUTFILE

exit 0
