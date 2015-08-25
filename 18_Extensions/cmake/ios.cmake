if (APPLE AND IOS_PLATFORM)

    message ("Build for iOS")

    set(CMAKE_OSX_SYSROOT iphonesimulator7.1)
    set(CMAKE_OSX_ARCHITECTURES "$(ARCHS_STANDARD_32_BIT)")

    set (SDL2_PATH ${DEMO_SOURCE_DIR}/SDL)
    set (SDL2_INCLUDE ${SDL2_PATH}/include)
    #set (SDL2_LIBRARY ${SDL2_PATH}/Xcode-iOS/SDL/build/Debug-iphonesimulator)
    set (SDL2_LIBRARY ${SDL2_PATH}/Xcode-iOS/SDL/build)

    set (SDL2IMAGE ${DEMO_SOURCE_DIR}/SDL_image)
    set (SDL2IMAGE_INCLUDE ${SDL2IMAGE})
    #set (SDL2IMAGE_LIBRARY ${SDL2IMAGE}/Xcode-iOS/build/Debug-iphonesimulator)
    set (SDL2IMAGE_LIBRARY ${SDL2IMAGE}/Xcode-iOS/build)

    set (SDL2TTF ${DEMO_SOURCE_DIR}/SDL_ttf)
    set (SDL2TTF_INCLUDE ${SDL2TTF})
    #set (SDL2TTF_LIBRARY ${SDL2TTF}/Xcode-iOS/build/Debug-iphonesimulator)
    set (SDL2TTF_LIBRARY ${SDL2TTF}/Xcode-iOS/build)

    set (SDL2MIXER ${DEMO_SOURCE_DIR}/SDL_mixer)
    set (SDL2MIXER_INCLUDE ${SDL2MIXER})
    #set (SDL2MIXER_LIBRARY ${SDL2MIXER}/Xcode-iOS/build/Debug-iphonesimulator)
    set (SDL2MIXER_LIBRARY ${SDL2MIXER}/Xcode-iOS/build)

    set (BUILD_FLAGS MACOSX_BUNDLE)

    set (RESOURCES ${RESOURCES} ${SHARE}/icons/128x128.png)
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
         ImageIO
         MobileCoreServices
    )

    foreach (FW ${IOS_FRAMEWORKS})
        set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework ${FW}")
    endforeach ()

    link_directories (${SDL2_LIBRARY} ${SDL2IMAGE_LIBRARY} ${SDL2TTF_LIBRARY} ${SDL2MIXER_LIBRARY})
    include_directories (${SDL2_INCLUDE} ${SDL2IMAGE_INCLUDE} ${SDL2TTF_INCLUDE} ${SDL2MIXER_INCLUDE})

    set (LIBS ${LIBS} SDL2 SDL2_image SDL2_ttf SDL2_mixer)

endif ()
