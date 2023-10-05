#!/usr/bin/env bash
# Make executable: chmod +x ./bin/prepare-photos.sh
# Usage: ./bin/prepare-photos.sh
FILES="./public/img/photos/*"

for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  ./bin/generate-photo-variants.sh "$f"
done
