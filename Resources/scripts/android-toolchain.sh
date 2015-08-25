#!/bin/bash

echo "Create Android Toolchaint"
echo "================================="
echo

# Search for an Android installation
if [ -d /opt/android ]
then
    ANDROID="/opt/android"
elif [ -d /opt/Android ]
then
    ANDROID="/opt/Android"
elif [ -d ~/Android ]
then
    ANDROID="~/Android"
else
    echo "[E] Android not found"
    echo
    echo "Create a directory where anything Android goes (e.g. /opt/Anroid)"
    exit
fi

echo "[X] Android          : $ANDROID"

# Search for the Android Native Development Kit (NDK)
for NDK in $ANDROID/android-ndk*;
do
    if [ -e "$NDK" ]
    then
        break
    fi
done

if [ -d "$NDK"  ]
then
    echo "[X] NDK              : $NDK"
else
    echo "[E] NDK not found"
    echo
    echo "Get the Android NDK for your platform"
    exit
fi

# Search for an Android Toolchain
if [ -d $ANDROID/android-toolchain ]
then
    TOOLCHAIN="$ANDROID/android-toolchain"
    echo "[X] Android Toolchain: $TOOLCHAIN"
else
    echo "[E] Android Toolchain not found"
    echo
    echo "Create an Android Toolchain, and select target version (e.g. 20 = KitKat 4.4.4W):"
    echo
    echo "$ bash $NDK/build/tools/make-standalone-toolchain.sh --platform=android-19 --install-dir=$ANDROID/android-toolchain"
    bash $NDK/build/tools/make-standalone-toolchain.sh --platform=android-19 --install-dir=$ANDROID/android-toolchain
    echo
    if [ -d $ANDROID/android-toolchain ]
    then
    	echo "Installed Android Toolchain at $ANDROID/android-toolchain"
    else
        echo "Couldn't install Android Toolchain to $ANDROID/android-toolchain"
    fi
    exit
fi
