// Name: Kelly Scanlon
// User: kpscanlo

#include <stdio.h>
#include <stdlib.h>
#include <libgen.h>
#include <math.h>
#include "inssort.h"

int cmpdouble (const void *p1, const void *p2) {
   /*if(((const double *) p1) < ((const double *) p2)) 
      return -1;
   else if(((const double *) p1) > ((const double *) p2)) 
      return 1;
   else
      return 0;*/
   double *this = (double *) p1;
   double *that = (double *) p2;
   return *this < *that ? -1: *this > *that ? 1: 0;
}


int main (int argc, char **argv) {
   (void) argv;
   (void) argc;
   int exit_status = EXIT_SUCCESS;
   double array[1000];

   int count = 0;
   for (;;count++) {
      if (count == 1000) {
         break;
      }
      double num;
      int rc = scanf("%lg", &num);
      if (rc == EOF) {
         break;
      }
      if (rc != 0) {
         //printf("Valid Input, %20.15g\n",num);
         array[count] = num;
      } else {
         //printf("Invalid Input, call inssort\n");
         exit_status = EXIT_FAILURE;
         break;
      }
   }

   inssort(array, count, sizeof (double), cmpdouble);
   for (int i = 0; i < count; i++) {
      printf ("%20.15g\n", array[i]);
   }
   return exit_status;
}

