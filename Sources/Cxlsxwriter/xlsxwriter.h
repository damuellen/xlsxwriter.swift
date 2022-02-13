#ifdef _WIN32
#include "C:/vcpkg/installed/x64-windows/include/xlsxwriter.h"
#elif defined(__APPLE__) && defined(__aarch64__)
#include "/opt/homebrew/include/xlsxwriter.h"
#else
#include "/usr/local/include/xlsxwriter.h"
#endif
