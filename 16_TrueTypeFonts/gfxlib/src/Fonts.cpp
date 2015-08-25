#include "Fonts.h"

Fonts::Fonts(SDL_Renderer* renderer, std::string filename, int size)
: renderer(renderer) {
    if (TTF_Init() != 0) { throw Error(TTF_GetError()); }
    loadFont(filename, size);
}

Fonts::~Fonts() {
    free();
}

void Fonts::free() {
    if (font) TTF_CloseFont(font);
    TTF_Quit();
}

void Fonts::loadFont(std::string filename, int size) {
    font = TTF_OpenFont(filename.c_str(), size);
    if (!font) { throw Error(TTF_GetError()); }
}


void Fonts::print(int x, int y, std::string text, Uint8 r, Uint8 g, Uint8 b) {
    SDL_Color color = {r, g, b};
    std::shared_ptr<SDL_Surface> bitmap(TTF_RenderText_Solid(font, text.c_str(), color),
                                             SDL_FreeSurface);
    std::shared_ptr<SDL_Texture> texture(SDL_CreateTextureFromSurface(renderer, bitmap.get()),
                                              SDL_DestroyTexture);
    SDL_Rect paste = {x,y, bitmap->w, bitmap->h};
    SDL_RenderCopy(renderer, texture.get(), NULL, &paste);
}
