include_directories (../include ${SDL2_INCLUDE})

### Linux, OSX, iOS, MinGW, MSVC
#add_library (GFXLib GFXLib.cpp)

### Android
add_library(GFXLib SHARED GFXLib.cpp)
target_link_libraries (GFXLib ${SDL2_LIBS})	# Linux
#target_link_libraries (GFXLib)		# Mac OS X
