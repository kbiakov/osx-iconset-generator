#!/bin/sh

filepath=$1
filename=$(basename "$filepath")
filename="${filename%.*}"

iconset=$filename.iconset
iconpath=$iconset/icon_
mkdir $iconset

function gen {
    res=$1x$1
    echo "Convert $res..."
    convert $filepath -resize $res -quality 100 $iconpath$res.png
}

function genRetina {
    res=$1x$1
    double=$(($1*2))
    doubleRes=${double}x$double
    echo "Create $res for Retina..."
    cp $iconpath$doubleRes.png $iconpath$res@2x.png
}

function pow2 {
    echo $(awk "BEGIN{print 2 ** $1}")
}

for ((i = 1; i <= 7; i++));
do
    gen $(pow2 $(($i+3)))
    if (($i > 1)) ; then
        genRetina $(pow2 $(($i+2)))
    fi
done
