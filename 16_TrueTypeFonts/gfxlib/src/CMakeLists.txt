set (GFXLIB_SOURCES Error.cpp GFXLib.cpp Image.cpp Fonts.cpp)
include_directories (../include ${LIBRARY_HEADERS})

if (ANDROID)
  add_library(GFXLib SHARED ${GFXLIB_SOURCES})
  target_link_libraries (GFXLib ${SDL2_LIBS})
  #target_link_libraries (GFXLib)
else ()
  add_library (GFXLib ${GFXLIB_SOURCES})
endif()

