// Name: Kelly Scanlon
// User: kpscanlo

// $Id: dllist.java,v 1.2 2014-04-27 23:10:28-07 - - $
import static java.lang.System.*;

class dllist {

   public enum position {FIRST, PREVIOUS, FOLLOWING, LAST};

   private class node {
      String item;
      node prev;
      node next;
   }

   private node first = null;
   private node current = null;
   private node last = null;
   private int currentposition = 0;

   public void setposition (position pos) {
      switch (pos) {
         case FIRST:
            current = first;
            break;
         case PREVIOUS:
            if (current == first) break;
            current = current.prev;
            break;
         case FOLLOWING:
            if (current == last) break;
            current = current.next;
            break;
         case LAST: 
            current = last;
            break;
         default:
            throw new IllegalArgumentException();
      }
   }

   public boolean isempty () {
      return first == null;
   }

   public String getitem () {
      if(isempty()) {
         throw new java.util.NoSuchElementException();
      }
      return current.item;
   }

   public int getposition () {
      int position = 0;

      if (current == null)
         throw new java.util.NoSuchElementException();
      
      node it = first;

      while (it != current) {
         position++;
         it = it.next;
      }

      currentposition = position;
      return currentposition;
   }

   public void delete () {
      if(current == null) {
         throw new java.util.NoSuchElementException();
      } else if (first == last) {
         first = null;
         last = null;
         current = null;
      } else if (current == first) {
         current = first.next;
         first = current;
         current.prev = null;
      } else if (current == last) {
         current = last.prev;
         last = current;
         current.next = null;
      } else {
         node old_next = current.next;
         node old_prev = current.prev;
         old_prev.next = old_next;
         old_next.prev = old_prev;
         current = old_next;
      }
   }

   public void insert (String item, position pos) {
      node tmp = new node();
      tmp.item = item;
   
      // If empty, set up list with one item
      if(first == null) {
         tmp.prev = null;
         tmp.next = null;
         first = tmp;
         last = tmp;
         current = tmp;
         return;
      }

      switch (pos) {
         case PREVIOUS:
            if(current == first) {
               current.prev = tmp;
               tmp.next = current;
               tmp.prev = null;
               current = tmp;
               first = tmp;
            } else {
               node old_prev = current.prev;
               current.prev = tmp;
               tmp.next = current;
               old_prev.next = tmp;
               tmp.prev = old_prev;
               current = tmp;
            }
            break;
         case FOLLOWING:
            if(current == last) {
               current.next = tmp;
               tmp.next = null;
               tmp.prev = current;
               current = tmp;
               last = tmp;
            } else {
               node old_next = current.next;
               current.next = tmp;
               tmp.prev = current;
               old_next.prev = tmp;
               tmp.next = old_next;
               current = tmp;
            }
            break;
         default:
            throw new IllegalArgumentException();
      }
   }
   
   public void print_list () {
      int line = 0;
      node it = first;
      while (it != null) {
         out.printf("%6d %s%n", line, it.item);
         line++;
         it = it.next;
      }
   }
}

