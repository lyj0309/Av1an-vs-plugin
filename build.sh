#!/bin/bash

# Array of repository URLs
repos=(
    "https://github.com/Irrational-Encoding-Wizardry/Vapoursynth-RemapFrames.git"
    "https://github.com/dubhater/vapoursynth-fillborders.git"
    "https://github.com/vapoursynth/subtext.git"
    "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-AddGrain.git"
    "https://github.com/dubhater/vapoursynth-awarpsharp2.git"
    "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-BM3D.git"
    "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Bwdif.git"
    "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-CAS.git"
    "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-CTMF.git"
    "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DCTFilter.git"
    "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-Deblock.git"
    "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-DFTTest.git"
    "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI2.git"
    "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI3.git"
    "https://github.com/myrsloik/VapourSynth-FFT3DFilter.git"
    # "https://github.com/dubhater/vapoursynth-fluxsmooth.git"
    # "https://github.com/Hinterwaeldlers/vapoursynth-hqdn3d.git"
    "https://github.com/Khanattila/KNLMeansCL.git"
    "https://github.com/vapoursynth/vs-miscfilters-obsolete.git"
    "https://github.com/dubhater/vapoursynth-mvtools.git"
    # "https://github.com/HomeOfAviSynthPlusEvolution/neo_f3kdb.git"
    "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-NNEDI3CL.git"
    "https://github.com/vapoursynth/vs-removegrain.git"
    "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-TTempSmooth.git"
    # "https://github.com/sekrit-twc/znedi3.git"    
)

# Destination directory for .so files
destination="/usr/lib/vapoursynth/"

# Ensure destination directory exists
mkdir -p "$destination"

# Function to build and move .so files
build_and_move() {
    repo_url="$1"
    repo_name=$(basename "$repo_url" .git)

    # Clone the repository
    git clone "$repo_url" || exit 1

    # Change to the repository directory
    cd "$repo_name" || exit 1

    # Build the project
    meson build || exit 1
    ninja -C build || exit 1

    # Move all .so files to the destination directory
    find build -name "*.so" -exec mv {} "$destination" \;

    # Return to the parent directory
    cd ..

    # Remove the repository directory
    rm -rf "$repo_name"
}

# Loop through each repository and build the plugin
for repo in "${repos[@]}"; do
    build_and_move "$repo"
done
