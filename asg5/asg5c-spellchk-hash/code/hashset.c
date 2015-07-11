// Name: Kelly Scanlon
// User: kpscanlo

// $Id: hashset.c,v 1.9 2014-05-15 20:01:08-07 - - $

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "debug.h"
#include "hashset.h"
#include "strhash.h"

#define HASH_NEW_SIZE 15

typedef struct hashnode hashnode;
struct hashnode {
   char *word;
   hashnode *link;
};

struct hashset {
   size_t size;
   size_t load;
   hashnode **chains;
};

hashset *new_hashset (void) {
   hashset *this = malloc (sizeof (struct hashset));
   assert (this != NULL);
   this->size = HASH_NEW_SIZE;
   this->load = 0;
   size_t sizeof_chains = this->size * sizeof (hashnode *);
   this->chains = malloc (sizeof_chains);
   assert (this->chains != NULL);
   memset (this->chains, 0, sizeof_chains);
   DEBUGF ('h', "%p -> struct hashset {size = %zd, chains=%p}\n",
                this, this->size, this->chains);
   return this;
}

void free_hashset (hashset *this) {
   DEBUGF ('h', "free (%p)\n", this);
   for (int i = 0; i < (int)this->size; i++) {
      hashnode* curr = this->chains[i];
      while (curr != NULL) {
         hashnode* next = curr->link;
         if (curr->word != NULL) free (curr->word);
         free (curr);
         curr = next;
      }
   }
   free (this->chains);
   free(this);
}

void free_oldlist (hashset *this, size_t size) {
   DEBUGF ('h', "free (%p)\n", this);
   for (int i = 0; i < (int) size; i++) {
      hashnode* curr = this->chains[i];
      while (curr != NULL) {
         hashnode* next = curr->link;
         if (curr->word != NULL) free (curr->word);
         free (curr);
         curr = next;
      }
   }
   free (this->chains);
}

void double_hash (hashset *this) {
   size_t old_size = this->size;
   this->size *=2;
   this->size +=1;; 
   size_t sizeof_list = this->size;
   hashnode** newlist = calloc (sizeof_list, sizeof(hashnode *));
   assert (newlist != NULL);

   for (int i = 0; i < (int)old_size; i++) {
      hashnode *curr = this->chains[i];
      while (curr != NULL) {
         char *word = curr->word;
         size_t hash_index = strhash (word) % this->size;
         hashnode *new = malloc (sizeof (struct hashnode));
         new->word = strdup(word);
         new->link = newlist[hash_index];
         newlist[hash_index] = new;
         curr = curr->link;
      }
   }
   free_oldlist (this, old_size);
   this->chains = newlist;
}

void put_hashset (hashset *this, const char *item) {
   if ((this->load*2) > this->size) double_hash (this);
   size_t hash_index = strhash(item) % this->size;
   hashnode *node = this->chains[hash_index];
   while (node != NULL) {
      if (strcmp (item, node->word) == 0) return;
      node = node->link;
   }
   hashnode *new = malloc (sizeof (struct hashnode));
   new->word = strdup(item);
   new->link = this->chains[hash_index];
   this->chains[hash_index] = new;
   this->load++;
}

bool has_hashset (hashset *this, const char *item) {
   if (item == NULL) return false;
   size_t hash_index = strhash (item) % this->size;
   
   
   hashnode *curr = this->chains[hash_index];
   while (curr != NULL) {
      if (strcmp (curr->word, item) == 0) return true;
      curr = curr->link;
   }
   
   return false;
}

void debug_stats (hashset *this) {
   int *chain_length = calloc (this->load, sizeof(int));
   for (int i = 0; i < (int) this->size; i++) {
      int chain_size = 0;
      hashnode* curr = this->chains[i];
      while (curr != NULL) {
         curr = curr->link;
         chain_size++;
      }
      chain_length[chain_size]++;
   }
   for (int i = 0; i < (int)this->load; i++) {
      if (chain_length[i] == 0) continue;
      printf("%7d chains of size %d.\n", chain_length[i], i);
   }
}

void hash_dump (hashset *this) {
   for (int i = 0; i < (int)this->size; i++) {
      hashnode* curr = this->chains[i];
      while (curr != NULL) {
         printf ("array[%10d] = %zd \"%s\"\n",
                  i, strhash(curr->word), curr->word);
         curr = curr->link;
      }
   }
}

