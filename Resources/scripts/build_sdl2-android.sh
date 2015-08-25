#!/bin/bash

# You have to call this script with the . (dot) command: . ./create_android.sh
if (( SHLVL == 2))
then
    echo "Script must be executed in same process. Start with the dot command!"
    echo "Usage: . $0"
    exit 
fi

if [ -d SDL ]
then
    echo "[X] SDL found"
    VALID_SDL=true
else
    echo "[X] SDL not found. Launch scripts/get_sdl2.sh (REQUIRED)"
    VALID_SDL=false
    return
fi

if [ -d SDL/include/SDL2 ]
then
    echo "[X] include/SDL2 is fixed"
else
    echo "[W] must use include/SDL2"
    ln -s . SDL/include/SDL2
fi

if [ -d SDL_image ]
then
    echo "[X] SDL_image found"
    VALID_IMAGE=true
else
    echo "[X] SDL not found. Launch scripts/get_sdl2_image.sh (OPTIONAL)"
    VALID_IMAGE=false
fi

if [ -d SDL_ttf ]
then
    echo "[X] SDL_ttf found"
    VALID_TTF=true
else
    echo "[X] SDL not found. Launch scripts/get_sdl2_ttf.sh (OPTIONAL)"
    VALID_TTF=false
fi

if [ -d SDL_mixer ]
then
    echo "[X] SDL_mixer found"
    VALID_MIXER=true
else
    echo "[X] SDL not found. Launch scripts/get_sdl2_mixer.sh (OPTIONAL)"
    VALID_MIXER=false
fi

if [ -d jni ]
then
    echo "[X] JNI found"
else
    mkdir jni
    echo "[X] JNI created"
fi

if [ -f jni/Android.mk ]
then
    echo "[X] jni/Android.mk found"
else
    echo "include \$(call all-subdir-makefiles)" >> jni/Android.mk
    echo "[X] jni/Android.mk created"
fi

if [ -f jni/Application.mk ]
then
    echo "[X] jni/Application.mk found"
else
    #echo "APP_ABI := armeabi armeabi-v7a x86" >> jni/Application.mk
    echo "APP_ABI := armeabi-v7a" >> jni/Application.mk
    echo "[X] jni/Application.mk created"
fi

if [ -d jni/SDL ]
then
    echo "[X] NDK will build SDL"
else
    echo "[W] SDL not found for NDK build"
    ln -s ../SDL jni/
    if [ -d jni/SDL ]
    then
        echo "[X] Updated: NDK will build SDL"
    else
        echo "[E] NDK can't build SDK (REQUIRED)"
        return
    fi
fi

rm -f jni/SDL_image
if [ $VALID_IMAGE == true ]
then
    while true; do
        read -p "Build SDL_image [yes]? " yn
        case $yn in
            [Nn]* ) break;;
            * ) ln -s ../SDL_image jni/
                if [ -d jni/SDL_image ]
                then
                    echo "[X] Build SDL_image"
                else
                    echo "[E] Can't add SDL_image to NDK build"
                    return
                fi
                break;;
        esac
    done
fi

rm -f jni/SDL_ttf
if [ $VALID_TTF == true ]
then
    while true; do
        read -p "Build SDL_ttf [yes]? " yn
        case $yn in
            [Nn]* ) break;;
            * ) ln -s ../SDL_ttf jni/
                if [ -d jni/SDL_ttf ]
                then
                    echo "[X] Build SDL_ttf"
                else
                    echo "[E] Can't add SDL_ttf to NDK build"
                    return
                fi
                break;;
        esac
    done
fi

rm -f jni/SDL_mixer
if [ $VALID_MIXER == true ]
then
    while true; do
        read -p "Build SDL_mixer [yes]? " yn
        case $yn in
            [Nn]* ) break;;
            * ) ln -s ../SDL_mixer jni/
                if [ -d jni/SDL_mixer ]
                then
                    echo "[X] Build SDL_mixer"
                else
                    echo "[E] Can't add SDL_mixer to NDK build"
                    return
                fi
                break;;
        esac
    done

    while true; do
        read -p "Enable modplug (experimental) [no]? " yn
        case $yn in
            [Nn]* )
                if grep -q "SUPPORT_MOD_MODPLUG ?= false" SDL_mixer/Android.mk
                then
                    sed -i "" "s|SUPPORT_MOD_MODPLUG ?= false|SUPPORT_MOD_MODPLUG =? true|g" SDL_mixer/Android.mk
                fi
                break;;
            * ) if grep -q "SUPPORT_MOD_MODPLUG ?= true" SDL_mixer/Android.mk
                then
                    sed -i "" "s|SUPPORT_MOD_MODPLUG ?= true|SUPPORT_MOD_MODPLUG =? false|g" SDL_mixer/Android.mk
                fi
                break;;
        esac
    done

    while true; do
        read -p "Enable mikmod (experimental) [no]? " yn
        case $yn in
            [Nn]* )
                if grep "SUPPORT_MOD_MIKMOD ?= false" SDL_mixer/Android.mk
                then
                    sed -i "" "s|SUPPORT_MOD_MIKMOD ?= false|SUPPORT_MOD_MIKMOD =? true|g" SDL_mixer/Android.mk
                fi
                break;;
            * ) if grep -q "SUPPORT_MOD_MIKMOD ?= true" SDL_mixer/Android.mk
                then
                    sed -i "" "s|SUPPORT_MOD_MIKMOD ?= true|SUPPORT_MOD_MIKMOD =? false|g" SDL_mixer/Android.mk
                fi
                break;;
        esac
    done

    while true; do
        read -p "Enable MP3/SMPEG (experimental) [no]? " yn
        case $yn in
            [Nn]* )
                if grep -q "SUPPORT_MP3_SMPEG ?= true" SDL_mixer/Android.mk
                then
                    sed -i "" "s|SUPPORT_MP3_SMPEG ?= true|SUPPORT_MOD_SMPEG =? false|g" SDL_mixer/Android.mk
                fi
                break;;
            * ) if grep -q "SUPPORT_MP3_SMPEG ?= true" SDL_mixer/Android.mk
                then
                    sed -i "" "s|SUPPORT_MP3_SMPEG ?= true|SUPPORT_MOD_SMPEG =? false|g" SDL_mixer/Android.mk
                fi
                break;;
        esac
    done
fi

ndk-build
