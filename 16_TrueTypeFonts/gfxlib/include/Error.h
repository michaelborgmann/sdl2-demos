#ifndef _ERROR_H_
#define _ERROR_H_

#include <exception>
#include <string>

class Error: public std::exception {
    std::string message;
public:
    Error(const std::string&);
    virtual ~Error() throw();
    virtual const char* what() const throw();
};

#endif // _ERROR_H_
