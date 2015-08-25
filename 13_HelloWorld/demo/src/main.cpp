#include "GFXLib.h"

int main(int argc, char *argv[]) {

    try {
        GFXLib sdl(640, 480, SDL_INIT_EVERYTHING);
        return 0;
    }
    catch (const Error &err) {
        std::cerr << "ERROR: Couldn't initialize SDL2: " << err.what() << std::endl;
        return 1;
    }

   return 0;

}
