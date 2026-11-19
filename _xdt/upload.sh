#!/bin/sh
if curl -o /dev/null --silent --fail --show-error --user "$(cat ../CREDENTIALS)" \
  --upload-file "$1" "https://dxlog.net:2078/sw/files/download/extrainfo/$1";
then
  echo "Uploaded $1 with $(wc -l < $1) lines"
else
  echo "ERROR: Failed to upload $file"
  exit 1
fi  

exit 0
