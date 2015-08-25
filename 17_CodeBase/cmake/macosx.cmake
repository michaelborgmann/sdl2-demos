if (APPLE AND NOT IOS_PLATFORM)

    message ("Build for Mac OS X")

    set (RESOURCES ${RESOURCES_DIR}/share/icons/mitch.icns)
    set (BUILD_FLAGS MACOSX_BUNDLE)
    set (MACOSX_BUNDLE_ICON_FILE mitch.icns)

    set_source_files_properties (${RESOURCES} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)
    set (MACOSX_BUNDLE_GUI_IDENTIFIER "com.michaelborgmann.\${PRODUCT_NAME:identifier}")
    include (FindSDL2)
    link_libraries (${SDL2_LIBRARY})

endif ()
