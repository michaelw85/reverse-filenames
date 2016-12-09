#!/bin/bash

# Change to current dir.
cd "$(pwd)"

# Check if a parameter is given                                                 
if [[ -e $1 ]]                                                                  
then  # if a selection is found, just count the files in that selection         
    files="$1"                                                                  
    total=$(ls "$files" | wc -l)                                                
else  # if no parameter is given, count all files                                                                                                                                                                  
    files="*"                                                                   
    total=$(ls "$(pwd)" | wc -l)                                                
fi 

# Empty vars for stats and first percentage output
converted=0
skipped=0
echo -n "[                                                  ] 0%"

# Loop all files in the current dir.
for file in $files; do
  # Get the basename
  filename=$(basename "$file")

  # Get the extension
  extension="${filename##*.}"

  # Get the filename withoud the extension
  filename="${filename%.*}"

  # Get the file length
  l=${#filename}

  # Create empty var to store the reverse string
  rev=''
  # Loop though the filename in reverse orde and store the correct name.
  for (( i=$l; i>=0; i-- )); do
    rev="$rev${filename:$i:1}"
  done

  # Move the actual file to the new name and keep stats.

  # If we do not have a file skip.
  if [ -f "$file" ]; then
    converted=$(($converted+1))
    mv "$file" "$rev".$extension;
  else
    skipped=$(($skipped+1))
  fi

  # Get the percentage as a floating point
  percentage=$(echo "scale=2; (($converted+$skipped)/$total)*100" | bc)

  # Start outputting our percentage bar :)
  echo -ne "\r["

  # Get our percentage as integer for the for loop
  percentageInt=${percentage/.*}

  # Output a = or space every 2%
  # The output bar = 50 character wide hence the 2% steps
  for (( p=0; p<100;p=p+2 )); do

    # Check if we are still below the current percentage, if so output =
    if [[ $p -lt $percentageInt ]]; then
     echo -n "="
    else
     # Still no finished fill the bar up with empty spaces.
     echo -n " "
    fi
  done

  # Show percentage at the end of the bar.
  echo -n "] $percentage%";

done

# Where done output stats.
echo ""
echo "Total     : $total"
echo "Converted : $converted"
echo "Skipped:  : $skipped"
