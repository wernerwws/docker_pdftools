#!/bin/bash

TRANSPARENCY=$(echo "scale=2; $TRANSPARENCY/100" | bc)

cp /scripts/watermark.tex /tmp/

sed -i -- "s/###TEXT###/$TEXT/g" /tmp/watermark.tex
sed -i -- "s/###FONTSIZE###/$FONTSIZE/g" /tmp/watermark.tex
sed -i -- "s/###COLOR###/$COLOR/g" /tmp/watermark.tex
sed -i -- "s/###ROTATION###/$ROTATION/g" /tmp/watermark.tex
sed -i -- "s/###TRANSPARENCY###/$TRANSPARENCY/g" /tmp/watermark.tex

cd /tmp
pdflatex watermark.tex
pdflatex watermark.tex
mv watermark.pdf /output/targetfile/content
