#ifndef ERROR_H
#define ERROR_H

#include <exception>
#include <string>
#include "SDL2/SDL.h"

class Error: public std::exception {
    std::string message;
public:
    Error(const std::string&);
    virtual ~Error() throw();
    virtual const char* what() const throw();
};

#endif // ERROR_H
