cmake_minimum_required(VERSION 2.8)

project(SDL2)

set(SDL_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/SDL)

if(NOT EXISTS ${SDL_ROOT})
     message(FATAL_ERROR
             "${SDL_ROOT} does not exist!
             Please run ${CMAKE_CURRENT_SOURCE_DIR}/get_sdl2.sh to get a patched copy of SDL2"
     )
endif()

set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DGL_GLEXT_PROTOTYPES")

include_directories(${SDL_ROOT}/include)

file (GLOB SOURCES 
      ${SDL_ROOT}/src/*.c
      ${SDL_ROOT}/src/audio/*.c
      ${SDL_ROOT}/src/audio/android/*.c
      ${SDL_ROOT}/src/audio/dummy/*.c
      ${SDL_ROOT}/src/atomic/SDL_atomic.c
      ${SDL_ROOT}/src/atomic/SDL_spinlock.c
      ${SDL_ROOT}/src/core/android/*.c
      ${SDL_ROOT}/src/cpuinfo/*.c
      ${SDL_ROOT}/src/dynapi/*.c
      ${SDL_ROOT}/src/events/*.c
      ${SDL_ROOT}/src/file/*.c
      ${SDL_ROOT}/src/haptic/*.c
      ${SDL_ROOT}/src/haptic/dummy/*.c
      ${SDL_ROOT}/src/joystick/*.c
      ${SDL_ROOT}/src/joystick/android/*.c
      ${SDL_ROOT}/src/loadso/dlopen/*.c
      ${SDL_ROOT}/src/power/*.c
      ${SDL_ROOT}/src/power/android/*.c
      ${SDL_ROOT}/src/filesystem/dummy/*.c
      ${SDL_ROOT}/src/render/*.c
      ${SDL_ROOT}/src/render/*/*.c
      ${SDL_ROOT}/src/stdlib/*.c
      ${SDL_ROOT}/src/thread/*.c
      ${SDL_ROOT}/src/thread/pthread/*.c
      ${SDL_ROOT}/src/timer/*.c
      ${SDL_ROOT}/src/timer/unix/*.c
      ${SDL_ROOT}/src/video/*.c
      ${SDL_ROOT}/src/video/android/*.c
      ${SDL_ROOT}/src/test/*.c
)

add_library (SDL2 SHARED ${SOURCES})
target_link_libraries (SDL2 dl GLESv1_CM GLESv2 log android m)

add_library (main SHARED
             ${SDL_ROOT}/src/main/android/SDL_android_main.c
             src/testgles.c)
target_link_libraries (main SDL2)
