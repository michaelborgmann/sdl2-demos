cmake_minimum_required(VERSION 2.8)
project(JOLLYROGER)

set (CMAKE_MODULE_PATH
     ${CMAKE_MODULE_PATH}
     ${JOLLYROGER_SOURCE_DIR}/../Resources/3rdParty/CMake/Modules
)

if (APPLE)
  if (IOS_PLATFORM)
    message ("Build Jolly Roger for iOS")
    set (SDL2_INCLUDE /Users/michael/Library/Developer/SDL2/include)
    set (SDL2_LIBRARY /Users/michael/Library/Developer/SDL2/Xcode-iOS/SDL/build/Release-iphonesimulator)
  else () # MACOSX_PLATFORM
    message ("Build Jolly Roger for Mac OS X")
    include (FindSDL2)
    set (SDL2_INCLUDE ${SDL2_INCLUDE_DIR})
  endif ()
endif (APPLE)

#if (UNIX)
if (${CMAKE_SYSTEM_NAME} MATCHES Linux)
  message ("Build Jolly Roger for Unix/Linux")
  include (FindSDL2)
endif ()

set (HEADERS ${JOLLYROGER_SOURCE_DIR}/gfxlib/include)

add_subdirectory(gfxlib/src)
add_subdirectory(jollyroger/src)
