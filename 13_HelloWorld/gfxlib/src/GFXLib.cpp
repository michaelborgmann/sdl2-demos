#include "GFXLib.h"

GFXLib::GFXLib(int w, int h, Uint32 flags) : width(w), height(h), done(false) {
    initialize(flags);
    loop();
}

GFXLib::~GFXLib() {
    shutdown();
}

void GFXLib::initialize(Uint32 flags) throw (Error) {

    if (SDL_Init(flags) != 0)
        throw Error(SDL_GetError());

    window = SDL_CreateWindow("Demo", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, width, height, SDL_WINDOW_SHOWN);
    if (!window)
        throw Error(SDL_GetError());

    surface = SDL_GetWindowSurface(window);
    if (!surface)
        throw Error(SDL_GetError());
}

void GFXLib::shutdown() {
    if (surface) SDL_FreeSurface(surface);
    if (window) SDL_DestroyWindow(window);
    SDL_Quit();
}

void GFXLib::loop() {
    while (!done) {
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) done = true;
            if (event.type == SDL_KEYDOWN) done = true;
        }
        render();
    }
}

void GFXLib::render() {
    SDL_FillRect(surface, NULL, SDL_MapRGB(surface->format, 0xff, 0xff, 0xff));
    SDL_UpdateWindowSurface(window);
}
