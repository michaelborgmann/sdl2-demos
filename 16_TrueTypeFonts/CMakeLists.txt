cmake_minimum_required(VERSION 2.8)
project(DEMO)

add_definitions (-std=c++11)

set (LIBRARY_PATH_WIN C:/Users/Michael/SDKs)
set (IOS_PATH /Users/michael/Library/Developer)
set (MINGW_PATH ${LIBRARY_PATH_WIN}/MinGW)
set (MSVC_PATH ${LIBRARY_PATH_WIN}/MSVC)
set (ANDROID_PATH /opt/android)

set (SDL2_IOS ${IOS_PATH}/SDL2)
set (SDL2_MINGW ${MINGW_PATH}/SDL2/i686-w64-mingw32)
set (SDL2_MSVC ${MSVC_PATH}/SDL2)
set (SDL2_ANDROID ${DEMO_SOURCE_DIR}/SDL)

set (SDL2TTF_IOS ${IOS_PATH}/SDL2_ttf)
set (SDL2TTF_MINGW ${MINGW_PATH}/SDL2_ttf/i686-w64-mingw32)
set (SDL2TTF_MSVC ${MSVC_PATH}/SDL2_ttf)
set (SDL2TTF_ANDROID ${DEMO_SOURCE_DIR}/SDL_ttf)

set (HEADERS ${DEMO_SOURCE_DIR}/gfxlib/include)
set (SHARE ${DEMO_SOURCE_DIR}/../Resources/share)

set (CMAKE_MODULE_PATH
     ${CMAKE_MODULE_PATH}
     ${DEMO_SOURCE_DIR}/../Resources/3rdParty/CMake/Modules
)

set (RESOURCES
     ${SHARE}/Icon.png
     ${SHARE}/lazy.ttf
     ${SHARE}/Mitch.bmp
)

### Apple + iOS ################################################################

if (APPLE)

  set (MACOSX_BUNDLE_GUI_IDENTIFIER "com.michaelborgmann.\${PRODUCT_NAME:identifier}")
  set (BUILD_FLAGS MACOSX_BUNDLE)

  if (IOS_PLATFORM)
    message ("Build Demo for iOS")

    set (SDL2_INCLUDE ${SDL2_IOS}/include)
    set (SDL2_LIBRARY ${SDL2_IOS}/Xcode-iOS/SDL/build/Release-iphonesimulator)

    set (SDL2TTF_INCLUDE ${SDL2TTF_IOS}/..)	# orginally ${LIBRARY_PATH_IOS} ?
    set (SDL2TTF_LIBRARY ${SDL2TTF_IOS}/libs)

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

    set (LIBRARY_HEADERS ${SDL2_INCLUDE} ${SDL2TTF_INCLUDE})
    link_directories (${SDL2_LIBRARY} ${SDL2TTF_LIBRARY})

  else () # MACOSX_PLATFORM
    message ("Build Demo for Mac OS X")

    include (FindSDL2)
    set (SDL2_INCLUDE ${SDL2_INCLUDE_DIR})

    include (FindSDL2_ttf)
    set (SDL2TTF_INCLUDE ${SDL2TTF_INCLUDE_DIR})
    
    link_libraries (${SDL2_LIBRARY} ${SDL2TTF_LIBRARY})

  endif ()

endif (APPLE)

### Android ####################################################################

