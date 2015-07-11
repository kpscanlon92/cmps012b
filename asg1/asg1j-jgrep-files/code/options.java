// $Id: options.java,v 1.2 2014-04-02 21:30:12-07 - - $

import static java.lang.System.*;

class options {
   boolean insensitive;
   boolean filename_only;
   boolean number_lines;
   boolean reverse_match;
   String regex;
   String[] filenames;

   options (String[] args) {
      if (args.length == 0) { 
         err.printf ("Usage: %s [-ilnv] regex [filename...]%n",
                     messages.program_name);
         exit (messages.EXIT_FAILURE);
      }
      regex = args[0];
      filenames = new String[args.length - 1];
      for (int argi = 1; argi < args.length; ++argi) {
         filenames[argi - 1] = args[argi];
      }
   }
}

