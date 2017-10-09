#!/bin/bash

# Author : Jonathan Lurie
# Link   : https://github.com/jonathanlurie/bigbrainDownloader
#
# This script downloads png slices from the BigBrain FTP , copy them in a local
# folder and convert the original slices into jpeg at quality 100%, 80% and also
# into jpeg thumbnails at 10% of the size and quality 80%.
# Optionaly, the original png can be deleted at the end of the process to save
# some space.
#
# The following three values can be changed:
#   firstIndex: the index of the first slice to be downloaded
#   lastIndex: the index of the last slice to be downloaded (including this one)
#   section: can be "Coronal", "Axial" or "Sagittal" - mind the capital!
firstIndex=1
lastIndex=10
section="Coronal"

# choose to convert in a different thread: downloading will be faster and converting
# is done after (in sub process), when the script is already finished. In other words,
# you will see the jpeg files progressivelly appear in the subfolders long after the
# script is finished.
useThread=false


echo "You are about to download the ${section} slices, in the range [${firstIndex}, ${lastIndex}]"
read -r -p "Is that correct? [Y/n] " response
if [[ "$response" =~ ^([nN][oO]|[nN])+$ ]]
then
  echo "bye."
  exit
fi

function convertImage {
  if [ "$useThread" = true ] ; then
    convert $1 -resize $2 -quality $3 $4 &
  else
    convert $1 -resize $2 -quality $3 $4
  fi
}

for i in $(seq $firstIndex $lastIndex);
do
  index=$(printf "%04d\n" $i)
  filename="pm${index}o"
  echo $filename

  # build some filepaths
  url="ftp://bigbrain.loris.ca/BigBrainRelease.2015/2D_Final_Sections/${section}/Png/Full_Resolution/${filename}.png"
  destPng=${section}/png/${filename}.png
  destJpeg100=${section}/jpeg_100/${filename}.jpg
  destJpeg80=${section}/jpeg_80/${filename}.jpg
  destJpeg50=${section}/jpeg_50/${filename}.jpg
  destJpegThumb=${section}/jpeg_thumb/${filename}.jpg

  # download the image
  curl -s $url > $destPng

  # make a 100% quality jpeg
  #convert $destPng -resize 100% -quality 100 $destJpeg100
  convertImage $destPng 100% 100 $destJpeg100

  # make a 80% quality jpeg
  #convert $destPng -resize 100% -quality 80 $destJpeg80
  convertImage $destPng 100% 80 $destJpeg80

  # make a 80% quality 10% size jpeg thumbnail
  #convert $destPng -resize 10% -quality 80 $destJpegThumb
  convertImage $destPng 10% 80 $destJpegThumb

  # optionaly, delete the original png (heavier than jpeg)
  #rm $destPng
done
