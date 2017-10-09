#!/bin/bash

# Author : Jonathan Lurie
# Link   : https://github.com/jonathanlurie/bigbrainDownloader
#
# Flush all the png and jpeg images in the subdirectories

read -r -p "You are about to remove all the png and jpg files. Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    echo "Removing files..."
    find . -name \*.jpg -delete
    find . -name \*.png -delete
    echo "DONE."
fi
