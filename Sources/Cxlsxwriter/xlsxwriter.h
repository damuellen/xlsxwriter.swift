#ifdef _WIN32
#include "C:/vcpkg/installed/x64-windows/include/xlsxwriter.h"
#elif __APPLE__
#include "/opt/homebrew/include/xlsxwriter.h"
#elif __linux__
#include "/usr/local/include/xlsxwriter.h"
#endif
