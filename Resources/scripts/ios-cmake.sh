#!/bin/bash

if [ -f toolchain/iOS.cmake ]
then
    PWD=`pwd`
    CMAKE="$PWD/toolchain"
else
    echo "[E] iOS CMake not found"
    echo
    echo "Get if from Resources/3rdParty/CMake/toolchain"
    exit
fi

echo "[X] iOS CMake    : $CMAKE"

IOSTOOLCHAIN=$CMAKE/iOS.cmake
alias ios-cmake='cmake -DCMAKE_TOOLCHAIN_FILE='"$IOSTOOLCHAIN"' -G Xcode'
