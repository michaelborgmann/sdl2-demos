cmake_minimum_required(VERSION 2.8)
project(DEMO)

set (SDL2_PATH_IOS /Users/michael/Library/Developer/SDL2)
set (SDL2_PATH_MSVC C:/Users/michael/SDKs/MSVC/SDL2-2.0.0)
set (SDL2_PATH_MINGW C:/Users/michael/SDKs/MinGW/SDL2-2.0.0/i686-w64-mingw32)
set (SDL2_PATH_ANDROID ${DEMO_SOURCE_DIR}/SDL)

set (CMAKE_MODULE_PATH
     ${CMAKE_MODULE_PATH}
     ${DEMO_SOURCE_DIR}/../Resources/3rdParty/CMake/Modules
)

### Apple + iOS ################################################################

if (APPLE)

  set (RESOURCES ${DEMO_SOURCE_DIR}/../Resources/share/Icon.png) 
  set_source_files_properties (${RESOURCES} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)
  set (MACOSX_BUNDLE_GUI_IDENTIFIER "com.michaelborgmann.\${PRODUCT_NAME:identifier}")
  set (BUILD_FLAGS MACOSX_BUNDLE)

  if (IOS_PLATFORM)
    message ("Build Demo for iOS")

    set (SDL2_INCLUDE ${SDL2_PATH_IOS}/include)
    set (SDL2_LIBRARY ${SDL2_PATH_IOS}/Xcode-iOS/SDL/build/Release-iphonesimulator)

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

    link_directories (${SDL2_LIBRARY})

  else () # MACOSX_PLATFORM
    message ("Build Demo for Mac OS X")
    include (FindSDL2)
    set (SDL2_INCLUDE ${SDL2_INCLUDE_DIR})
    link_libraries (${SDL2_LIBRARY})
  endif ()
endif (APPLE)

### Android ####################################################################

if (${CMAKE_SYSTEM_NAME} MATCHES Linux)

  if (ANDROID)
    message ("Build Demo for Android")

    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DGL_GLEXT_PROTOTYPES")

    include_directories (${SDL2_PATH_ANDROID}/include)

    file (GLOB SDL2_SOURCES 
          ${SDL2_PATH_ANDROID}/src/*.c
          ${SDL2_PATH_ANDROID}/src/audio/*.c
          ${SDL2_PATH_ANDROID}/src/audio/android/*.c
          ${SDL2_PATH_ANDROID}/src/audio/dummy/*.c
          ${SDL2_PATH_ANDROID}/src/atomic/SDL_atomic.c
          ${SDL2_PATH_ANDROID}/src/atomic/SDL_spinlock.c
          ${SDL2_PATH_ANDROID}/src/core/android/*.c
          ${SDL2_PATH_ANDROID}/src/cpuinfo/*.c
          ${SDL2_PATH_ANDROID}/src/dynapi/*.c
          ${SDL2_PATH_ANDROID}/src/events/*.c
          ${SDL2_PATH_ANDROID}/src/file/*.c
          ${SDL2_PATH_ANDROID}/src/haptic/*.c
          ${SDL2_PATH_ANDROID}/src/haptic/dummy/*.c
          ${SDL2_PATH_ANDROID}/src/joystick/*.c
          ${SDL2_PATH_ANDROID}/src/joystick/android/*.c
          ${SDL2_PATH_ANDROID}/src/loadso/dlopen/*.c
          ${SDL2_PATH_ANDROID}/src/power/*.c
          ${SDL2_PATH_ANDROID}/src/power/android/*.c
          ${SDL2_PATH_ANDROID}/src/filesystem/dummy/*.c
          ${SDL2_PATH_ANDROID}/src/render/*.c
          ${SDL2_PATH_ANDROID}/src/render/*/*.c
          ${SDL2_PATH_ANDROID}/src/stdlib/*.c
          ${SDL2_PATH_ANDROID}/src/thread/*.c
          ${SDL2_PATH_ANDROID}/src/thread/pthread/*.c
          ${SDL2_PATH_ANDROID}/src/timer/*.c
          ${SDL2_PATH_ANDROID}/src/timer/unix/*.c
          ${SDL2_PATH_ANDROID}/src/video/*.c
          ${SDL2_PATH_ANDROID}/src/video/android/*.c
          ${SDL2_PATH_ANDROID}/src/test/*.c
    )

    add_library (SDL2 SHARED ${SDL2_SOURCES})
    target_link_libraries (SDL2 dl GLESv1_CM GLESv2 log android m)

    set (SDL2_LIBS SDL2)


### Linux ######################################################################

  else () # LINUX
    message ("Build Demo for Unix/Linux")
    include (FindSDL2)
    set (SDL2_LIBS SDL2)
  endif()

endif ()

### Windows (MSVC + MinGW) #####################################################

if (WIN32)
  set (BUILD_FLAGS WIN32)
  if (MSVC)
    message ("Build for MSVC")
    set (LIBS SDL2main)
    include_directories (SDL2_INCLUDE ${SDL2_PATH_MSVC}/include)
    link_directories (${SDL2_PATH_MSVC}/lib/x86)

  elseif (MINGW)
    message ("Build for MinGW")
    set (LIBS mingw32 SDL2main)
    include_directories (SDL2_INCLUDE ${SDL2_PATH_MINGW}/include)
    link_directories (${SDL2_PATH_MINGW}/lib)
  endif ()
endif (WIN32)

################################################################################

set (HEADERS ${DEMO_SOURCE_DIR}/gfxlib/include)

add_subdirectory(gfxlib/src)
add_subdirectory(demo/src)
#set (DEMO_SOURCES main.cpp)
