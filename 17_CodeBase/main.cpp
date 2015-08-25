#include <SDL2/SDL.h>

int main (int argc, char *argv[]) {

    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Event event;

    SDL_Init(SDL_INIT_VIDEO);

    SDL_CreateWindowAndRenderer(0, 0, SDL_WINDOW_FULLSCREEN_DESKTOP, &window, &renderer);

    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "linear");
    SDL_RenderSetLogicalSize(renderer, 640, 480);

    SDL_SetRenderDrawColor(renderer, 0, 50, 70, 255);
    SDL_RenderClear(renderer);
    SDL_RenderPresent(renderer);

    bool done = false;
    while (!done) {
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) done = true;
            if (event.type == SDL_KEYDOWN) done = true;
            if (event.type == SDL_FINGERDOWN) done = true;
        }
    }

    SDL_Quit();
    return 0;
}
