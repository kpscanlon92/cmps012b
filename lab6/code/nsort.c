// Name: Kelly Scanlon
// User: kpscanlo

// $Id: nsort.c,v 1.1 2011-04-29 19:46:42-07 - - $


#include <stdio.h>
#include <libgen.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <assert.h>
#include <stdbool.h>

// 
// Declaration for a linked list of nodes.
//
typedef struct node node;
struct node {
   double item;
   node *link;
};


int EXIT_STATUS = EXIT_SUCCESS;
node *head = NULL;


//
// Insert node into linked list.
//
void insertascending (double newitem) {
   node *prev = NULL;
   node *curr = head;

   // Find the insertion position.
   while (curr != NULL) {
      if ((curr->item - newitem) > 0) break;
         prev = curr;
         curr = curr->link;
   };

   // Do the insertion.
   node *tmp = malloc (sizeof (struct node));
   assert (tmp != NULL);
   tmp->item = newitem;
   tmp->link = curr;
   if (prev == NULL) head = tmp;
   else prev->link = tmp;
}


int main (int argc, char **argv) {
   char *progname = basename (argv[0]);
   
   int opt = 0;
   bool debug = false;
   while ((opt = getopt(argc, argv, "d")) != -1) {
      if (opt == 'd') debug = true;
      else debug = false;
   };


   char err_buffer [256];
   char err_buf_fmt[16];
   sprintf (err_buf_fmt, "%%%lds", sizeof err_buffer - 1);

   for(;;) {
      
      double number;
      int scancount = scanf ("%lg", &number);

      if (scancount == EOF) break;
      else if (scancount == 1) {
         insertascending (number);
      } else {
         scancount = scanf (err_buf_fmt, err_buffer);
         assert (scancount == 1);
         fprintf (stderr, "%s: bad number \"%s\"\n", progname, err_buffer);
         EXIT_STATUS = EXIT_FAILURE;
      }
      
   };
   

   while (head != NULL) {
      node *old = head;
      head = head->link;
      if(!debug)
         printf ("%24.15g\n", old->item);
      else
         printf ("%s: %p-> node {\n"
                 "    number= %lg\n"
                 "    link= %p}\n",
                 progname, old, old->item, old->link);
      free (old);
   };

   return EXIT_STATUS;
}

