#include <SDL/SDL.h>
 
int main (int argc, char *argv[]) {
 
    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Event event;
 
    SDL_Init(SDL_INIT_VIDEO);
 
    SDL_CreateWindowAndRenderer(0, 0, 0, &window, &renderer);
 
    int done = 0;
    while (!done) {
        while (SDL_PollEvent(&event)) {
            if (event.type == (SDL_QUIT || SDL_KEYDOWN || SDL_FINGERDOWN)) done = 1;
        }
        SDL_SetRenderDrawColor(renderer, 0xff, 0, 0, 0xff);
        SDL_RenderClear(renderer);
        SDL_RenderPresent(renderer);
    }
 
    exit(0);
 
    SDL_Quit();
    return 0;
}
