cd android
./project_create.sh
cd ..

mkdir -p android/src/com/michaelborgmann/sdltest
cp SDLTest.java android/src/com/michaelborgmann/sdltest/
cp -rf libs android/

mkdir -p android/assets
cp ../Resources/share/Mitch.bmp android/assets/
cp ../Resources/share/lazy.ttf android/assets/

sed -i "s|org\.libsdl\.app|com\.michaelborgmann\.sdltest|g" android/AndroidManifest.xml
sed -i "s|SDLActivity|SDLTest|g" android/AndroidManifest.xml
sed -i "s|SDLActivity|SDLTest|g" android/build.xml
