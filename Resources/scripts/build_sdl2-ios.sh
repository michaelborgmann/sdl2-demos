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
    if [ -d SDL/include/SDL2 ]
    then
        echo "[X] include/SDL2 created"
    else
        echo "[E] Couldn't create include/SDL2"
        return
    fi
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

if [ -f SDL/Xcode-iOS/SDL/build/Debug-iphonesimulator/libSDL2.a ]
then
    while true; do
        read -p "Rebuild SDL2 library (iPhone Simulator + Debug) [no]? " yn
        case $yn in
            [Yy]* )
                rm -rf SDL/Xcode-iOS/SDL/build
                xcodebuild -project SDL/Xcode-iOS/SDL/SDL.xcodeproj -sdk iphonesimulator -configuration Debug
                if [ $? -ne 0 ]
                then
                    echo "[E] Build failed: couldn't create makefiles"
                    return $?
                else
                    echo "[X] SDL2 library created (iPhone Simulator + Debug)"
                fi
                break;;
            * ) break;;
        esac
    done
else
    xcodebuild -project SDL/Xcode-iOS/SDL/SDL.xcodeproj -sdk iphonesimulator -configuration Debug
    if [ $? -ne 0 ]
    then
        echo "[E] Build failed: couldn't create makefiles"
        return $?
    else
        echo "[X] SDL2 library created (iPhone Simulator + Debug)"
    fi
fi

if [ $VALID_IMAGE == true ]
then
    while true; do
        read -p "Build SDL_image [yes]? " yn
        case $yn in
            [Nn]* ) break;;
            * )
                rm -rf SDL_image/Xcode-iOS/SDL/build
                xcodebuild -project SDL_image/Xcode-iOS/SDL_image.xcodeproj -sdk iphonesimulator -configuration Debug
                if [ $? -ne 0 ]
                then
                    echo "[E] Build failed: cound't create SDL2_image"
                    return $?
                else
                    echo "[X] SDL2_image library created (iPhone Simulator + Debug)"
                fi
                break;;
        esac
    done
fi

if [ $VALID_TTF == true ]
then
    while true; do
        read -p "Build SDL_ttf [yes]? " yn
        case $yn in
            [Nn]* ) break;;
            * )
                rm -rf SDL_ttf/Xcode-iOS/SDL/build
                xcodebuild -project SDL_ttf/Xcode-iOS/SDL_ttf.xcodeproj -sdk iphonesimulator -configuration Debug
                if [ $? -ne 0 ]
                then
                    echo "[E] Build failed: cound't create SDL2_ttf"
                    return $?
                else
                    echo "[X] SDL2_ttf library created (iPhone Simulator + Debug)"
                fi
                break;;
        esac
    done
fi

if [ $VALID_MIXER == true ]
then
    while true; do
        read -p "Build SDL_mixer [yes]? " yn
        case $yn in
            [Nn]* ) break;;
            * )
                rm -rf SDL_mixer/Xcode-iOS/SDL/build
                xcodebuild -project SDL_mixer/Xcode-iOS/SDL_mixer.xcodeproj -sdk iphonesimulator -configuration Debug
                if [ $? -ne 0 ]
                then
                    echo "[E] Build failed: cound't create SDL2_mixer"
                    return $?
                else
                    echo "[X] SDL2_mixer library created (iPhone Simulator + Debug)"
                fi
                break;;
        esac
    done
fi
