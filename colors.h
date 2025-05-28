#ifndef _COLOR_H_
#define _COLOR_H_

#define RESET "\033[0m"
#define BOLD "\033[1m"
#define FAINT "\033[2m"
#define ITALIC "\033[3m"
#define UNDERLINE "\033[4m"
#define BLINK "\033[5m"

#define BLACK "\033[30m"
#define RED "\033[31m"
#define GREEN "\033[32m"
#define YELLOW "\033[33m"
#define BLUE "\033[34m"
#define MAGENTA "\033[35m"
#define CYAN "\033[36m"
#define WHITE "\033[37m"

// Versions "intenses" ou claires
#define BBLACK "\033[90m"
#define BRED "\033[91m"
#define BGREEN "\033[92m"
#define BYELLOW "\033[93m"
#define BBLUE "\033[94m"
#define BMAGENTA "\033[95m"
#define BCYAN "\033[96m"
#define BWHITE "\033[97m"

// Leveling for logs
#define CINFO "\033[32m"    // Vert
#define CWARNING "\033[33m" // Jaune
#define CERROR "\033[31m"   // Rouge
#define CFATAL "\033[1;31m" // Rouge gras (ou plus intense)

#endif