// Name: Kelly Scanlon
// User: kpscanlo

// $Id: bigint.c,v 1.14 2014-05-25 21:01:27-07 - - $

#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "bigint.h"
#include "debug.h"

#define MIN_CAPACITY 16

struct bigint {
   size_t capacity;
   size_t size;
   bool negative;
   char *digits;
};

static void trim_zeros (bigint *this) {
   while (this->size > 0) {
      size_t digitpos = this->size - 1;
      if (this->digits[digitpos] != 0) break;
      --this->size;
   }
}

bigint *new_bigint (size_t capacity) {
   bigint *this = malloc (sizeof (bigint));
   assert (this != NULL);
   this->capacity = capacity;
   this->size = 0;
   this->negative = false;
   this->digits = calloc (this->capacity, sizeof (char));
   assert (this->digits != NULL);
   DEBUGS ('b', show_bigint (this));
   return this;
}


bigint *new_string_bigint (char *string) {
   assert (string != NULL);
   size_t length = strlen (string);
   bigint *this = new_bigint (length > MIN_CAPACITY
                            ? length : MIN_CAPACITY);
   char *strdigit = &string[length - 1];
   if (*string == '_') {
      this->negative = true;
      ++string;
      --length;
   }
   char *thisdigit = this->digits;
   while (strdigit >= string) {
      assert ('0' <= *strdigit && *strdigit <= '9');
      *thisdigit++ = *strdigit-- - '0';
   }
   this->size = thisdigit - this->digits;
   trim_zeros (this);
   DEBUGS ('b', show_bigint (this));
   return this;
}

static bigint *do_add (bigint *this, bigint *that) {
   DEBUGS ('b', show_bigint (this));
   DEBUGS ('b', show_bigint (that));
   
   size_t larger_size = (this->size > that->size ? this->size+1 
                                                : that->size+1);
   bigint *result = new_bigint (larger_size);

   int carry = 0;
   int digit = 0;
   for (size_t i = 0; i < result->capacity; i++, result->size++) {
      if (that->size <= i && this->size <= i) {
         result->digits[i] = carry;
         break;
      } else if (this->size <= i) {
         result->digits[i] = that->digits[i];
      } else if (that->size <= i) {
         result->digits[i] = this->digits[i];
      } else {
         digit = this->digits[i] + that->digits[i] + carry;
         result->digits[i] = digit % 10;
         carry = digit / 10;
      }
   }

   trim_zeros (result);
   return result;
}

static bigint *do_sub (bigint *this, bigint *that) {
   DEBUGS ('b', show_bigint (this));
   DEBUGS ('b', show_bigint (that));
   
//   size_t larger_size = (this->size > that->size 
//                         ? this->size : that->size);
   size_t smaller_size = (this->size < that->size 
                         ? this->size : that->size);
   bool greater = false;
   for (size_t i = 0; i <= smaller_size; i++) {
      size_t index = smaller_size - 1 - i;
      if (this->digits[index] > that->digits[index]) {
         greater = true;
         break;
      } else if (this->digits[index] < that->digits[index]) {
         greater = false;
         break;
      }
   }
   bigint *result = new_bigint (greater ? this->size : that->size);
   
   int digit = 0;
   int borrow = 0;
   for (size_t i = 0; i < result->capacity; i++, result->size++) {
      if (i >= that->capacity)
         digit = this->digits[i] - borrow + 10;
      else
         digit = this->digits[i] - that->digits[i] - borrow + 10;
      result->digits[i] = digit % 10;
      borrow = 1 - (digit / 10);
   }
   trim_zeros (result);
   return result;
}

void free_bigint (bigint *this) {
   free (this->digits);
   free (this);
}

void print_bigint (bigint *this, FILE *file) {
   DEBUGS ('b', show_bigint (this));
   if (this->negative) printf("-");
   for (size_t i = 0; i < this->size; i++) {
      if (i%69 == 0 && i != 0) printf ("\\\n");
      fprintf(file, "%d", this->digits[this->size - 1 - i]);
   }
   printf("\n");
}

bigint *add_bigint (bigint *this, bigint *that) {
   DEBUGS ('b', show_bigint (this));
   DEBUGS ('b', show_bigint (that));
   
   bigint *result;
   
  // size_t larger_size = (this->size > that->size 
  //                      ? this->size : that->size);
   size_t smaller_size = (this->size < that->size 
                        ? this->size : that->size);
   bool greater = false;
   for (size_t i = 0; i <= smaller_size; i++) {
      size_t index = smaller_size - 1 - i;
      if (this->digits[index] > that->digits[index]) {
         greater = true;
         break;
      } else if (this->digits[index] < that->digits[index]) {
         greater = false;
         break;
      }
   }

   if((this->negative && !that->negative) 
      || (!this->negative && that->negative)) {
      if (greater) {
         result = do_sub (this, that);
         result->negative = this->negative;
      } else {
         result = do_sub (that, this);
         result->negative = that->negative;
      }
   } else {
      result = do_add (this, that);
      result->negative = this->negative;
   }
   return result;
}

bigint *sub_bigint (bigint *this, bigint *that) {
   DEBUGS ('b', show_bigint (this));
   DEBUGS ('b', show_bigint (that));
   
   bigint *result;
   
  // size_t larger_size = (this->size > that->size 
  //                      ? this->size : that->size);
   size_t smaller_size = (this->size < that->size 
                        ? this->size : that->size);
   bool greater = false;
   for (size_t i = 0; i <= smaller_size; i++) {
      size_t index = smaller_size - 1 - i;
      if (this->digits[index] > that->digits[index]) {
         greater = true;
         break;
      } else if (this->digits[index] < that->digits[index]) {
         greater = false;
         break;
      }
   }
   
   if ((this->negative && !that->negative) 
      || (!this->negative && that->negative)) {
      result = do_add (this, that);
      result->negative = this->negative;
    } else {
      if (this->negative && that->negative) {
         if (greater) {
            result = do_sub(this, that);
            result->negative = true;
         } else {
            result = do_sub (that, this);
            result->negative = false;
         }
      } else {
         if (greater) {
            result = do_sub (this, that);
            result->negative = false;
         } else {
            result = do_sub (that, this);
            result->negative = true;
         }
      }
    }
   return result;
}


bigint *mul_bigint (bigint *this, bigint *that) {
   DEBUGS ('b', show_bigint (this));
   DEBUGS ('b', show_bigint (that));
   
   bigint *result = new_bigint(this->size + that->size);
   int carry = 0;
   int digit = 0;
   for (size_t i = 0; i < this->size; i++) {
      carry = 0;
      for (size_t j = 0; j < that->size; j++) {
         digit = result->digits[i + j] +
                 (this->digits[i]*that->digits[j]) +
                 carry;
         result->digits[i + j] = digit % 10;
         carry = digit / 10;
      }
      result->digits[i + that->size] = carry;
   }
   result->size = this->size + that->size;
   if ((this->negative && !that->negative) 
      || (!this->negative && that->negative)) {
      result->negative = true;
   }
   trim_zeros(result);
   return result;
}

void show_bigint (bigint *this) {
   fprintf (stderr, "bigint@%p->{%lu,%lu,%c,%p->", this,
            this->capacity, this->size, this->negative ? '-' : '+',
            this->digits);
   for (char *byte = &this->digits[this->size - 1];
        byte >= this->digits; --byte) {
      fprintf (stderr, "%d", *byte);
   }
   fprintf (stderr, "}\n");
}

