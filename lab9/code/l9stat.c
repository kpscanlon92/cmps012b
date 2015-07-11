// Name: Kelly Scanlon
// User: kpscanlo

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <libgen.h>
#include <limits.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <sys/stat.h>

char *progname;
int exit_status;

void print_stat (struct stat *sb) {

   printf("%6o %9d ", sb->st_mode, (int)sb->st_size);

   time_t now = time (NULL);
   struct tm tm_now;
   localtime_r (&now, &tm_now);
   char buffer[64];

   if (sb->st_mtime < (now - 60*60*24*180)) {
      strftime (buffer, sizeof buffer, "%b %e %Y ", &tm_now);
   } else { 
      strftime (buffer, sizeof buffer, "%b %e %R ", &tm_now);
   }

   printf("%s", buffer);
}

void print_link (ssize_t retval, char *pathname, char *linkname) {
   linkname[retval < PATH_MAX + 1 ? retval : PATH_MAX] = '\0';
   printf ("%s -> \"%s\"\n", pathname, linkname);
}

void file (char *filename) {

   char linkname[PATH_MAX + 1];
   ssize_t retval = readlink (filename, linkname, sizeof linkname);
   struct stat sb;

   int retval2 = lstat (filename, &sb);

   if (retval2 != -1) {
      print_stat (&sb);
      if (retval >= 0) 
         print_link (retval, filename, linkname);
      else
         printf ("%s\n", filename);
   } else {
      exit_status = EXIT_FAILURE;
      fflush (NULL);
      fprintf (stderr, "%s: %s: %s\n", 
               progname, filename, strerror (errno));
      fflush (NULL);
   }
}

int main (int argc, char **argv) {
  progname = basename (argv[0]);
  exit_status = EXIT_SUCCESS; 

   if (argc == 1) {
      file(".");
   } else {
      for (int i = 1; i < argc; i++) {
         file (argv[i]);   
      }
   }

   return exit_status;
}
