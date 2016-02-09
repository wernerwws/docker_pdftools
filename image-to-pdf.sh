#!/bin/bash

SOURCEIMAGE=/input/sourcefile/content
TARGETPDF=/output/targetfile/content
#BORDER=$2 #"No border" "Small border" "Large border"
#ORIENTATION=$3 #"Autorotate" "Portrait" "Landscape"
#PAPERSIZE=$4 #"Letter" "A4" "A3" "Image Size"

file $SOURCEIMAGE

BORDERCOLOR="#FFFFFF"

POINT=0.3527777

SOURCEHEIGHT=$(identify -format "%h" $SOURCEIMAGE)
SOURCEWIDTH=$(identify -format "%w" $SOURCEIMAGE)

SOURCERATIO=$(echo "100*$SOURCEHEIGHT/$SOURCEWIDTH" | bc)

case "$PAPERSIZE" in
    "Letter")
	echo "Papersize: Letter"
	TARGETWIDTH=612
	TARGETHEIGHT=792
	;;
    "A4")
	echo "Papersize: A4"
	TARGETWIDTH=595
	TARGETHEIGHT=842
	;;
    "A3")
	echo "Papersize: A3"
	TARGETWIDTH=842
	TARGETHEIGHT=1190
	;;
    *)
	echo "Papersize: Image size"
	TARGETWIDTH=$SOURCEWIDTH
	TARGETHEIGHT=$SOURCEHEIGHT
	;;
esac

case "$ORIENTATION" in
    "Landscape")
	echo "Orientation: Landscape"
	TEMPVAR=$TARGETWIDTH
	TARGETWIDTH=$TARGETHEIGHT
	TARGETHEIGHT=$TEMPVAR
	;;
    "Autorotate")
	if [ "$PAPERSIZE" != "Image size" ]; then
	    echo "Orientation: Autorotate"
	    if [ 100 -gt $SOURCERATIO ]; then
		TEMPVAR=$TARGETWIDTH
		TARGETWIDTH=$TARGETHEIGHT
		TARGETHEIGHT=$TEMPVAR
	    fi
	fi
	;;	
esac

case "$BORDER" in
    "Small border")
	echo "Border: Small border"
        BORDER=10
	;;
    "Large border")
	echo "Border: Large border"
        BORDER=30
	;;
    *)
	echo "Border: No border"
        BORDER=0
	;;
esac

TARGETRATIO=$(echo "100*$TARGETHEIGHT/$TARGETWIDTH" | bc)

if [ $SOURCERATIO -lt $TARGETRATIO ]; then
    ADDBORDER=$(echo "$BORDER/$POINT*$SOURCEWIDTH/($TARGETWIDTH-2*$BORDER/$POINT)" | bc)
else
    ADDBORDER=$(echo "$BORDER/$POINT*$SOURCEHEIGHT/($TARGETHEIGHT-2*$BORDER/$POINT)" | bc)
fi
 
convert -bordercolor $BORDERCOLOR $SOURCEIMAGE -border $ADDBORDER /tmp/1 
sam2p /tmp/1 /tmp/1.pdf
sam2p_pdf_scale $TARGETWIDTH $TARGETHEIGHT /tmp/1.pdf $TARGETPDF



# Letter 612x792
# LetterSmall 612x792
# Tabloid 792x1224
# Ledger1224x792
# Legal 612x1008
# Statement 396x612
# Executive 540x720
# A0               2384x3371
# A1              1685x2384
# A21190x1684
# A3 842x1190
# A4 595x842
# A4Small 595x842
# A5 420x595
# B4 729x1032
# B5 516x729
# Envelope ???x???
# Folio 612x936
# Quarto 610x780
# 10x14 720x1008
