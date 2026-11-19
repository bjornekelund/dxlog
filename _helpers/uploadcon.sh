#!/bin/sh
file=$1

if curl -o /dev/null --silent \
  --fail \
  --show-error \
  --connect-timeout 10 \
  --user "$(cat ../CREDENTIALS)" \
  --upload-file "$file" "https://dxlog.net:2078/sw/files/download/contest/$file";
then
  echo "Uploaded $file with $(wc -c < $file) lines"
else
  echo "ERROR: Failed to upload $file"
  exit 1
fi  

exit 0
