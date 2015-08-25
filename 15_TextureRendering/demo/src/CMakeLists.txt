set (DEMO_SOURCES main.cpp)

include_directories (${SDL2_INCLUDE} ${HEADERS})

if (APPLE)
    set_source_files_properties(${RESOURCES} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)
endif (APPLE)

if (ANDROID)
  add_library (main SHARED
               ${SDL2_PATH_ANDROID}/src/main/android/SDL_android_main.c
               ${DEMO_SOURCES}
              )
  target_link_libraries (main GFXLib)

# ANYTHING ELSE: Linux, OSX, iOS, MinGW, MSVC
else ()
  add_executable (Demo ${BUILD_FLAGS} ${DEMO_SOURCES} ${RESOURCES})
  target_link_libraries(Demo ${LIBS} GFXLib ${SDL2_LIBS})	# Linux
  #target_link_libraries(Demo ${LIBS} GFXLib)		# Mac OS X
endif()
