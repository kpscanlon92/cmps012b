// Name: Kelly Scanlon
// User: kpscanlo

// $Id: strhash.c,v 1.6 2014-03-05 19:24:07-08 - - $

#include <assert.h>
#include <stdio.h>
#include <sys/types.h>
#include <string.h>
#include <stdlib.h>

#include "strhash.h"

size_t strhash (const char *string) {
   assert (string != NULL);
   size_t hash = 0;
   char * new_string = strdup(string);
   for (; *new_string != '\0'; ++*new_string) {
      hash = *new_string + (hash << 6) + (hash << 16) - hash;
   }
   free (new_string);
   return hash;
}

