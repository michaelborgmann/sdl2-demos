cmake_minimum_required(VERSION 2.8)
project(MyApp)

set(HEADERS
    include/myapp/myapp.hpp
)
set(SOURCES
    src/main.cpp
)

set(IOS_FRAMEWORKS
    Foundation
    AudioToolbox
    CoreGraphics
    QuartzCore
    UIKit
    OpenGLES
)

set(CMAKE_OSX_SYSROOT iphonesimulator4.0)
set(CMAKE_OSX_ARCHITECTURES "$(ARCHS_STANDARD_32_BIT)")
foreach(FW ${IOS_FRAMEWORKS})
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework ${FW}")
endforeach()

include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/include
    ${CMAKE_CURRENT_SOURCE_DIR}/libs/SDL/include
)
link_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/libs/SDL
)

set(MACOSX_BUNDLE_GUI_IDENTIFIER "com.mycompany.\${PRODUCT_NAME:identifier}")

add_executable(
    MyApp
    MACOSX_BUNDLE
    ${HEADERS}
    ${SOURCES}
)

target_link_libraries(MyApp SDL2)
