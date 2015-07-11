// Name: Kelly Scanlon
// User: kpscanlo

// $Id: lsort.c,v 1.1 2011-04-29 19:46:42-07 - - $


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
   char *string;
   node *link;
};


int EXIT_STATUS = EXIT_SUCCESS;
node *head = NULL;


//
// Insert node into linked list.
//
void insertascending (char *newitem) {
   node *prev = NULL;
   node *curr = head;

   // Find the insertion position.
   while (curr != NULL) {
      if (strcmp(curr->string, newitem) > 0) break;
         prev = curr;
         curr = curr->link;
   };

   // Do the insertion.
   node *tmp = malloc (sizeof (struct node));
   assert (tmp != NULL);
   tmp->string = newitem;
   assert (tmp->string != NULL);
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

   char buffer[82];
   for(;;) {
      char *gotline = fgets (buffer, sizeof buffer, stdin);
      if (gotline == NULL) break;

      char *nlpos = strchr (buffer, '\n');
      if (nlpos != NULL) {
         *nlpos = '\0';
      } else {
         fprintf(stderr, "%s: unterminated line: %s\n",
                 progname, buffer);
         EXIT_STATUS = EXIT_FAILURE;
      };
      
      insertascending (strdup(buffer));

   };
   

   while (head != NULL) {
      node *old = head;
      head = head->link;
      if(!debug)
         printf ("%s\n", old->string);
      else
         printf ("%s: %p-> node {\n"
                 "    string= %p->\"%s\",\n"
                 "    link= %p}\n",
                 progname, old, old->string, old->string, old->link);
      free (old->string);
      free (old);
   };

   return EXIT_STATUS;
}

