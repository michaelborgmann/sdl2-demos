./project_create.sh

mkdir -p src/com/michaelborgmann/sdltest
cp SDLTest.java src/com/michaelborgmann/sdltest/

mkdir assets
SHARE="../Resources/share"
cp $SHARE/Mitch.bmp $SHARE/C-64.ttf $SHARE/icons/512x512.png $SHARE/Think-Life.ogg assets/

sed -i "" "s|org\.libsdl\.app|com\.michaelborgmann\.sdltest|g" AndroidManifest.xml
sed -i "" "s|SDLActivity|SDLTest|g" AndroidManifest.xml
sed -i "" "s|SDLActivity|SDLTest|g" build.xml
