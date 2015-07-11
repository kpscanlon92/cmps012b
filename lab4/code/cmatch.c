// $Id&
//
// Name: Kelly Scanlon
// User: kpscanlo
//
// NAME
//    cmatch - print matching lines from files
// 
// SYNOPSIS
//    cmatch [-iln] string [filename...]
// 
// DESCRIPTION
//    cmatch searches the named input files for lines containing the 
//    string. By default the matching lines are printed. If more than
//    one file is specified, lines of output are preceded by the 
//    filename.
// 

#define _GNU_SOURCE

#include <errno.h>
#include <libgen.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

char *program_name = NULL;
char *string = NULL;
int exit_status = EXIT_SUCCESS;
#define STDIN_NAME "-"

typedef struct options {
   bool ignore_case;
   bool filenames_only;
   bool number_lines;
} options;


void catbyline (FILE *input, char *filename, options *opts, 
                bool one_file, char *string) {
   char buffer[1024];
   for (int linenr = 1;; ++linenr) {
      char *buf = fgets (buffer, sizeof buffer, input);
      if (buf == NULL) break;
      char *ptr;
      if (opts->ignore_case) {
         ptr = strcasestr (buf, string);
      } else {
         ptr = strstr (buf, string);
      } 
      if (ptr != NULL) {
         if (opts->filenames_only) {
            printf("%s\n", filename);
            break;
         } else if (opts->number_lines) {
            if (one_file) 
               printf("%6d: %s", linenr, buf);
            else
               printf("%s: %6d: %s", filename, linenr, buf);
         } else {
            if (one_file)
               printf("%s", buf);
            else
               printf("%s: %s", filename, buf);
         }
      }
   }
}


int scan_options (int argc, char **argv, options *opts) {
   int opt_found = 0;
   opts->ignore_case = false;
   opts->filenames_only = false;
   opts->number_lines = false;
   opterr = false;
   for (;;) {
      int opt = getopt (argc, argv, "iln");
      if (opt == EOF) break;
      switch (opt) {
         case 'i':
            opts->ignore_case = true;
            opt_found = 1;
            break;
         case 'l':
            opts->filenames_only = true;
            opt_found = 1;
            break;
         case 'n':
            opts->number_lines = true;
            opt_found = 1;
            break;
         default:
            exit_status = EXIT_FAILURE;
            fflush (NULL);
            fprintf(stderr, "%s: -%c: invalid option\n",
                           program_name, optopt);
            break;
      }
   }
   return opt_found;
}


const char *strbool (bool value) {
   return value ? "true" : "false";
}

int main (int argc, char **argv) {
   options opts;
   program_name = basename (argv[0]);
   int opt_found = scan_options (argc, argv, &opts);
   string = basename (argv[1 + opt_found]);
   bool one_file = false;
   if (argc <= (3 + opt_found))
      one_file = true;
   if (argc == (2 + opt_found)) {
      catbyline (stdin, STDIN_NAME, &opts, one_file, string);
   } else {
      for (int argi = 2 + opt_found; argi < argc; ++argi) {
         char *filename = argv[argi];
         if (strcmp (filename, STDIN_NAME) == 0) {
            catbyline (stdin, STDIN_NAME, &opts, one_file, string);
         } else {
            FILE *input = fopen (filename, "r");
            if (input != NULL) {
               catbyline (input, filename, &opts, one_file, string);
               fclose (input);
            } else {
               exit_status = EXIT_FAILURE;
               fflush (NULL);
               fprintf (stderr, "%s: %s: %s\n", program_name,
                       filename, strerror (errno));
               fflush (NULL);
            }
         }
      }
   }
   return exit_status;
}

