// Name: Kelly Scanlon
// User: kpscanlo

// $Id: treemap.java,v 1.4 2014-05-07 18:00:19-07 - - $

import static java.lang.System.*;

class treemap <key_t extends Comparable <key_t>, value_t> {

   private class node {
      key_t key;
      value_t value;
      node left;
      node right;
   }
   private node root;

   private void debug_dump_rec (node tree, int depth) {
      if (tree == null) return;
      debug_dump_rec (tree.left, depth + 1);
      for (int i = 0; i < depth; i++) 
         out.printf(" ");
      out.printf("%d %s %s%n", depth, tree.key, tree.value);
      debug_dump_rec (tree.right, depth + 1);
   }

   private void do_visit_rec (visitor <key_t, value_t> visit_fn,
                              node tree) {
      if (tree == null) return;
      do_visit_rec (visit_fn, tree.left);
      visit_fn.visit (tree.key, tree.value);
      do_visit_rec (visit_fn, tree.right);
   }

   public value_t get (key_t key) {
      node curr = root;
      while (curr != null) {
         int cmp = curr.key.compareTo(key);
         if (cmp == 0)
            return curr.value;
         if (cmp < 0)
            curr = curr.right;
         if (cmp > 0)
            curr = curr.left;
      }
      return null;
   }

   public node put_recursive (node curr, key_t key, value_t value) {
      if (curr == null) {
         curr = new node();
         curr.key = key;
         curr.value = value;
         curr.left = null;
         curr.right = null;
      } else if (curr.key.compareTo(key) > 0) {
         curr.left = put_recursive (curr.left, key, value);
      } else if (curr.key.compareTo(key) < 0) {
         curr.right = put_recursive (curr.right, key, value);
      } else {
         curr.value = value;
      }
      return curr;
   }

   public value_t put (key_t key, value_t value) {
      value_t result; 

      result = get (key);
      root = put_recursive (root, key, value);

      return result;
   }

   public void debug_dump () {
      debug_dump_rec (root, 0);
   }

   public void do_visit (visitor <key_t, value_t> visit_fn) {
      do_visit_rec (visit_fn, root);
   }

}
