#!/usr/bin/env bash
# Make executable: chmod +x ./bin/generate-photo-variants.sh
# Usage: ./bin/generate-photo-variants.sh "./public/img/photos/austin-distel_two-black-headphones-on-brown-wooden-table.jpg"
filename=$(basename -- "$1")
dirname=$(dirname $(readlink -f "$1"))
extension="${filename##*.}"
filename="${filename%.*}"

#######################################################################################################################
# Social Media Image Size Guide
# +---------------+--------------------+-------------------+---------------------+-----------------+
# |               | Instagram          | Facebook          | LinkedIn            | Twitter         |
# +---------------+--------------------+-------------------+---------------------+-----------------+
# | Profile Photo | 320x320 (1/1)      | 196x196 (1/1)     | 400x400 (1/1)       | 400x400 (1/1)   |
# | Cover Photo   | N/A                | 851x315 (851/315) | 1128x1191 (376/397) | 1500x500 (3/1)  |
# | Landscape     | 1080x566 (540/283) | 1200x630 (40/21)  | 1200x627 (400/209)  | 1600x900 (16/9) |
# | Portrait      | 1080x1350 (4/5)    | 1080x1350 (4/5)   | 1080x1350 (4/5)     | 1080x1350 (4/5) |
# | Square        | 1080x1080 (1/1)    | 1080x1080 (1/1)   | 1080x1080 (1/1)     | 1080x1080 (1/1) |
# +---------------+--------------------+-------------------+---------------------+-----------------+
# “Social Media Image Size Guide For All Platforms In 2023”. Search Engine Journal. 
# Retrieved September 18, 2023, 06:56
#######################################################################################################################

# Generate Profile Photos
convert $1 -resize 400x400^ -gravity center -extent 400x400 $dirname/processed/$filename@400x400.$extension
convert $1 -resize 320x320^ -gravity center -extent 320x320 $dirname/processed/$filename@320x320.$extension
convert $1 -resize 196x196^ -gravity center -extent 196x196 $dirname/processed/$filename@196x196.$extension
# Generate Cover Photos
convert $1 -resize 1500x500^ -gravity center -extent 1500x500 $dirname/processed/$filename@1500x500.$extension
convert $1 -resize 1128x1191^ -gravity center -extent 1128x1191 $dirname/processed/$filename@1128x1191.$extension
convert $1 -resize 851x315^ -gravity center -extent 851x315 $dirname/processed/$filename@851x315.$extension
# Generate Landscape Photos
convert $1 -resize 1600x900^ -gravity center -extent 1600x900 $dirname/processed/$filename@1600x900.$extension
convert $1 -resize 1200x630^ -gravity center -extent 1200x630 $dirname/processed/$filename@1200x630.$extension
convert $1 -resize 1200x627^ -gravity center -extent 1200x627 $dirname/processed/$filename@1200x627.$extension
convert $1 -resize 1080x566^ -gravity center -extent 1080x566 $dirname/processed/$filename@1080x566.$extension
# Generate Portrait Photos
convert $1 -resize 1080x1350^ -gravity center -extent 1080x1350 $dirname/processed/$filename@1080x1350.$extension
# Generate Square Photos
convert $1 -resize 1080x1080^ -gravity center -extent 1080x1080 $dirname/processed/$filename@1080x1080.$extension
