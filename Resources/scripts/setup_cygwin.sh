#!/bin/bash

################################################################################
# Get SDL2 + Liraries
################################################################################

mkdir cygdl
cd cygdl
wget http://libsdl.org/release/SDL2-2.0.3.tar.gz
wget http://libsdl.org/projects/SDL_image/release/SDL2_image-2.0.0.tar.gz
wget http://libsdl.org/projects/SDL_mixer/release/SDL2_mixer-2.0.0.tar.gz
wget http://libsdl.org/projects/SDL_net/release/SDL2_net-2.0.0.tar.gz
wget http://libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.12.tar.gz
wget http://download.savannah.gnu.org/releases/freetype/freetype-2.5.3.tar.gz

################################################################################
# Extract Sources
################################################################################

mkdir src
cd src
tar xzf ../SDL2-2.0.3.tar.gz
tar xzf ../SDL2_image-2.0.0.tar.gz
tar xzf ../SDL2_mixer-2.0.0.tar.gz
tar xzf ../SDL2_net-2.0.0.tar.gz
tar xzf ../SDL2_ttf-2.0.12.tar.gz
tar xzf ../freetype-2.5.3.tar.gz

################################################################################
# Build SDL2
################################################################################

cd SDL2-2.0.3
./configure
make
make install
cd ..

################################################################################
# Build SDL2 Image Library
################################################################################

cd SDL2_image-2.0.0

#### External Libraries
cd external

cd libpng-1.6.2						# libpng
./configure
make
make install
cd ..

cd jpeg-9							# jpeg-9
./configure
make
make install
cd ..

cd libwebp-0.3.0						# libwebp-0.3.0
./configure
make
make install
cd ..

cd tiff-4.0.3							# tiff-4.0.3
./configure
make
make install
cd ..

cd zlib-1.2.8							# zlib-1.2.8
./configure
make
make install
cd ..

cd ..

#### SDL2 Image Library
./configure
make
make install
cd ..

################################################################################
# Build SDL2 Mixer Library
################################################################################

apt-cyg install libvorbis-devel libogg-devel

cd SDL2_mixer-2.0.0

#### External Libraries
cd external

cd libmikmod-3.1.12						# libmikmod-3.1.12
./configure
make
make install
cd ..

cd libmodplug-0.8.8.4						# libmodplug-0.8.8.4
./configure
make
make install
cd ..

cd smpeg2-2.0.0						# smpeg2-2.0.0
./configure
make
make install
cd ..

#cd libogg-1.3.1						# libogg-1.3.1
#./configure
#make
#make install
#cd ..

#cd libvorbis-1.3.3						# libvorbis-1.3.3
#./configure
#make
#make install
#cd ..

cd ..

#### SDL2 Mixer Library
sed -i "s|-mno-cygwin||g" ./configure
./configure
make
make install
cd ..

################################################################################
# Build SDL2 Net Library
################################################################################

cd SDL2_net-2.0.0
./configure
make
make install
cd ..

################################################################################
# Build Freetype for SDL2 TTF
################################################################################

cd freetype-2.5.3
./configure
make
make install
cd ..

cd SDL2_ttf-2.0.12
./configure
make
make install
cd ..

cd
