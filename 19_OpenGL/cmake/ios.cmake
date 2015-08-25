if (APPLE AND IOS_PLATFORM)

    message ("Build for iOS")

    set(CMAKE_OSX_SYSROOT iphonesimulator7.1)
    set(CMAKE_OSX_ARCHITECTURES "$(ARCHS_STANDARD_32_BIT)")

    set (SDL2_PATH ${DEMO_SOURCE_DIR}/SDL)
    set (SDL2_INCLUDE ${SDL2_PATH}/include)
    set (SDL2_LIBRARY ${SDL2_PATH}/Xcode-iOS/SDL/build/Debug-iphonesimulator)


    set (BUILD_FLAGS MACOSX_BUNDLE)

    set (RESOURCES ${RESOURCES_DIR}/share/icons/128x128.png)
    set (MACOSX_BUNDLE_ICON_FILE 128x128.png)
    set_source_files_properties (${RESOURCES} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)

    set (MACOSX_BUNDLE_GUI_IDENTIFIER "com.michaelborgmann.\${PRODUCT_NAME:identifier}")

    set (IOS_FRAMEWORKS
         Foundation
         AudioToolbox
         CoreGraphics
         QuartzCore
         UIKit
         OpenGLES 
    )

    foreach (FW ${IOS_FRAMEWORKS})
        set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework ${FW}")
    endforeach ()

    message (${SDL2_LIBRARY})

    link_directories (${SDL2_LIBRARY})
    include_directories (${SDL2_INCLUDE})

    set (LIBS ${LIBS} SDL2)

endif ()
