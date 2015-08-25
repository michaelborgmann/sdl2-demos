cmake_minimum_required(VERSION 2.8.9)
project (DEMO) 

set (RESOURCES_DIR ${DEMO_SOURCE_DIR}/../Resources)
set (CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${RESOURCES_DIR}/3rdParty/CMake/Modules)

include(cmake/macosx.cmake)
include(cmake/ios.cmake)
include(cmake/linux.cmake)
include(cmake/android.cmake)
include(cmake/msvc.cmake)
include(cmake/mingw.cmake)
include(cmake/cygwin.cmake)


if (ANDROID) # must be called 'main'
    add_library (main SHARED
                 ${SDL2_PATH}/src/main/android/SDL_android_main.c
                 main.cpp
    )
    target_link_libraries (main ${LIBS})
else () # Linux, Mac OS X, iOS, Windows
    add_executable (demo ${BUILD_FLAGS} main.cpp ${RESOURCES})
    target_link_libraries (demo ${LIBS})
endif ()
