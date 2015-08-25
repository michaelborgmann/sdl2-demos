#include <iostream>
#include <sstream>
#include "GFXLib.h"

int main(int argc, char *argv[]) {

    GFX::GFXLib sdl;
    Image image("Mitch.bmp", sdl.get());
    Fonts font(sdl.get(), "lazy.ttf");

    //std::string number = std::to_string(42);
    std::stringstream ss;
    ss << 42;
    std::string number = ss.str();

    int done = false;
    while (!done) {
        done = sdl.events();
        sdl.scene();
        image.draw();
        font.print(0, 0, "Das geile Holz!");
        font.print(20, 20, number);
        sdl.render();
    }

    return 0;
}
