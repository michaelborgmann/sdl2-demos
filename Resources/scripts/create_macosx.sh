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

if [ -d build.osx ]
then
    while true; do
        read -p "Delete C++ build [no]? " yn
        case $yn in
            [Yy]* )
                rm -rf build.osx/*;
                echo "[X] Delete C++ build";
                break;;
            * ) break;;
        esac
    done
else 
    mkdir build.osx
    if [ -d build.osx ]
    then
        echo "[x] Create directory for C++ build" 
    else
        echo "[E] Couldn't create directory for C++ build"
    fi
fi

cd build.osx

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
                cmake .. -G Xcode
                break;;
            * ) break;;
        esac
    done
else
    cmake .. -G Xcode
fi

if [ $? -ne 0 ]
then
    echo "[E] Build failed: couldn't create makefiles"
    cd ..
    return $?
else
    echo "[X] Makefiles created"
fi

xcodebuild
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
