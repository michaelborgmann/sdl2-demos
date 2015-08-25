if (WIN32 AND MSVC)

    message ("Build for Microsoft Visual Studo Expres 2010")
    set (SDL2_PATH C:/SDKs/SDL2-2.0.3)
    set (BUILD_FLAGS WIN32)
    set (LIBS SDL2main SDL2)
    include_directories (${SDL2_PATH}/include)
    link_directories (${SDL2_PATH}/lib/x86)

endif ()
