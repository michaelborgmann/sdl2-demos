set (GFXLIB_SOURCES GFXLib.cpp Error.cpp)
include_directories (../include ${SDL2_INCLUDE})

if (ANDROID)
  add_library(GFXLib SHARED ${GFXLIB_SOURCES})
  target_link_libraries (GFXLib ${SDL2_LIBS})		# Linux
  #target_link_libraries (GFXLib)		# Mac OS X
else ()
  add_library (GFXLib ${GFXLIB_SOURCES})
endif()
