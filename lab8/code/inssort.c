// Name: Kelly Scanlon
// User: kpscanlo


#include <stdio.h>
#include <stdlib.h>
#include <libgen.h>
#include <string.h>
#include "inssort.h"

void inssort (void *base, size_t nmemb, size_t size, 
               int (*compar) (const void *, const void *)) {
   for (size_t sorted = 1; sorted < nmemb; sorted++) {
      int slot = sorted;
      void *copy = malloc (size);
      memcpy (copy, (char *) (base + slot*size), size);
      for (; slot > 0; slot--) {
         void *prev = base + ((slot-1) *size);
         int cmp = (*compar) (copy, prev);
         if (cmp > 0) break;
         memcpy ((base + slot*size), prev, size);
      }
      memcpy ((base + slot*size), copy, size);
      free (copy);
   }
}

