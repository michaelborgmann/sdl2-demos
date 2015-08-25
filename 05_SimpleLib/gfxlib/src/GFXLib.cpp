#include "GFXLib.h"

GFXLib::GFXLib() : done(false) {
    initialize();
    scene();
    render();
}

GFXLib::~GFXLib() {
    shutdown();
}

void GFXLib::initialize() {
    // init video
    SDL_Init(SDL_INIT_VIDEO);

    /* Create Window + Renderer for iOS (iPhone + iPad)
    SDL_CreateWindowAndRenderer(0, 0, SDL_WINDOW_BORDERLESS | SDL_WINDOW_OPENGL, &window, &renderer);
    */

    SDL_CreateWindowAndRenderer(0, 0, SDL_WINDOW_FULLSCREEN_DESKTOP, &window, &renderer);

    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "linear");
    SDL_RenderSetLogicalSize(renderer, 640, 480);
}

void GFXLib::shutdown() {
    if (renderer) SDL_DestroyRenderer(renderer);
    if (window) SDL_DestroyWindow(window);
    SDL_Quit();
}

void GFXLib::scene() {
    while (!done) {
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) done = true;
        }
        render();
    }
}

void GFXLib::render() {
    SDL_SetRenderDrawColor(renderer, 0xff, 0, 0, 0xff);
    SDL_RenderClear(renderer);
    SDL_RenderPresent(renderer);
}
