#ifdef __APPLE__
    #include <TargetConditionals.h>
#endif

#include <iostream>
#include <SDL2/SDL.h>

#if _WIN32 || __ANDROID__ || TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    #include <SDL_image.h>
    #include <SDL_ttf.h>
    #include <SDL_mixer.h>
#elif __linux__ || __CYGWIN__
    #include <SDL2/SDL_image.h>
    #include <SDL2/SDL_ttf.h>
    #include <SDL2/SDL_mixer.h>
#elif TARGET_OS_MAC
    #include <SDL2_image/SDL_image.h> 
    #include <SDL2_ttf/SDL_ttf.h>
    #include <SDL2_mixer/SDL_mixer.h>
#endif

SDL_Window *window;
SDL_Renderer *renderer;
SDL_Surface *bitmap;
SDL_Texture *image, *text;
SDL_Event event;

int main(int argc, char *argv[]) {

    // initialize
    SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO);
    IMG_Init(IMG_INIT_PNG);
    TTF_Init();

    // create windows
    SDL_CreateWindowAndRenderer(0, 0, SDL_WINDOW_FULLSCREEN_DESKTOP, &window, &renderer); 
    if (!window || !renderer) {
        std::cout << "couldn't create renderer\n";
        exit(1);
    }
    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "linear");
    SDL_RenderSetLogicalSize(renderer, 640, 480);

    // load image
    bitmap = IMG_Load("512x512.png");
    if (!bitmap) {
        std::cout << "couldn't load image: " << IMG_GetError() <<"\n";
        exit(1);
    }
    image = SDL_CreateTextureFromSurface(renderer, bitmap);
    SDL_FreeSurface(bitmap);

    // load music
    Mix_Music *music = Mix_LoadMUS("Think-Life.ogg");
    if (!music) {
        std::cout << "couldn't load music: " << Mix_GetError() << "\n";
        exit(1);
    }
    Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 2048);
    Mix_PlayMusic(music, -1);

    // load font
    TTF_Font *font = TTF_OpenFont("C-64.ttf", 24);
    if (!font) {
        std::cout << "couldn't load font\n";
        exit(1);
    }
    SDL_Color white = {0xff, 0xff, 0xff};
    bitmap = TTF_RenderText_Solid(font, "Cross Platform Demo!", white);
    text = SDL_CreateTextureFromSurface(renderer, bitmap); 
    SDL_Rect position = {10, 10, bitmap->w, bitmap->h};
    SDL_FreeSurface(bitmap);

    // draw  background
    SDL_SetRenderDrawColor(renderer, 0x00, 0x22, 0x44, 0xff);
    SDL_RenderClear(renderer);

    // draw image
    SDL_RenderCopy(renderer, image, NULL, NULL);

    // print text
    SDL_RenderCopy(renderer, text, NULL, &position);

    SDL_RenderPresent(renderer);

    // mainloop
    bool done = false;
    while (!done) {

        // poll events
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) done = true;
            if (event.type == SDL_KEYDOWN) done = true;
            if (event.type == SDL_FINGERDOWN) done = true;
        }
    }

    // clean up
    SDL_DestroyTexture(image);
    Mix_FreeMusic(music);
    Mix_CloseAudio();
    TTF_Quit();
    IMG_Quit();
    SDL_Quit();

    // quit program 
    return 0;
}
