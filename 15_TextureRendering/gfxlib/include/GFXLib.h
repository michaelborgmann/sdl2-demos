#ifndef _GFXLIB_H_
#define _GFXLIB_H_

#include <iostream>
#include <string>
#include <SDL2/SDL.h>
#include <SDL2/SDL_opengl.h>
//#include <SDL2/SDL_opengles.h>
#include "Error.h"
#include "Image.h"

namespace GFX {

    class GFXLib {
        SDL_Window* window;
        SDL_Renderer* renderer;
        SDL_Event event;
        Image* image;

        int width, height;
        bool done;

        void initialize(Uint32 flags);
        void shutdown();
        void createWindow(int displayNumber = 0);
    public:
        GFXLib(int width = 0, int height = 0, Uint32 flags = SDL_INIT_EVERYTHING);
        ~GFXLib();
        SDL_Renderer* get();
    	bool events();
        void scene();
        void render();
    };

} // GFX

#endif
