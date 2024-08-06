#!/bin/bash
destination="/usr/lib/vapoursynth/"

git clone https://github.com/sekrit-twc/znedi3.git
cd znedi3
make X86=1
cp nnedi3_weights.bin vsznedi3.so "$destination"
cd ..

git clone https://github.com/Hinterwaeldlers/vapoursynth-hqdn3d.git
cd vapoursynth-hqdn3d
./autogen.sh
./configure
make
cp .libs/*.so "$destination"
cd ..

git clone https://github.com/dubhater/vapoursynth-fluxsmooth.git
cd vapoursynth-fluxsmooth
./autogen.sh
./configure
make
cp .libs/*.so "$destination"
cd ..


# pacman -S tbb
git clone https://github.com/HomeOfAviSynthPlusEvolution/neo_f3kdb.git
cd neo_f3kdb
cmake -B build/x64 -S . -D_DIR=x64 -DCMAKE_C_FLAGS="-m64" -DCMAKE_CXX_FLAGS="-m64"
cmake --build build/x64 --config Release
cp build/x64/*.so "$destination"
cd ..

git clone https://github.com/HomeOfAviSynthPlusEvolution/L-SMASH-Works.git
cd L-SMASH-Works/VapourSynth
meson build 
ninja -C build 
find build -name "*.so" -exec mv {} "$destination" \;
cd ../../

