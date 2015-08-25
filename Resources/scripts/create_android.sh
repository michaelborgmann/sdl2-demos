#!/bin/bash

# You have to call this script with the . (dot) command: . ./create_android.sh
if (( SHLVL == 2))
then
    echo "Script must be executed in same process. Start with the dot command!"
    echo "Usage: . $0"
    exit 
fi

if [ -d android-cmake ]
then
    echo "[X] Android CMake Toolchain found"
else
    echo "[E] Android CMake Toolchain not found"
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

if [ -f scripts/setup_android.sh ]
then
    echo "[X] Setup Android"
    source scripts/setup_android.sh
else
    echo "[E] Script 'scripts/setup_android.sh' missing"
    return  
fi

if [ -d ../Resources/android-project ]
then
    echo "[X] Copy default Android project"
    cp -rf ../Resources/android-project/* .
    if [ -f AndroidManifest.xml ] && [ -d res ] && [ -d src  ]
    then
        echo -n # do nothing
    else
        echo "[E] Couldn't copy default Android project"
        return
    fi
else
    echo "[E] Default Android project missing"
    return
fi

if [ -d build.android ]
then
    while true; do
        read -p "Delete C++ build and libraries [no]? " yn
        case $yn in
            [Yy]* )
                rm -rf build.android/* libs;
                echo "[X] Delete C++ build";
                break;;
            * ) break;;
        esac
    done
else 
    mkdir build.android
    if [ -d build.android ]
    then
        echo "[x] Create directory for C++ build" 
    else
        echo "[E] Couldn't create directory for C++ build"
    fi
fi

if [ -f scripts/build_sdl2-android.sh ]
then
    echo "[X] scripts/build_sdl2-android.sh found"
    source scripts/build_sdl2-android.sh
else
    echo "[X] scripts/build_sdl2-android.sh not found"
    return
fi

cd build.android

if [ -f Makefile ]
then
    while true; do
        read -p "Build makefiles [no]? " yn
        case $yn in
            [Yy]* )
                android-cmake ..
                break;;
            * ) break;;
        esac
    done
else
    android-cmake ..
fi

if [ $? -ne 0 ]
then
    echo "[E] Build failed: couldn't create makefiles"
    cd ..
    return $?
else
    echo "[X] Makefiles created"
fi

make
if [ $? -ne 0 ]
then
    echo "[E] Build failed: couldn't compile C++ files"
    cd ..
    return $?
else
    echo "[X] C++ libraries created"
fi

cd ..

if [ -f scripts/init_android.sh ]
then
    echo "[X] Android build script found" 
else
    echo "[E] Android build script not found"    
    return
fi

scripts/init_android.sh

#cd android
ant debug install

if [ $? -ne 0 ]
then
    echo "[E] Android project build and installation failed"
    cd ..
    return $?
else
    echo "[X] Android project build and installed to device"
fi

echo
echo "Okay, it's done. Now start the app on your Android"
echo "... maybe you have to add your libraries in you *.java file"
