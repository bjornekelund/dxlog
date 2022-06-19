#!/bin/bash
FOLDER=zipfiles
ZIPFILE=$FOLDER/itu.zip
TMPFILE=.iaruhq
OUTFILE=iaruhq.txt

mkdir -p $FOLDER

echo Downloading $ZIPFILE

wget -q https://bit.ly/itudtb -O $ZIPFILE

echo Unzipping $ZIPFILE

unzip -o $ZIPFILE -d $FOLDER 

cp $FOLDER/$OUTFILE $TMPFILE

dos2unix -q $TMPFILE

gawk '
BEGIN {
  printf("# HQ database for IARU HF Championship\n");
  printf("# Data collected and maintained by Joe OZ0J and Bob N6TV\n");
  printf("# Last updated %s\n", strftime("%Y-%m-%d"));
}
{
  printf("%s\n", $0);
}' $TMPFILE > $OUTFILE

unix2dos -q $OUTFILE
echo Created $OUTFILE

exit
