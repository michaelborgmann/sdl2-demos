cmake_minimum_required(VERSION 2.8)
project (LINUX)

if (UNIX)
  message ("Build for UNIX/Linux")
  set (CMAKE_MODULE_PATH
       ${CMAKE_MODULE_PATH}
       ${LINUX_SOURCE_DIR}/../Resources/3rdParty/CMake/Modules
  )
  include (FindSDL2)

endif (UNIX)

add_executable (Linux main.cpp)
target_link_libraries (Linux SDL2)
