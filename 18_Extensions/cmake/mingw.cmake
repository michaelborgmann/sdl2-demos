if (WIN32 AND MINGW)

    message ("Build for MinGW")
    set (CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++")
    set (SDL2_PATH C:/SDKs/SDL2-2.0.3)
    set (SDL2IMAGE C:/SDKs/SDL2_image-2.0.0)
    set (SDL2TTF C:/SDKs/SDL2_ttf-2.0.12)
    set (SDL2MIXER C:/SDKs/SDL2_mixer-2.0.0)
    set (BUILD_FLAGS WIN32)
    set (LIBS mingw32 SDL2main SDL2 SDL2_image SDL2_ttf SDL2_mixer)
    include_directories (${SDL2_PATH}/include
                         ${SDL2IMAGE}/include
                         ${SDL2TTF}/include
                         ${SDL2MIXER}/include)
    link_directories (${SDL2_PATH}/i686-w64-mingw32/lib
                      ${SDL2IMAGE}/i686-w64-mingw32/lib
                      ${SDL2TTF}/i686-w64-mingw32/lib
                      ${SDL2MIXER}/i686-w64-mingw32/lib)

endif ()
