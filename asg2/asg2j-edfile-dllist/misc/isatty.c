// $Id: isatty.c,v 1.2 2013-04-29 12:53:52-07 - - $

#include <libgen.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define CHECK(STD) check (#STD, STD)

void check (char *stdname, int fileno) {
   printf ("%s (%d) is%s a tty.\n",
           stdname, fileno, isatty (fileno) ? "" : " not");
}

int main (int argc, char **argv) {
   CHECK (STDIN_FILENO);
   CHECK (STDOUT_FILENO);
   CHECK (STDERR_FILENO);
   return EXIT_SUCCESS;
}
