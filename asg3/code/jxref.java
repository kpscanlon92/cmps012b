// Name: Kelly Scanlon
// User: kpscanlo
// $Id: jxref.java,v 1.5 2014-05-07 17:51:11-07 - - $

import java.io.*;
import java.util.Scanner;
import static java.lang.System.*;

class jxref {
   static final String STDIN_NAME = "-";

   static boolean debug = false;
   static boolean lower_case = false;
  
   static int options (String arg) {
      char flag;
      if (arg.startsWith("-")) {
         for (int i = 1; i < arg.length(); i++) {
            flag = arg.charAt(i);
            switch (flag) {
               case 'd':
                  debug = true;
                  break;
               case 'f':
                  lower_case = true;
                  break;
               default:
                  auxlib.usage_exit("[-df] [filename...]");
                  break;
            }
         }
         return 1;
      } else {
         return 0;
      }
   }

   static class printer implements visitor <String, queue <Integer>> {
      public void visit (String key, queue <Integer> value) {
         out.printf ("%s %s", key, value);
         for (int linenr: value) out.printf (" %d", linenr);
         out.printf ("%n");
      }
   }

   static void xref_file (String filename, Scanner scan) {
      out.printf("%n");
      for (int i = 0; i < 72; i++) 
         out.printf(":");
      out.printf("%n%s%n", filename);
      for (int i = 0; i < 72; i++)
         out.printf(":");
      out.printf("%n%n");


      treemap <String, queue <Integer>> map =
            new treemap <String, queue <Integer>> ();
      for (int linenr = 1; scan.hasNextLine (); ++linenr) {
         for (String word: scan.nextLine().split ("\\W+")) {
            if (word.matches ("^\\d*$")) continue;
            if (lower_case == true)
               word = word.toLowerCase();
            queue <Integer> qget = map.get(word);
            if (qget != null) {
               qget.insert(linenr);
            } else {
               queue <Integer> newq = new queue <Integer> ();
               newq.insert(linenr);
               map.put(word, newq);
            }
         }
      }
      if (debug == true) {
         map.debug_dump();
      } else {
         visitor <String, queue <Integer>> print_fn = new printer ();
         map.do_visit (print_fn);
      }
   }

   public static void main (String[] args) {
      if (args.length == 0) {
         xref_file (STDIN_NAME, new Scanner (in));
      }else {
         int options_found = options (args[0]);
         for (int argi = 0 + options_found; argi < args.length; ++argi) {
            String filename = args[argi];
            if (filename.equals (STDIN_NAME)) {
               xref_file (STDIN_NAME, new Scanner (in));
            }else {
               try {
                  Scanner scan = new Scanner (new File (filename));
                  xref_file (filename, scan);
                  scan.close ();
               }catch (IOException error) {
                  auxlib.warn (error.getMessage ());
               }
            }
         }
      }
      auxlib.exit ();
   }

}

