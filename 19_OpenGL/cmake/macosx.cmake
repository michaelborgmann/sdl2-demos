if (APPLE AND NOT IOS_PLATFORM)

    message ("Build for Mac OS X")

    set (RESOURCES ${RESOURCES} ${SHARE}/icons/mitch.icns)
    set (BUILD_FLAGS MACOSX_BUNDLE)
    set (MACOSX_BUNDLE_ICON_FILE mitch.icns)

    set_source_files_properties (${RESOURCES} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)
    set (MACOSX_BUNDLE_GUI_IDENTIFIER "com.michaelborgmann.\${PRODUCT_NAME:identifier}")
    include (FindSDL2)
    include (FindSDL2_image)
    include (FindSDL2_ttf)
    include (FindSDL2_mixer)
    include (FindOpenGL)
    link_libraries (${SDL2_LIBRARY} ${SDL2IMAGE_LIBRARY} ${SDL2TTF_LIBRARY} ${SDL2MIXER_LIBRARY} ${OPENGL_LIBRARIES})

endif ()
