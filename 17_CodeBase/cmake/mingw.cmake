if (WIN32 AND MINGW)

    message ("Build for MinGW")
    set (CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++")
    set (SDL2_PATH C:/SDKs/SDL2-2.0.3)
    set (BUILD_FLAGS WIN32)
    set (LIBS mingw32 SDL2main SDL2)
    include_directories (${SDL2_PATH}/include)
    link_directories (${SDL2_PATH}/i686-w64-mingw32/lib)

endif ()
