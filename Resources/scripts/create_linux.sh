#!/bin/bash

# You have to call this script with the . (dot) command: . ./create_android.sh
if (( SHLVL == 2))
then
    echo "Script must be executed in same process. Start with the dot command!"
    echo "Usage: . $0"
    exit 
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

if [ -d build.linux ]
then
    while true; do
        read -p "Delete C++ build [no]? " yn
        case $yn in
            [Yy]* )
                rm -rf build.linux/*;
                echo "[X] Delete C++ build";
                break;;
            * ) break;;
        esac
    done
else 
    mkdir build.linux
    if [ -d build.linux ]
    then
        echo "[x] Create directory for C++ build" 
    else
        echo "[E] Couldn't create directory for C++ build"
    fi
fi

cd build.linux

if [ -f Makefile ]
then
    while true; do
        read -p "Build makefiles [no]? " yn
        case $yn in
            [Yy]* )
                cmake ..
                break;;
            * ) break;;
        esac
    done
else
    cmake ..
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

echo
echo "Okay, it's done. Now launch your" 
