#include "GFXLib.h"

using namespace GFX;

GFXLib::GFXLib(int w, int h, Uint32 flags) 
       : window(NULL), renderer(NULL),
         width(w), height(h) {
    
    initialize(flags);
}

GFXLib::~GFXLib() {
    shutdown();
}

SDL_Renderer* GFXLib::get() {
    return renderer;
}

void GFXLib::initialize(Uint32 flags) {
    if (SDL_Init(flags) != 0) {} //{ throw Error(SDL_GetError()); }

    createWindow();

    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "linear");
    SDL_RenderSetLogicalSize(renderer, 640, 480);

}

void GFXLib::shutdown() {
    if (renderer) {
        SDL_DestroyRenderer(renderer);
        renderer = NULL;
    }
    if (window) {
        SDL_DestroyWindow(window);
        window = NULL;
    }
    SDL_Quit();
}

void GFXLib::createWindow(int displayNumber) {
     if (displayNumber >= SDL_GetNumVideoDisplays()) {} // { throw Error(SDL_GetError()); }
     else {
        SDL_Rect display;
        if (SDL_GetDisplayBounds(displayNumber, &display) != 0) {} // { throw Error(SDL_GetError()); }
        else {
            window = SDL_CreateWindow(NULL, display.x, display.y, 0, 0, SDL_WINDOW_FULLSCREEN_DESKTOP | SDL_WINDOW_BORDERLESS); 
            if (!window) {} //{ throw Error(SDL_GetError()); }
            renderer = SDL_CreateRenderer(window, -1, 0);
            if (!renderer) {} // { throw Error(SDL_GetError()); }
        }
    }

}

bool GFXLib::events() {
    while (SDL_PollEvent(&event)) {
        if (event.type == SDL_QUIT) return true;
        if (event.type == SDL_KEYDOWN) return true;
        if (event.type == SDL_FINGERDOWN) return true;
    }
    return false;
}

void GFXLib::scene() {
    SDL_SetRenderDrawColor(renderer, 0, 0x22, 0x44, 0xff);
    SDL_RenderClear(renderer);
}

void GFXLib::render() {
    SDL_RenderPresent(renderer);
}
