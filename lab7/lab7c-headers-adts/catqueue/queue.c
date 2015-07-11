// Name: Kelly Scanlon
// User: kpscanlo

// $Id: queue.c,v 1.16 2014-05-18 18:52:26-07 - - $

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "queue.h"

#define STUBPRINTF(...) fprintf (stderr, __VA_ARGS__);

typedef struct queue_node queue_node;
struct queue_node {
   queue_item_t item;
   queue_node *link;
};

struct queue {
   queue_node *front;
   queue_node *rear;
};

queue *new_queue (void) {
   queue *new = malloc (sizeof(struct queue));
   assert (new != NULL);
   new->front = NULL;
   new->rear = NULL;
   return new;
}

void free_queue (queue *this) {
   assert (isempty_queue (this));
   free (this);
}

void insert_queue (queue *this, queue_item_t item) {
   queue_node *new = malloc (sizeof(struct queue_node));
   assert (new != NULL);
   new->item = item;
   new->link = NULL;
   if (this->front == NULL) {
      this->front = new;
   } else {
      this->rear->link = new;
   }
   this->rear = new;
}

queue_item_t remove_queue (queue *this) {
   assert (!isempty_queue (this));
   queue_item_t tmp_item = this->front->item;
   queue_node *tmp_node = this->front;
   this->front = this->front->link;
   free(tmp_node);
   return tmp_item;
}

bool isempty_queue (queue *this) {
   return this->front == NULL;
}

