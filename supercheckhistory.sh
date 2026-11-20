#!/usr/bin/env bash
export LANG=C.UTF-8
AWKFILE="filter.awk"
TMPFILE1=".downloaded"
TMPFILE2=".tmpoutfile"
HELPERS="../_helpers/helpers.awk"
BASEFILE="BASEFILE.txt"
TIMEOUT=30

DIR=$(pwd)

if [ ! -d $1 ]; then
  exit 0
fi

cd $1

if [ ! -s schfile.txt ]; then
  exit 0
  cd $DIR
fi


if [ -s "schfile.txt" ] && [ -s "dbfile.txt" ]; then
  SCHFILE="$(cat schfile.txt)"
  DBFILE="$(cat dbfile.txt)"
  ETAGFILE=$SCHFILE".etag"
  ETAGTMP="."$ETAGFILE
  URL="https://supercheckhistory.com/downloads/N1MM/$SCHFILE"
  # curl -fsSL --connect-timeout 5 --max-time 20 "$URL" -o "$TMPFILE1" || {\
  #   echo "ERROR! Download of $SCHFILE failed. Aborting."
  #   rm -f $TMPFILE1

 
  # Keep temporary files beside their destinations so mv stays on the same filesystem.

  trap 'rm -f "$TMPFILE1" "$ETAGTMP"' EXIT

  if ! status=$(curl --silent --show-error --location --fail \
      --etag-compare "$ETAGFILE" \
      --etag-save "$ETAGTMP" \
      --output "$TMPFILE1" \
      --write-out '%{http_code}' \
      "$URL"); then
      echo "Download failed: $URL" >&2
      exit 1
  fi

  case "$status" in
      304)
          echo "Nothing new: $SCHFILE"
          rm -f $ETAGTMP
          ;;
      2[0-9][0-9])
          mv "$TMPFILE1" "$SCHFILE"
          mv "$ETAGTMP" "$ETAGFILE"
          echo "Downloaded: $SCHFILE"
          dos2unix -q $SCHFILE
          ;;
      *)
          echo "Unexpected HTTP status: $status" >&2
          rm -f $ETAGTMP
          exit 1
          ;;
  esac
else
  # echo "schfile.txt or dbfile.txt is missing or empty"
  cd $DIR
  exit 1
fi

if [[ "$status" =~ ^2[0-9][0-9]$ || -n "$2" ]]; then
  if [ -s $BASEFILE ]; then
    dos2unix -q $BASEFILE
    echo "Appended base file to $SCHFILE"
    cat $SCHFILE $BASEFILE | gawk -f $HELPERS -f $AWKFILE > $TMPFILE2
  else
    gawk -f $HELPERS -f $AWKFILE $SCHFILE > $TMPFILE2
  fi

  echo "#01 Based on data from https://supercheckhistory.com/" >> $TMPFILE2
  echo "#09 Last updated $(date +%F)" >> $TMPFILE2

  sort $TMPFILE2 | sed 's/^#0. /# /g' > $DBFILE

  unix2dos -q $DBFILE
  echo Created $DBFILE

  rm -f $TMPFILE1 $TMPFILE2 $ETAGTMP

  ../_helpers/copytosourcetree.sh $DBFILE
  ../_helpers/uploaddb.sh $DBFILE
fi
cd $DIR
exit 0
