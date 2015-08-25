#ifndef GFXLIB_H
#define GFXLIB_H

#include <iostream>
#include <SDL2/SDL.h>
#include <SDL2/SDL_opengl.h>
#include "Error.h"

//#include "SDL_opengles.h"

class GFXLib {
    SDL_Window* window;
    SDL_Surface* surface;
    SDL_Event event;

    int width, height;
    bool done;

    void initialize(Uint32 flags) throw (Error);
    void shutdown();
    void loop();
    void render();
public:
    GFXLib(int width = 320, int height = 240, Uint32 flags = SDL_INIT_EVERYTHING);
    virtual ~GFXLib();
};

#endif // GFXLIB_H
