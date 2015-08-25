if (ANDROID)

    message ("Build Demo for Android")

    set (SDL2_PATH ${DEMO_SOURCE_DIR}/SDL)

    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DGL_GLEXT_PROTOTYPES")

    include_directories (${SDL2_PATH}/include)
    link_directories (${SDL2_PATH}/android-project/libs/armeabi-v7a)

    set (LIBS ${LIBS} SDL2)

endif ()
