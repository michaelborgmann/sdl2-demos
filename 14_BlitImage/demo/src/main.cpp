#include "GFXLib.h"

int main(int argc, char *argv[]) {

    try {
        GFXLib sdl(640, 480, SDL_INIT_EVERYTHING);
        sdl.loadImage("Mitch.bmp");

        bool done = false;
        while (!done) {
            done = sdl.events();
            sdl.render();
        }
    }
    catch (const Error &err) {
        std::cerr << "SDL2 ERROR: " << err.what() << std::endl;
        return 1;
    }

   return 0;

}
