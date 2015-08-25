cmake_minimum_required(VERSION 2.8)
project (DEMO) 

set (RESOURCES_DIR ${DEMO_SOURCE_DIR}/../Resources)

set (CMAKE_MODULE_PATH
         ${CMAKE_MODULE_PATH}
         ${RESOURCES_DIR}/3rdParty/CMake/Modules
)

set (RESOURCES
    ${RESOURCES_DIR}/share/Mitch.icns
    ${RESOURCES_DIR}/share/Mitch.bmp
)

if (APPLE)
    message ("Build for Mac OS X and iOS")
    set (BUILD_FLAGS MACOSX_BUNDLE)
    set (MACOSX_BUNDLE_ICON_FILE Mitch.icns)
    set_source_files_properties (${RESOURCES} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)
    #set_source_files_properties (${OSX_ICON_FILES} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)
    set (MACOSX_BUNDLE_GUI_IDENTIFIER "com.michaelborgmann.\${PRODUCT_NAME:identifier}")
    include (FindSDL2)
    set (SDL2_INCLUDE ${SDL2_INCLUDE_DIR})
    link_libraries (${SDL2_LIBRARY})
endif (APPLE)

include_directories (${SDL2_INCLUDE})

add_executable (demo ${BUILD_FLAGS} main.cpp ${RESOURCES})
#add_executable (demo ${BUILD_FLAGS} main.cpp ${OSX_ICON_FILES})

target_link_libraries (demo)
