#ifndef _FONTS_H_
#define _FONTS_H_

#include <iostream>
#include <memory>
#include <SDL2/SDL.h>
#include <SDL2/SDL_ttf.h>
#include "Error.h"

class Fonts {
    SDL_Renderer* renderer;
    TTF_Font* font;

    Fonts(const Fonts&);
    Fonts& operator=(const Fonts&);

    void loadFont(std::string filename, int size);

public:
    Fonts(SDL_Renderer* renderer, std::string filename, int size = 24);
    ~Fonts();
    void free();
    void print(int x, int y, std::string text, Uint8 r = 0xff, Uint8 g = 0xff, Uint8 b =0xff);
};

#endif // _FONTS_H_
