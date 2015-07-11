// $Id: hello.c,v 1.5 2013-09-25 14:19:56-07 - - $

//
// NAME
//    hello - the canonical hello world program
//
// SYNOPSIS
//    hello
//
// DESCRIPTION
//    Prints the message "Hello, world!"
//

#include <libgen.h>
#include <stdio.h>
#include <stdlib.h>

int main (int argc, char **argv) {
   if (argc != 1) {
      fprintf (stderr, "Usage: %s\n", basename (argv[0]));
      exit (EXIT_FAILURE);
   }
   printf ("Hello, World!\n");
   return EXIT_SUCCESS;
}

/*
//TEST// ./hello >hello.out1 2>hello.err1; echo status = $? >hello.exit1
//TEST// morecat hello.out1 hello.err1 hello.exit1 >hello.lis1
//TEST// rm hello.out1 hello.err1 hello.exit1
//TEST// ./hello goodbye >hello.out2 2>hello.err2; \
//TEST//       echo status = $? >hello.exit2
//TEST// morecat hello.out2 hello.err2 hello.exit2 >hello.lis2
//TEST// rm hello.out2 hello.err2 hello.exit2
//TEST// mkpspdf hello.ps hello.c* hello*.lis*
*/

