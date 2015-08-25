#!/bin/bash

echo "Setup Android for NDK Development"
echo "================================="
echo
echo "Find Android SDK, NDK, CMake, Toolchain"
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
    PROJECT=`pwd`
    cd ~
    HOME=`pwd`
    cd $PROJECT
    ANDROID="$HOME/Android"
else
    echo "[E] Android not found"
    echo
    echo "Create a directory where anything Android goes (e.g. /opt/Anroid)"
    exit
fi

echo "[X] Android          : $ANDROID"

# Search for the Android Development Tools (ADT)
for ADT in $ANDROID/adt*;
do
    if [ -e "$ADT" ]
    then
        break
    fi
done

if [ -d "$ADT" ]
then
    echo "[X] ADT              : $ADT"
else
    echo "[E] ADT not found"
    echo
    echo "Get the Android adt-bundle for your platform"
    exit
fi

#Search for the Android SDK
if [ -d $ADT/sdk ]
then
    SDK="$ADT/sdk"
else
    echo "[E] Android SDK not found"
    echo
    echo "Get the Android SDK (search for the Android adt-bundle)"
    exit
fi

echo "[X] SDK              : $SDK"

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

# Search for Android CMake
if [ -d android-cmake ]
then
    PWD=`pwd`
    CMAKE="$PWD/android-cmake"
elif [ -d $ANDROID/android-cmake ]
then
    CMAKE="$ANDROID/android-cmake"
else
    echo "[E] Android CMake not found"
    echo
    echo "Get the Android CMake Toolchain (./get_android-cmake.sh)"
    exit 
fi

echo "[X] Android CMake    : $CMAKE"

# Search for an Android Toolchain
if [ -d $ANDROID/android-toolchain ]
then
    TOOLCHAIN="$ANDROID/android-toolchain"
else
    echo "[E] Android Toolchain not found"
    echo
    echo "Create an Android Toolchain, and select target version (e.g. 20 = KitKat 4.4.4W)"
    echo "bash $NDK/build/tools/make-standalone-toolchain.sh --platform=android-19 --install-dir=$ANDROID/android-toolchain"
    exit
fi

echo "[X] Android Toolchain: $TOOLCHAIN"

# Set environment variables

echo
echo "Set PATH environment variable for: sdk/tools"
echo "                                   sdk/build-tools"
echo "                                   sdk/platform-tools"
echo "                                   ndk"
export PATH=$PATH:$SDK/tools:$SDK/build-tools:$SDK/platform-tools:$NDK

echo
echo "Set up CMake alias for Android: android-cmake"
ANDTOOLCHAIN=$CMAKE/toolchain/android.toolchain.cmake
alias android-cmake='cmake -DCMAKE_TOOLCHAIN_FILE='"$ANDTOOLCHAIN"' -Wno-dev'

echo
echo "Set up Android Toolchain for NDK development"
export ANDROID_STANDALONE_TOOLCHAIN=$ANDROID/android-toolchain

# All done
echo
echo "Android ready for NDK development"
