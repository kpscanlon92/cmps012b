// $Id: double.c,v 1.24 2013-09-25 14:25:32-07 - - $

//
// NAME
//    double - print out information about double numbers
//

#include <libgen.h>
#include <locale.h>
#include <stdio.h>
#include <values.h>

int main (int argc, char **argv) {
   (void) argc; // avoid: warning: unused parameter 'argc'
   char *locale = setlocale (LC_NUMERIC, "en_US");
   if (locale == NULL) {
      fprintf (stderr, "%s: %s: %s\n", basename (argv[0]),
               "setlocale (LC_NUMERIC, \"en_US\")", "failed\n");
   }else {
      printf ("Locale set to %s\n", locale);
   }
   printf ("DBL_DIG = %d\n", DBL_DIG);
   printf ("DBL_EPSILON = %.15g\n", DBL_EPSILON);
   printf ("DBL_MANT_DIG = %d\n", DBL_MANT_DIG);
   printf ("DBL_MAX_10_EXP = %d\n", DBL_MAX_10_EXP);
   printf ("DBL_MAX = %.15g\n", DBL_MAX);
   double dollars = 1.00;
   while (dollars + 0.01 > dollars) dollars *= 2;
   printf ("dollars = $%'22.2f = $%g\n", dollars, dollars);
   printf ("US debt = $%'22.2f (Feb. 2013)\n", 16687289180215.00);
   printf ("diameter of the universe = %g meters\n", 8.8e26);
   return 0;
}

//TEST// ./double >double.lis 2>&1
//TEST// mkpspdf double.ps double.c* double.lis*

