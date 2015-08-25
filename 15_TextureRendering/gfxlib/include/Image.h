#ifndef _IMAGE_H_
#define _IMAGE_H_

#include <iostream>
//#include <boost/shared_ptr.hpp>
//#include <tr1/memory>
#include <memory>
#include <SDL2/SDL.h>
#include "Error.h"

class Image {
//    std::tr1::shared_ptr<SDL_Texture> texture;
    std::shared_ptr<SDL_Texture> texture;
    SDL_Renderer* renderer;

    Image(const Image&);
    Image& operator=(const Image&);

    void loadImage(std::string filename);

public:
    Image(std::string filename, SDL_Renderer* renderer);
    void free();
    void draw();
};


void DestroyTexture(SDL_Texture*);

#endif // _IMAGE_H_
