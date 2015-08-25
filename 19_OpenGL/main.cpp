#ifdef __APPLE__
    #include <TargetConditionals.h>
#endif

#include <iostream>
#include <string>
#include <fstream>

#if _WIN32 || __ANDROID__ || TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
    #include <GL/gl.h>
    #include <SDL_image.h>
    #include <SDL_ttf.h>
    #include <SDL_mixer.h>
#elif __linux__ || __CYGWIN__
#include <GL/gl.h>
    #include <SDL2/SDL.h>
    #include <SDL2/SDL_opengl.h>
    #include <SDL2/SDL_image.h>
    #include <SDL2/SDL_opengl.h>
    #include <SDL2/SDL_ttf.h>
    #include <SDL2/SDL_mixer.h>
#elif TARGET_OS_MAC
    #include <OpenGL/gl.h>
    #include <SDL2/SDL.h>
    #include <SDL2_image/SDL_image.h>
    #include <SDL2_ttf/SDL_ttf.h>
    #include <SDL2_mixer/SDL_mixer.h>
#endif

SDL_Window* window;
SDL_Renderer* renderer;
SDL_Event event;
SDL_GLContext context;
SDL_Surface *bitmap;
SDL_Texture *texture;
TTF_Font *font;
Uint32 frame, lastframe;
GLuint program_object;

GLfloat color(int color);
void initialize();
void initGL();
GLuint LoadShader(GLenum type, std::string filename);
void shutdown();
void mainloop();
void print(int x, int y, std::string text, Uint8 r, Uint8 g, Uint8 b);
void triangle();
void scene();

int main (int argc, char *argv[]) {

    initialize();
    initGL();
    mainloop();
    shutdown();
    return 0;
}

GLfloat color(int color) {
    return static_cast<GLfloat>(1) / 255 * color;
}

char* readfile(std::string filename) {
}

void initialize() {
    SDL_Init(SDL_INIT_VIDEO);
    TTF_Init();
    int i;
    if (!(SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3))) {
        std::cout << "attribute not set: " << SDL_GetError() << '\n';
    }

    window = SDL_CreateWindow("Demo",
                               0, 0,
                               640, 480,
                               SDL_WINDOW_OPENGL | SDL_WINDOW_RESIZABLE); 
    context = SDL_GL_CreateContext(window);
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);

    SDL_GL_SetSwapInterval(1);

    std::cout << "OpenGL Version : " << glGetString(GL_VERSION) << '\n';
    std::cout << "OpenGL Vendor  : " << glGetString(GL_VENDOR) << '\n';
    std::cout << "OpenGL Renderer: " << glGetString(GL_RENDERER) << '\n';
    std::cout << "GLSL Version   : " << glGetString(GL_SHADING_LANGUAGE_VERSION) << '\n';

    font = TTF_OpenFont("C-64.ttf", 24);
    if (!font) {
        std::cout << "Couldn't load font: " << TTF_GetError() << '\n';
        exit(1);
    }


}

void initGL() {
    GLuint vertex_shader = LoadShader(GL_VERTEX_SHADER, "vertexshader.vert");
    GLuint fragment_shader = LoadShader(GL_FRAGMENT_SHADER, "fragmentshader.frag");

    program_object = glCreateProgram();
    if (program_object == 0) {
        std::cout << "Couldn't create program_object\n";
        exit(1);
    }

    glAttachShader(program_object, vertex_shader);
    glAttachShader(program_object, fragment_shader);

    // this replace layout(location = 0) in vec4 vPosition in the vertexshader.vert
    glBindAttribLocation(program_object, 0, "in_Position");

    glLinkProgram(program_object);

    GLint linked;
    glGetProgramiv(program_object, GL_LINK_STATUS, &linked);
    if (!linked) {
        GLint length = 0;
        glGetProgramiv(program_object, GL_INFO_LOG_LENGTH, &length);
        if (length > 1) {
            char *log = (char*)(malloc(sizeof(char) * length));
            glGetProgramInfoLog(program_object, length, NULL, log);
            std::cout << "Error linking program: " << log << '\n';
            free(log);
        }
        glDeleteProgram(program_object);
        exit(1);
    }
    glUseProgram(program_object);
    glClearColor(color(0), color(50), color(70), color(255));
}

GLuint LoadShader(GLenum type, std::string filename) {

    std::ifstream file; 
    char *shader_source;
    file.open(filename);
    if (file.is_open()) {
        
        file.seekg(0, file.end);
        int length = file.tellg();
        file.seekg(0, file.beg);

        shader_source = new char[length];

        file.read(shader_source, length);

        if (!file) {
            std::cout << "error: read only " << file.gcount() << " bytes";
            exit(1);
        }
        file.close();
    }

    GLuint shader = glCreateShader(type);
    if (shader == 0) {
        std::cout << "Couldn't load shader!\n";
        exit(1);
    }

    glShaderSource(shader, 1, &shader_source, NULL);
    glCompileShader(shader);
    GLint compiled;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &compiled);

    if (!compiled) {
        GLint length = 0;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &length);
        if (length > 1) {
            char *log = (char*)(malloc(sizeof(char) * length));
            glGetShaderInfoLog(shader, length, NULL, log);
            std::cout << "Error compiling shader: " << log << '\n';
            free(log);
        }
        glDeleteShader(shader);
        exit(1);
    }
    return shader;
};

void shutdown() {
    SDL_DestroyTexture(texture);
    SDL_GL_DeleteContext(context);
    TTF_Quit();
    SDL_Quit();
}

void mainloop() {
    lastframe = SDL_GetTicks();
    int counter = 0;
    std::string fps = std::to_string(counter++);
    bool done = false;
    while (!done) {
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) done = true;
            if (event.type == SDL_KEYDOWN) done = true;
            if (event.type == SDL_FINGERDOWN) done = true;
        }
        counter++;
        scene();

        Uint32 time = SDL_GetTicks();
        if (time - lastframe > 1000) {
            lastframe = time;
            fps = std::to_string(counter);
            std::cout << "FPS: " << counter << '\n';
            counter = 0;
        }
        print(580, 10, fps, 0xff, 0xff, 0xff);
        print(480, 10, "FPS:", 0xff, 0xff, 0xff);
        SDL_GL_SwapWindow(window);
    }
}

void print(int x, int y, std::string text, Uint8 r, Uint8 g, Uint8 b) {
    SDL_Color color = {r, g, b};
    bitmap = TTF_RenderText_Solid(font, text.c_str(), color);
    texture = SDL_CreateTextureFromSurface(renderer, bitmap);
    SDL_Rect position = {x, y, bitmap->w, bitmap->h};
    SDL_FreeSurface(bitmap);
    SDL_RenderCopy(renderer, texture, NULL, &position);
}

void scene() {
    glClear(GL_COLOR_BUFFER_BIT);
    triangle();
    print(10, 10, "OpenGL Demo", 0xff, 0xff, 0xff);
}

void triangle() {
    GLfloat vertices[] = { 0.0f, 0.5f, 0.0f,
                          -0.5f,-0.5f, 0.0f,
                           0.5f,-0.5f, 0.0f};
    glUseProgram(program_object);
    glVertexAttribPointer(0,3, GL_FLOAT, GL_FALSE, 0, vertices);
    glEnableVertexAttribArray(0);
    glDrawArrays(GL_TRIANGLES, 0, 3);       
}