if (${CMAKE_SYSTEM_NAME} MATCHES Linux)

  if (ANDROID)
    message ("Build Demo for Android")

    set (SDL2TTF_INCLUDE ${SDL2TTF_ANDROID}/..)
    set (LIBRARY_HEADERS ${SDL2TTF_INCLUDE})

    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DGL_GLEXT_PROTOTYPES")

    include_directories (${SDL2_ANDROID}/include)

    file (GLOB SDL2_SOURCES 
          ${SDL2_ANDROID}/src/*.c
          ${SDL2_ANDROID}/src/audio/*.c
          ${SDL2_ANDROID}/src/audio/android/*.c
          ${SDL2_ANDROID}/src/audio/dummy/*.c
          ${SDL2_ANDROID}/src/atomic/SDL_atomic.c
          ${SDL2_ANDROID}/src/atomic/SDL_spinlock.c
          ${SDL2_ANDROID}/src/core/android/*.c
          ${SDL2_ANDROID}/src/cpuinfo/*.c
          ${SDL2_ANDROID}/src/dynapi/*.c
          ${SDL2_ANDROID}/src/events/*.c
          ${SDL2_ANDROID}/src/file/*.c
          ${SDL2_ANDROID}/src/haptic/*.c
          ${SDL2_ANDROID}/src/haptic/dummy/*.c
          ${SDL2_ANDROID}/src/joystick/*.c
          ${SDL2_ANDROID}/src/joystick/android/*.c
          ${SDL2_ANDROID}/src/loadso/dlopen/*.c
          ${SDL2_ANDROID}/src/power/*.c
          ${SDL2_ANDROID}/src/power/android/*.c
          ${SDL2_ANDROID}/src/filesystem/dummy/*.c
          ${SDL2_ANDROID}/src/render/*.c
          ${SDL2_ANDROID}/src/render/*/*.c
          ${SDL2_ANDROID}/src/stdlib/*.c
          ${SDL2_ANDROID}/src/thread/*.c
          ${SDL2_ANDROID}/src/thread/pthread/*.c
          ${SDL2_ANDROID}/src/timer/*.c
          ${SDL2_ANDROID}/src/timer/unix/*.c
          ${SDL2_ANDROID}/src/video/*.c
          ${SDL2_ANDROID}/src/video/android/*.c
          ${SDL2_ANDROID}/src/test/*.c
    )

    add_library (SDL2 SHARED ${SDL2_SOURCES})
    target_link_libraries (SDL2 dl GLESv1_CM GLESv2 log android m)

    set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DFT2_BUILD_LIBRARY")

    set (FREETYPE ${SDL2TTF_ANDROID}/freetype-2.5.3)
    include_directories (${FREETYPE}/include)

    file (GLOB SDL2TTF_SOURCES
          ${SDL2TTF_ANDROID}/SDL_ttf.c
          ${FREETYPE}/src/autofit/autofit.c
          ${FREETYPE}/src/base/ftbase.c
          ${FREETYPE}/src/base/ftbbox.c
          ${FREETYPE}/src/base/ftbdf.c
          ${FREETYPE}/src/base/ftbitmap.c
          ${FREETYPE}/src/base/ftcid.c
          ${FREETYPE}/src/base/ftdebug.c
          ${FREETYPE}/src/base/ftfstype.c
          ${FREETYPE}/src/base/ftgasp.c
          ${FREETYPE}/src/base/ftglyph.c
          ${FREETYPE}/src/base/ftgxval.c
          ${FREETYPE}/src/base/ftinit.c
          ${FREETYPE}/src/base/ftlcdfil.c
          ${FREETYPE}/src/base/ftmm.c
          ${FREETYPE}/src/base/ftotval.c
          ${FREETYPE}/src/base/ftpatent.c
          ${FREETYPE}/src/base/ftpfr.c
          ${FREETYPE}/src/base/ftstroke.c
          ${FREETYPE}/src/base/ftsynth.c
          ${FREETYPE}/src/base/ftsystem.c
          ${FREETYPE}/src/base/fttype1.c
          ${FREETYPE}/src/base/ftwinfnt.c
          ${FREETYPE}/src/base/ftxf86.c
          ${FREETYPE}/src/bdf/bdf.c
          ${FREETYPE}/src/bzip2/ftbzip2.c
          ${FREETYPE}/src/cache/ftcache.c
          ${FREETYPE}/src/cff/cff.c
          ${FREETYPE}/src/cid/type1cid.c
          ${FREETYPE}/src/gzip/ftgzip.c
          ${FREETYPE}/src/lzw/ftlzw.c
          ${FREETYPE}/src/pcf/pcf.c
          ${FREETYPE}/src/pfr/pfr.c
          ${FREETYPE}/src/psaux/psaux.c
          ${FREETYPE}/src/pshinter/pshinter.c
          ${FREETYPE}/src/psnames/psmodule.c
          ${FREETYPE}/src/raster/raster.c
          ${FREETYPE}/src/sfnt/sfnt.c
          ${FREETYPE}/src/smooth/smooth.c
          ${FREETYPE}/src/tools/apinames.c
          ${FREETYPE}/src/truetype/truetype.c
          ${FREETYPE}/src/type1/type1.c
          ${FREETYPE}/src/type42/type42.c
          ${FREETYPE}/src/winfonts/winfnt.c
    )

    add_library (SDL_ttf SHARED ${SDL2TTF_SOURCES})
    target_link_libraries (SDL_ttf SDL2)

    set (SDL2_LIBS SDL2 SDL_ttf)

### Linux ######################################################################

  else () # LINUX
    message ("Build Demo for Unix/Linux")
    include (FindSDL2)
    include (FindSDL2_ttf)
    set (SDL2_LIBS SDL2 SDL2_ttf)
  endif ()
endif ()

if (WIN32)
  set (BUILD_FLAGS WIN32)
  if (MSVC)
    message ("Build for MSVC")
    set (LIBS SDL2main)
    include_directories (${SDL2_MSVC}/include)
    link_directories (${SDL2_MSVC}/lib/x86 ${SDL2TTF_MSVC}/lib/x86)

  elseif (MINGW)
    message ("Build for MinGW")
    set (LIBS mingw32 SDL2main)
    include_directories (${SDL2_MINGW}/include)
    link_directories (${SDL2_MINGW}/lib ${SDL2TTF_MINGW}/lib)
  endif ()
endif (WIN32)

add_subdirectory(gfxlib/src)
add_subdirectory(demo/src)
