#!/bin/bash

# Converts the all the scanned music sheets in a directory from png 
# to a single pdf with sharp edges 
# Argument(s): [input directory]

rm $1/resized-*.png
rm $1/sharp-*.png

convert -resize 300%  $1/*.png $1/resized.png
convert -sharpen 0x3 $1/resized*.png $1/sharp.png


for i in 1 2; do
	for f in $1/sharp*.png; do
		echo "Sharpening $f file.."
		OUTPUT_FILE="$f"
		echo "Output to $OUTPUT_FILE"
		convert $f -sharpen 0x3 $OUTPUT_FILE
	done
done

convert $1/sharp*.png $1.pdf

