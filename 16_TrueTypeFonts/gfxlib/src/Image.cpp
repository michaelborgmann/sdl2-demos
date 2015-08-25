#include "Image.h"

Image::Image(std::string filename, SDL_Renderer* renderer)
: renderer(renderer) { //, texture(NULL) {
    loadImage(filename);
}

void Image::loadImage(std::string filename) {
    std::shared_ptr<SDL_Surface> bitmap(SDL_LoadBMP(filename.c_str()),
                                        SDL_FreeSurface);
    if (!bitmap) { throw Error(SDL_GetError()); }

    texture = std::shared_ptr<SDL_Texture> (SDL_CreateTextureFromSurface(renderer, bitmap.get()),
                                            SDL_DestroyTexture);
    if (!texture) { throw Error(SDL_GetError()); }

}


void Image::draw() {
    if (texture) SDL_RenderCopy(renderer, texture.get(), NULL, NULL);
}
