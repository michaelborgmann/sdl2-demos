#include <iostream>
#include "GFXLib.h"

int main(int argc, char *argv[]) {

    GFX::GFXLib sdl;
    Image image("Mitch.bmp", sdl.get());

    int done = false;
    while (!done) {
        done = sdl.events();
	sdl.scene();
	image.draw();
        sdl.render();
    }

    return 0;
}
