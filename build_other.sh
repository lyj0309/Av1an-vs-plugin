#!/bin/bash

git clone https://github.com/sekrit-twc/znedi3.git
cd znedi3
make X86=1
cp nnedi3_weights.bin vsznedi3.so /usr/lib/vapoursynth/
cd ..

git clone https://github.com/Hinterwaeldlers/vapoursynth-hqdn3d.git
./autogen.sh
./configure
make
cp *.so /usr/lib/vapoursynth/
cd ..

git clone https://github.com/dubhater/vapoursynth-fluxsmooth.git
./autogen.sh
./configure
make
cp *.so /usr/lib/vapoursynth/
cd ..

    # "https://github.com/HomeOfAviSynthPlusEvolution/neo_f3kdb.git"
