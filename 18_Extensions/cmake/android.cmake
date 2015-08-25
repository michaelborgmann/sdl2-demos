if (ANDROID)

    message ("Build Demo for Android")

    set (SDL2_PATH ${DEMO_SOURCE_DIR}/SDL)
    set (SDL2IMAGE ${DEMO_SOURCE_DIR}/SDL_image)
    set (SDL2TTF ${DEMO_SOURCE_DIR}/SDL_ttf)
    set (SDL2MIXER ${DEMO_SOURCE_DIR}/SDL_mixer)

    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DGL_GLEXT_PROTOTYPES")

    include_directories (${SDL2_PATH}/include ${SDL2IMAGE} ${SDL2TTF} ${SDL2MIXER})
    link_directories (${DEMO_SOURCE_DIR}/libs/armeabi-v7a)

    set (LIBS ${LIBS} SDL2 SDL2_image SDL2_ttf SDL2_mixer)

endif ()
