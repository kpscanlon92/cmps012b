// Name: Kelly Scanlon
// User: kpscanlo

#include <stdio.h>
#include <stdlib.h>
#include <libgen.h>
#include <math.h>
#include <string.h>
#include "inssort.h"

int cmpstr (const void *p1, const void *p2) {
   return strcmp (*(const char**) p1, *(const char**) p2);
}


int main (int argc, char **argv) {
   (void) argv;
   (void) argc;
   char line[4096];
   char **array;
   array = (char**) malloc(sizeof(char *) * 1000);

   int count = 0;
   while (fgets(line, 4096, stdin) != NULL) {
      if (feof(stdin)) {
         break;
      }
      array[count] = strdup (line);
      count++;
      if (count == 1000) {
         break;
      }
   }


   inssort(&array[0], count, sizeof (char *), cmpstr);
   for (int i = 0; i < count; i++) {
      printf ("%s", array[i]);
      free (array[i]);
   }
   free(array);
   return EXIT_SUCCESS;
}

