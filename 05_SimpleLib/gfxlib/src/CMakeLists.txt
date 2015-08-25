if (APPLE)
  if (IOS_PLATFORM)
    include_directories (${SDL2_INCLUDE})
  else () # MACOSX_PLATFORM
  endif ()
endif (APPLE)

include_directories (../include ${SDL2_INCLUDE})

add_library (GFXLib GFXLib.cpp)
