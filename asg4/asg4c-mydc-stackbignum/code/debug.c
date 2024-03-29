// Name: Kelly Scanlon
// User: kpscanlo

// $Id: debug.c,v 1.4 2014-05-25 21:01:27-07 - - $

#include <assert.h>
#include <limits.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "debug.h"

static char debug_flags[UCHAR_MAX + 1];
char *program_name = NULL;
int exit_status = EXIT_SUCCESS;

void set_debug_flags (char *flags) {
   if (strchr (flags, '@') != NULL) {
      memset (debug_flags, true, sizeof debug_flags);
   }else {
      for (char *flag = flags; *flag != '\0'; ++flag) {
         debug_flags[(unsigned char) *flag] = true;
      }
   }
}

bool get_debug_flag (char flag) {
   return debug_flags[(unsigned char) flag];
}

void __show_debug (char flag, char *file, int line, const char *func) {
   fflush (NULL);
   assert (program_name != NULL);
   fprintf (stderr, "%s: DEBUGF(%c): %s[%d]: %s()\n",
            program_name, flag, file, line, func);
}

