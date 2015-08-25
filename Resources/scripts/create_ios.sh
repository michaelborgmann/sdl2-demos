#!/bin/bash

# You have to call this script with the . (dot) command: . ./create_android.sh
if (( SHLVL == 2))
then
    echo "Script must be executed in same process. Start with the dot command!"
    echo "Usage: . $0"
    exit 
fi

if [ -f scripts/build_sdl2-ios.sh ]
then
    source scripts/build_sdl2-ios.sh
    echo "[X] scripts/build_sdl-ios.sh found"
else
    echo "[E] scripts/build_sdl-ios.sh not found"
    return
fi

if [ -d scripts ]
then
    echo "[X] scripts found"
else
    echo "[W] scripts not found"
    cp -rf ../Resources/scripts .
    if [ -d scripts ]
    then
        echo "[X] scripts copied"
    else 
        echo "[E] Couldn't copy scripts"
        return
    fi
fi

if [ -d toolchain ]
then
    echo "[X] iOS CMake Toolchain found"
else
    echo "[W] iOS CMake Toolchain not found"
    cp -rf ../Resources/3rdParty/CMake/toolchain .
    if [ -f toolchain/iOS.cmake  ]
    then
        echo "[X] iOS CMake toolchain copied"
    else
        echo "[E] Couldn't copy iOS CMake toolchain"
    fi
fi

if [ -f scripts/ios-cmake.sh ]
then
    echo "[X] Set iOS CMake alias"
    source scripts/ios-cmake.sh
else
    echo "[E] Script 'scripts/ios-cmake.sh' missing"
    return  
fi

if [ -d build.ios ]
then
    while true; do
        read -p "Delete C++ build [no]? " yn
        case $yn in
            [Yy]* )
                rm -rf build.ios/*;
                echo "[X] Delete C++ build";
                break;;
            * ) break;;
        esac
    done
else 
    mkdir build.ios
    if [ -d build.ios ]
    then
        echo "[x] Create directory for C++ build" 
    else
        echo "[E] Couldn't create directory for C++ build"
    fi
fi

cd build.ios

for MAKEFILE in *.xcodeproj;
do
    if [ -e "$MAKEFILE" ]
    then
        break
    fi
done

if [ -d "$MAKEFILE" ]
then
    echo "[X] Makefile found: $MAKEFILE"
    while true; do
        read -p "Build makefiles [no]? " yn
        case $yn in
            [Yy]* )
                ios-cmake ..
                break;;
            * ) break;;
        esac
    done
else
    ios-cmake ..
fi

if [ $? -ne 0 ]
then
    echo "[E] Build failed: couldn't create makefiles"
    cd ..
    return $?
else
    echo "[X] Makefiles created"
fi

xcodebuild -sdk iphonesimulator -configuration Debug
if [ $? -ne 0 ]
then
    echo "[E] Build failed: couldn't compile C++ files"
    cd ..
    echo
    echo "NOTE: My build failed for SDL2-2.0.3 and I checked out version 2.0.1 to build."
    echo "      Show SDL version repository : hg tags
    echo "      Check out tagged SDL version: hg checkout release-2.0.1
    return $?
else
    echo "[X] iOS App created"
fi

cd ..

echo
echo "Okay, it's done. Now start the app on your Android"
