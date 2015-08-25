if (${CMAKE_SYSTEM_NAME} MATCHES "Linux" AND NOT ANDROID)
    message ("Build for Linux")
    include (FindSDL2)
    link_libraries(${SDL2_LIBRARY} SDL2_image SDL2_ttf SDL2_mixer)
endif ()