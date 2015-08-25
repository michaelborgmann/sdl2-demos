cd android
./project_create.sh
cd ..

mkdir -p android/src/com/michaelborgmann/sdltest
cp src/SDLTest.java android/src/com/michaelborgmann/sdltest/
cp -rf libs android/

sed -i "s|org\.libsdl\.app|com\.michaelborgmann\.sdltest|g" android/AndroidManifest.xml
sed -i "s|SDLActivity|SDLTest|g" android/AndroidManifest.xml
sed -i "s|SDLActivity|SDLTest|g" android/build.xml
