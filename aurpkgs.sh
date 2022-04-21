#!/bin/bash

# Check whether the file is provided
if [[ $# -eq 0 ]]; then
    echo 'Usage: ./aurpkgs.sh <file>'
    exit 0
fi

# Check whether the file exists
if [[ ! -f "$1" ]]; then
    echo "$1: No such file"
    exit 1
fi

pkgs=""

# Loop through the text file line by line
while IFS= read -r pkg; do
    # Append the package name to pkgs
    pkgs="$pkgs $pkg"
done < "$1"

# Install the packages
yay -S $pkgs 
