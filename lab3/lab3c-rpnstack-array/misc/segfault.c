// $Id: segfault.c,v 1.11 2013-09-25 14:47:21-07 - - $

// Illustrate a segfault.

#include <stdio.h>

int main (int argc, char **argv) {
   for (int i = 0;; ++i) {
      printf ("argv[%d]=\"%s\"\n", i, argv[i]);
      fflush (NULL);
   }
}

/*
//TEST// env -i FOO=value1 BAR=value2 \
//TEST// PATH=/bin:/afs/cats.ucsc.edu/courses/cmps012b-wm/bin \
//TEST// runprog -x segfault.lis ./segfault
//TEST// mkpspdf segfault.ps segfault.c* segfault.lis
*/

