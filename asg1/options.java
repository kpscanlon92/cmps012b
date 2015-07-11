//Name: Kelly Scanlon
//User: kpscanlo
// $Id: options.java,v 1.3 2014-04-11 12:50:37-07 - - $

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
      //Originally set options flags to 0
      insensitive = false;
      filename_only = false;
      number_lines = false;
      reverse_match = false;

      char flag;
      String arg;
      arg = args[0];
      if(arg.startsWith("-")) {
         //System.out.println("Options Used");
         for(int j = 1; j < arg.length(); j++) {
            flag = arg.charAt(j);
            switch(flag) {
               case 'i':
                  insensitive = true;
                  //System.out.println("Insensitive");
                  break;
               case 'l':
                  filename_only = true;
                  //System.out.println("Filename Only");
                  break;
               case 'n':
                  number_lines = true;
                  //System.out.println("Number Lines");
                  break;
               case 'v':
f                  reverse_match = true;
                  //System.out.println("Reverse Match");
                  break;
               default:
                  err.printf ("Usage: %s [-ilnv] regex [filename...]%n",
                              messages.program_name);
                  break;
            }
         }
         regex = args[1];
         filenames = new String[args.length - 2];
         for(int argi = 2; argi < args.length; argi++) {
            filenames[argi - 2] = args[argi];
         }
      } else {
         //System.out.println("No options used.");
         regex = args[0];
         filenames = new String[args.length - 1];
         for (int argi = 1; argi < args.length; argi++) {
            filenames[argi - 1] = args[argi];
         }
      }
   }
}

