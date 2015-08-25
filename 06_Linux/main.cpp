#include <SDL2/SDL.h>

int main () {

    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Event event;

    SDL_Init(SDL_INIT_VIDEO);

    SDL_CreateWindowAndRenderer(0, 0, SDL_WINDOW_FULLSCREEN_DESKTOP, &window, &renderer);

    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "linear");
    SDL_RenderSetLogicalSize(renderer, 640, 480);

/*    bool done = false;
    while (!done) {
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) done = true;
        }
    }
*/

    SDL_Delay(3000);

    SDL_Quit();
    return 0;
}
