cmake_minimum_required(VERSION 2.8)
project (WINMSVC)

if (WIN32)
  if (MSVC)
    message ("Build for MSVC")

    include_directories (SDL2_INCLUDE C:/SDKs/SDL2-2.0.3/include)
    link_directories (C:/SDKs/SDL2-2.0.3/lib/x86)

    add_executable (SDLTest WIN32 main.cpp)
    target_link_libraries (SDLTest SDL2main SDL2)
  endif (MSVC)
endif (WIN32)
