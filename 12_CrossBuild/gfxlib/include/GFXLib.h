#include "SDL2/SDL.h"
//#include "SDL_opengles.h"

class GFXLib {
    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Event event;

    bool done;

    void initialize();
    void shutdown();
    void scene();
    void render();
public:
    GFXLib();
    ~GFXLib();
};
