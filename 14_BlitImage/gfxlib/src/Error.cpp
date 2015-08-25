#include "Error.h"

Error::Error(const std::string& msg) : exception(), message(msg) {}
Error::~Error() throw() {}
const char* Error::what() const throw() { return message.c_str(); }
