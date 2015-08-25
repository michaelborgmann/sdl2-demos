if (WIN32 AND MSVC)

    message ("Build for Microsoft Visual Studo Expres 2010")
    set (SDL2_PATH C:/SDKs/SDL2-2.0.3)
    set (SDL2IMAGE C:/SDKs/SDL2_image-2.0.0)
    set (SDL2TTF C:/SDKs/SDL2_ttf-2.0.12)
    set (SDL2MIXER C:/SDKs/SDL2_mixer-2.0.0)
    set (BUILD_FLAGS WIN32)
    set (LIBS SDL2main SDL2 SDL2_image SDL2_ttf SDL2_mixer)
    include_directories (${SDL2_PATH}/include
                         ${SDL2IMAGE}/include
                         ${SDL2TTF}/include
                         ${SDL2MIXER}/include)
    link_directories (${SDL2_PATH}/lib/x86
                      ${SDL2IMAGE}/lib/x86
                      ${SDL2TTF}/lib/x86
                      ${SDL2MIXER}/lib/x86)
                    
endif ()
