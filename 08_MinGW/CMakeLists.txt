cmake_minimum_required(VERSION 2.8)
project (WINMSVC)

set (CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++")

if (WIN32)
  if (MINGW)

    message ("Build for MinGW")

    include_directories (SDL2_INCLUDE C:/SDKs/SDL2-2.0.3/include)
    link_directories (C:/SDKs/SDL2-2.0.3/i686-w64-mingw32/lib)

    add_executable (SDLTest WIN32 main.cpp)
    target_link_libraries (SDLTest mingw32 SDL2main SDL2)
  endif (MINGW)
endif (WIN32)
