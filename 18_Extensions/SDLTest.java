package com.michaelborgmann.sdltest;
import org.libsdl.app.SDLActivity;
public class SDLTest extends SDLActivity {

    // Load the .so
    static {
        System.loadLibrary("SDL2");
        System.loadLibrary("SDL2_image");
        System.loadLibrary("SDL2_mixer");
        //System.loadLibrary("SDL2_net");
        System.loadLibrary("SDL2_ttf");
        System.loadLibrary("main");
        //System.loadLibrary("");		// Load your own libs
    }

}
