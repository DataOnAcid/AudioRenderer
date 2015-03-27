#!/bin/bash

URL=$1
OUTPUT=output

rm -f data.dat data2.dat output.wav

wget -qO data.dat $URL

python play-sound-wav.py data.dat > data2.dat
chuck dataacid.ck:data2.dat:$OUTPUT -s
cat output.wav

rm -f data.dat data2.dat output.wav
